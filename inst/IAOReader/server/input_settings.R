source("data_preview.R", local = TRUE)


# Input settings server function -----------------------------------------------
input_settings <- function(input, output, session) {
    data_preview(input, output, session, input_settings_rv, any_file_good)

    input_settings_rv <- reactiveValues(
        "fm" = list(), "obs" = list(), "data" = list(), "seq_max_len" = -Inf
    )


    # Outputs for the conditionalPanel -----------------------------------------
    files_uploaded <- reactive(length(input_settings_rv[["fm"]]) > 0)
    output[["files_uploaded"]] <- files_uploaded
    outputOptions(output, "files_uploaded", suspendWhenHidden = FALSE)

    any_file_good <- reactive(any(is_okay_values()))
    output[["any_file_good"]] <- any_file_good
    outputOptions(output, "any_file_good", suspendWhenHidden = FALSE)

    output[["any_file_bad"]] <- reactive(!all(is_okay_values()))
    outputOptions(output, "any_file_bad", suspendWhenHidden = FALSE)


    # Uploaded files meta information ------------------------------------------
    files_meta <- reactive({
        req(files_uploaded())
        fm <- isolate(input_settings_rv[["fm"]])
        fm[order(names(fm))]
    })
    
    observeEvent(input[["files_upload"]], {
        file_input_meta <- input[["files_upload"]]

        # This allows programatically imitating upload of sample data.
        if (class(file_input_meta) != "data.frame" && file_input_meta == -1) {
            file_input_meta <- sample_fim()
        }

        req(file_input_meta)

        input_settings_rv[["fm"]] <- list()
        input_settings_rv[["data"]] <- list()
        seq_max_len <- -Inf

        for (i in 1:nrow(file_input_meta)) {
            single_file_input_meta <- file_input_meta[i, , drop = FALSE]
            file_name <- single_file_input_meta[["name"]]
            file_path <- single_file_input_meta[["datapath"]]

            single_res <- list(
                "input_id" = sprintf("IS_row_%s", file_name),
                "file_name" = file_name,
                "is_ok" = FALSE,
                "error_messages" = NULL,
                "sequence_length" = NULL,
                "protein_state_mapping" = NULL,
                "selected_protein" = NULL,
                "selected_state" = NULL,
                "display" = TRUE
            )

            # Simple check whether the file has correct extension.
            if (!grepl("\\.csv$", file_path)) {
                single_res[["error_messages"]] <- "The file does not have a '.csv' extension."
            } else {
                # Proceed to read the file if its CSV.
                tryCatch({
                    single_file_data <- fread(file_path)
                    single_res[c("is_ok", "error_messages")] <- verify_iao_data(single_file_data)
                }, error = function(e) {
                    # The <<- operator allows assigning the value outside
                    # the error handling function.
                    single_res[["error_messages"]] <<- paste(
                        "An error occurred during reading this file:", e$message
                    )
                })
            }

            # Retrieving information from correct files.
            if (single_res[["is_ok"]]) {
                seq_len <- max(single_file_data[["End"]])
                seq_max_len <- max(seq_max_len, seq_len)

                single_res[["sequence_length"]] <- seq_len
                single_res[["protein_state_mapping"]] <- read_protein_state_mapping(single_file_data)

                input_settings_rv[["data"]][[file_name]] <- single_file_data[, .(Protein, State, Start, End)]
            }

            input_settings_rv[["fm"]][[file_name]] <- single_res
        }

        input_settings_rv[["seq_max_len"]] <- seq_max_len
        updateNumericInput(session, "sequence_length", value = seq_max_len)
    })

    is_okay_values <- reactive({
        sapply(files_meta(), `[[`, "is_ok")
    })


    # Max sequence length output -----------------------------------------------
    output[["sequence_length_max"]] <- renderText({
        req(any_file_good())

        sprintf(
            "Read from files: %d.",
            max(unlist(lapply(isolate(files_meta()), `[[`, "sequence_length")))
        )
    })

    output[["sequence_length_max_displayed"]] <- renderText({
        req(any_file_good())

        displayed_seq_len <- -Inf
        for (sfim in files_meta()) {
            if (sfim[["is_ok"]] && sfim[["display"]]) {
                displayed_seq_len <- max(
                    displayed_seq_len,
                    sfim[["sequence_length"]]
                )
            }
        }

        sprintf(
            "Currently displayed: %s.",
            if (displayed_seq_len == -Inf) "<i>none</i>" else displayed_seq_len
        )
    })


    # Sequence length input ----------------------------------------------------
    is_seq_len_ok <- reactive(is_positive_integer(input[["sequence_length"]]))

    observe({
        is_ok <- is_seq_len_ok()

        # Sending is_ok to seq_len_check handler which turns on and off the red
        # border around sequence length input. 
        session$sendCustomMessage("seq_len_check", is_ok)

        if (is_ok) {
            session$sendCustomMessage(
                "update_seq_len",
                isolate(input[["sequence_length"]])
            )
        }
    })


    # Import summary table UI --------------------------------------------------
    output[["input_summary_table"]] <- renderUI({
        tags$table(
            tags$thead(
                tags$tr(
                    lapply(
                        c("File Name", "Seq. Length", "Protein", "State", "Display"),
                        tags$td
                    )
                )
            ),
            tags$tbody(
                lapply(files_meta(), input_summary_row_ui)
            )
        )
    })

    # The server is created separately because we don't want to re-create
    # observes with every deletion. Additionally, it destroys every already
    # existing observer to prevent stacking them infinitely and clears current
    # list before saving new observers.
    observeEvent(input[["files_upload"]], {
        lapply(input_settings_rv[["obs"]], function(obs) obs$destroy())

        input_settings_rv[["obs"]] <- list()

        lapply(
            files_meta(),
            function(sfim) {
                input_summary_row_server(sfim, input, session, input_settings_rv)
            }
        )
    })


    # Preparing data for the plot ----------------------------------------------
    observe({
        req(any_file_good())

        res <- list()
        for (sfim in isolate(files_meta())) {
            if (!sfim[["is_ok"]]) next

            file_name <- sfim[["file_name"]]
            input_id <- sfim[["input_id"]]
            protein_id <- sprintf("%s_protein", input_id)
            state_id <- sprintf("%s_state", input_id)

            protein <- input[[protein_id]]
            state <- input[[state_id]]

            # If the inputs did not load yet retry after 1 second.
            if (!isTruthy(protein) || !isTruthy(state)) {
                invalidateLater(1 * 1000)
                return()
            }

            current_data <- input_settings_rv[["data"]][[file_name]]
            data_filtered <- current_data[Protein == protein & State == state]
            data_filtered[, FileName := file_name]

            res[[file_name]] <- data_filtered
        }

        session$sendCustomMessage(
            "update_data", unique(rbindlist(res))[, .(Start, End, FileName)])
    })


    # Summary table ------------------------------------------------------------
    # Note: debouncing allows the calculation to finish in time. Therefore, it
    #       ensures that the table is up to date.
    summary_table_listener <- debounce(millis = 150, reactive({
        input[["plot_settings_k_parameter"]]
        any_file_good()
    }))

    observeEvent(summary_table_listener(), {
        req(any_file_good())

        session$sendCustomMessage("update_plot", 1)
    })

    # TODO: fix the table display when there are no files currently visible.
    output[["summary_table"]] <- renderTable(align = "c", {
        summary_table_data <- input[["summary_table"]]

        req(summary_table_data)
        summary_table <- parse_lambda_values(summary_table_data)
        cbind("File Name" = rownames(summary_table), summary_table)
    })
}


# This function creates files input meta for sample files.
sample_fim <- function() {
    file_names <- c(
        sprintf("example_data%d.csv", 1:2),
        sprintf("incorrect_data%d.csv", 1:3)
    )

    data.frame(
        "name" = file_names,
        "datapath" = paste0("./dev/data/",  file_names), 
        stringsAsFactors = FALSE
    )
}
