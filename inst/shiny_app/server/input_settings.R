# Input settings server function -----------------------------------------------
input_settings <- function(input, output, session) {

    # Uploaded files meta information ------------------------------------------
    files_meta <- reactive({
        res <- list()
        file_input_meta <- input[["file_upload"]]
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
               # sequence_length
               # protein_state_mapping
            }

            res[[file_name]] <- single_res
        }

        res
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
