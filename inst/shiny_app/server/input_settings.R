# Input settings server function -----------------------------------------------
input_settings <- function(input, output, session) {

    # Output for the conditionalPanel ------------------------------------------
    output[["files_uploaded"]] <- reactive({
        req(input[["files_upload"]])
        TRUE
    })
    outputOptions(output, "files_uploaded", suspendWhenHidden = FALSE)


    # Uploaded files meta information ------------------------------------------
    files_meta <- reactive({
        res <- list()
        file_input_meta <- input[["files_upload"]]
        req(file_input_meta)

        for (i in 1:nrow(file_input_meta)) {
            single_file_input_meta <- file_input_meta[i, , drop = FALSE]
            file_name <- single_file_input_meta[["name"]]
            file_path <- single_file_input_meta[["datapath"]]

            single_res <- list(
                "input_id" = sprintf("is_row%d", i),
                "file_name" = file_name,
                "is_ok" = NULL,
                "error_messages" = NULL,
                "sequence_length" = NULL,
                "protein_state_mapping" = NULL
            )

            single_file_data <- fread(file_path) # TODO: tryCatch this.
            single_res[c("is_ok", "error_messages")] <- verify_iao_data(single_file_data)
            if (single_res[["is_ok"]]) {
               single_res[["sequence_length"]] <- max(single_file_data[["End"]])
               # protein_state_mapping
            }

            res[[file_name]] <- single_res
        }

        res
    })


    # Max sequence length ------------------------------------------------------
    sequence_max_length <- reactive({
        # Note: sapply does not work (unlist) correctly when one of the results
        #       is NULL. Hence the lapply & unlist combination is used.
        seq_lenghts <- unlist(
            lapply(
                files_meta(),
                function(sfim) sfim[["sequence_length"]]
            )
        )

        # TODO: handle case when there is no correct file and max returns -Inf.
        max(seq_lenghts) 
    })

    # TODO: debug mysterious error with this updater.
    # updateNumericInput(
    #     session, "sequence_length", value = isolate(sequence_max_length()))


    output[["sequence_length_max"]] <- renderText({
        sprintf(
            "Maximum sequence length read from files: %d.",
            sequence_max_length()
        )
    })


    # Import summary table UI --------------------------------------------------
    output[["input_summary_table"]] <- renderUI({
        tags$table(
            tags$thead(
                tags$tr(
                    lapply(
                        c("File Name", "Sequence Length", "Protein", "State", ""),
                        tags$td,
                        style = "width: 20%;"
                    )
                )
            ),
            tags$tbody(
                lapply(
                    files_meta(),
                    function(sfim) {
                        # TODO: server generating function.
                        input_summary_row_ui(sfim)
                    }
                )
            )
        )
    })
    # TODO: import summary table generation from the files_meta (clear the meta after generating the table?).
    # TODO: delete button observers and state upadters generation.
}
