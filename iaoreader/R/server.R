# Main Shiny server function.
shiny_server <- function(input, output, session) {

    # Variable holding all relevant information about files uploaded by a user.
    input_data <- reactiveValues(uploaded = 0, names = c(), paths = c(),
                                 data = list(), ambiguities = list(),
                                 seq_length = 0)

    # A files upload. ----------------------------------------------------------

    # Receiving uploaded files and parsing relevant information to input_data.
    observeEvent(input[["files_input"]], {
        new_files <- input[["files_input"]]

        new_files_ids <- input_data$uploaded + new_files$datapath %>% seq_along

        # Update a number of uploaded files.
        input_data$uploaded <- input_data$uploaded + nrow(new_files)

        # Append new file names (names of files on a user's side).
        input_data$names[new_files_ids] <- new_files$name

        # Append new local server paths to the data.
        input_data$paths[new_files_ids] <- new_files$datapath

        files_meta <- lapply(new_files$datapath, load_data)

        # Saving dataframes.
        input_data$data[new_files_ids] <- files_meta_get(files_meta,
                                                         "Dataframe")

        # Saving (protein, state) combinations.
        input_data$ambiguities[new_files_ids] <- files_meta_get(files_meta,
                                                                "Combinations")

        # Saving a maximum sequence length for each file.
        input_data$seq_length <- files_meta_get(files_meta, "MaxSeqLength") %>%
            unlist() %>% max(input_data$seq_length)
    })

    # Structure holding ids of files for which user should specify the
    # (protein, state) combination.
    ambiguities <- reactive({
        if (input_data$uploaded > 0) {
            input_data$ambiguities %>% sapply(function(x) !is.null(x)) %>% which
        }
    })

    # A table listing uploaded files' names.
    output[["files_names"]] <- renderTable({
        data.frame(seq_along(input_data$names), input_data$names)
    })


    # Variables for conditionalPanels. -----------------------------------------

    # Output for a conditionalPanel displaying a fileInput.
    output[["files_under_limit"]] <- reactive(input_data$uploaded < 10)
    outputOptions(output, "files_under_limit", suspendWhenHidden = FALSE)

    # Output for a conditionalPanel containing files' detailed settings.
    output[["files_uploaded"]] <- reactive(input_data$uploaded > 0)
    outputOptions(output, "files_uploaded", suspendWhenHidden = FALSE)

    # Output for a conditionalPanel displaying selectInputs for selecting
    # the (protein, state) combination.
    output[["files_ambiguity"]] <- reactive(ambiguities() %>% length > 0)
    outputOptions(output, "files_ambiguity", suspendWhenHidden = FALSE)


    # Detailed settings --------------------------------------------------------

    # Part of the sidebar responsible for specifying (protein, state)
    # combinations for each file where multiple combinations are present.
    # Using a reactive allows easy plot updates after the user changes an input.
    files_settings_ambiguity <- reactive({
        lapply(ambiguities(),
               function(i) {
                   selectInput(ambi_input(i),
                               label = input_data$names[[i]],
                               choices = input_data$ambiguities[[i]],
                               selected = input[[ambi_input(i)]])
        })
    })

    output[["files_settings_ambiguity"]] <- renderUI(files_settings_ambiguity())

    # Setting the initial sequence length value to the one read from files.
    # On subsequent uploads preserving a user's input.
    observeEvent(input_data$uploaded, {
        current_value <- input[["sequence_length"]]

        if (current_value %in% c(NA, 0)) {
            current_value <- input_data$seq_length
        }

        updateNumericInput(session, "sequence_length",
                           value = current_value)
    })

    # An information about maximum sequence length read from files.
    output[["sequence_length_files"]] <- renderText(
        sprintf("Maximum sequence length in files: %d", input_data$seq_length)
    )


    # Data preview -------------------------------------------------------------

    # Updating a selectInput for data preview with newly uploaded files' names
    # while keeping previously selected value.
    observeEvent(input_data$uploaded, {
        current_value <- input[["data_preview_select"]]

        if (current_value == "") {
            current_value <- sort(input_data$names)[1]
        }

        updateSelectInput(session, "data_preview_select",
                          choices = sort(input_data$names),
                          selected = current_value)
    })

    output[["data_preview_df"]] <- DT::renderDataTable(
        get_data(input_data, input[["data_preview_select"]])
    )


    # Plot ---------------------------------------------------------------------

    # Function returns the data corresponding to given file_id and preparesrequired by JS plot
    get_data_for_plot <- function(file_id) {
        df <- get_data(input_data, input_data$names[file_id])
        prepare_for_plot(df, input[[ambi_input(file_id)]])
    }

    # Reactive holding current plot settings (customization).
    plot_settings <- reactive({
        settings_names <- default_plot_settings() %>% names
        settings_names %>%
            lapply(function(n) input[[n]]) %>% setNames(settings_names)
    })

    # Reactive responsible for triggering JS plot update.
    plot_update <- reactive({
        paste(
            input_data$uploaded,        # New files upload (inital upload).
            files_settings_ambiguity(), # Changing the (protein, state) selected.
            plot_settings()             # Modifying the plot settings.
        )
    })

    # ...
    observeEvent(plot_update(), {
        if (input_data$uploaded > 0) {
            file_id <- 1

            js_names <- list(
                input_data$names[[file_id]]
            )
            js_data <- list(
                get_data_for_plot(file_id)
            )

            plot_data <- list(
                file_names = js_names,
                data = js_data,
                plot_settings = plot_settings()
            )

            session$sendCustomMessage(type = 'plot_draw', plot_data)
        }
    })
}
