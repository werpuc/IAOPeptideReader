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
        req(file_input_meta)

        input_settings_rv[["fm"]] <- list()
        input_settings_rv[["data"]] <- list()
        input_settings_rv[["obs"]] <- list()
        seq_max_len <- -Inf

        for (i in 1:nrow(file_input_meta)) {
            single_file_input_meta <- file_input_meta[i, , drop = FALSE]
            file_name <- single_file_input_meta[["name"]]
            file_path <- single_file_input_meta[["datapath"]]

            single_res <- list(
                "input_id" = sprintf("IS_row%d", i),
                "file_name" = file_name,
                "is_ok" = NULL,
                "error_messages" = NULL,
                "sequence_length" = NULL,
                "protein_state_mapping" = NULL,
                "selected_protein" = NULL,
                "selected_state" = NULL
            )

            single_file_data <- fread(file_path) # TODO: tryCatch this.
            single_res[c("is_ok", "error_messages")] <- verify_iao_data(single_file_data)
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

        # Something has to be sent.
        session$sendCustomMessage("draw_canvas", 1)
    })

    is_okay_values <- reactive({
        sapply(files_meta(), `[[`, "is_ok")
    })


    # Max sequence length output -----------------------------------------------
    output[["sequence_length_max"]] <- renderText({
        req(any_file_good())

        sprintf(
            "Maximum sequence length read from files: %d.",
            max(unlist(lapply(isolate(files_meta()), `[[`, "sequence_length")))
        )
    })


    # Verifying sequence length input -------------------------------------------
    observe({
        session$sendCustomMessage(
            "seq_len_check", is_positive_integer(input[["sequence_length"]])
        )
    })


    # Import summary table UI --------------------------------------------------
    output[["input_summary_table"]] <- renderUI({
        tags$table(
            tags$thead(
                tags$tr(
                    lapply(
                        c("File Name", "Seq. Length", "Protein", "State"),
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
    # existing observer to prevent stacking them infinitely.
    observeEvent(input[["files_upload"]], {
        lapply(input_settings_rv[["obs"]], function(obs) obs$destroy())

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

        # TODO: reduce the amount of data sent to JS (Start, End and FileName should suffice).
        session$sendCustomMessage("update_data", unique(rbindlist(res)))
    })
}
