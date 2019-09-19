shiny_server <- function(input, output, session) {

    # Files upload -------------------------------------------------------------

    # Variable holding all relevant information about files uploaded by a user.
    input_data <- reactiveValues(uploaded = 0, names = c(), paths = c(),
                                 data = list(), ambiguities = list(),
                                 seq_length = 0)

    # Updating uploaded files reactiveValues.
    observeEvent(input[["files_input"]], {
        new_files <- input[["files_input"]]

        new_files_ids <- input_data$uploaded + new_files$datapath %>% seq_along

        # Update the number of uploaded files.
        input_data$uploaded <- input_data$uploaded + nrow(new_files)

        # Append new file names (names on user's side).
        input_data$names[new_files_ids] <- new_files$name # <ToDo> check files' names

        # Append new local server paths to the data.
        input_data$paths[new_files_ids] <- new_files$datapath

        files_meta <- lapply(new_files$datapath, load_data)

        # Load and save only relevant data from the files.
        input_data$data[new_files_ids] <- files_meta_get(files_meta,
                                                         "Dataframe")

        # Get file ambiuigies in terms of (protein, state) combinations.
        input_data$ambiguities[new_files_ids] <- files_meta_get(files_meta,
                                                                "Combinations")

        # Compare a currently saved sequence length and the one read from files
        # and save a higher value.
        input_data$seq_length <- files_meta_get(files_meta, "MaxSeqLength") %>%
            unlist() %>% max(input_data$seq_length)
    })

    # Structure holding ids of files which contain an ambiguity.
    ambiguities <- reactive({
        if (input_data$uploaded > 0) {
            input_data$ambiguities %>% sapply(function(x) !is.null(x)) %>% which
        }
    })

    # Output for conditionalPanel in the sidebar displaying detailed settings.
    output[["files_uploaded"]] <- reactive(input_data$uploaded > 0)
    outputOptions(output, "files_uploaded", suspendWhenHidden = FALSE)

    # # Output for conditionalPanel in the sidebar displaying selectInputs for
    # # selecting a (protein, state) combination.
    output[["files_ambiguity"]] <- reactive(ambiguities() %>% length > 0)
    outputOptions(output, "files_ambiguity", suspendWhenHidden = FALSE)


    # Detailed settings --------------------------------------------------------

    # <ToDo>
    # # Part of the sidebar responsible for specifying (protein, state)
    # # combination if there are multiple present in a single file.
    # settings_ambiguity <- reactive({
    #     conditionalPanel("output.files_ambiguity",
    #         br(),
    #         h4("Specify protein and state"),
    #         sapply(1:input_data$uploaded, function(i)
    #             if (i %in% ambiguities()) {
    #                 selectInput(paste0("files_settings_ambiguity_", i),
    #                             label = input_data$names[[i]],
    #                             choices = input_data$ambiguities[[i]])
    #             }
    #         )
    #     )
    # })

    # <ToDo: comments>
    observeEvent(input_data$uploaded, {
        input_value <- input[["sequence_length"]]
        print(input_value)
        if (input_value %in% c(NA, 0)) {
            input_value <- input_data$seq_length
        }
        updateNumericInput(session, "sequence_length",
                           value = input_value)
    })

    output[["sequence_length_files"]] <- renderText(
        sprintf("Maximum sequence length in files: %d", input_data$seq_length)
    )


    # Data preview -------------------------------------------------------------

    # <ToDo: comments>
    output[["data_preview_df"]] <- DT::renderDataTable(
        get_data(input_data, input[["data_preview_select"]])
    )

    observeEvent(input_data$uploaded, {
        # <ToDo: order of upload or alphabetical order?>
        # <ToDo> Expand vertically for all names to fit
        input_value <- input[["data_preview_select"]]
        # Select a first option on a first upload.
        if (input_value == "") {
            input_value <- sort(input_data$names)[1]
        }
        updateSelectInput(session, "data_preview_select",
                          choices = sort(input_data$names),
                          selected = input_value)
    })
}
