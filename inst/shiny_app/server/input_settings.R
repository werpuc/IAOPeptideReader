input_settings <- function(input, output, session) {
    files_meta <- reactive({
        res <- list()
        file_input_meta <- input[["file_upload"]]

        for (i in 1:nrow(upload_meta)) {
            single_file_input_meta <- file_input_meta[i, , drop = FALSE]
            file_name <- single_file_input_meta[["filename"]]
            file_path <- single_file_input_meta[["datapath"]]

            single_res <- list(
                "is_ok" = NULL,
                "error_messages" = NULL,
                "sequence_length" = NULL,
                "protein_state_mapping" = NULL
            )

            single_file_data <- fread(file_name) # TODO: tryCatch this.
            single_res[1:2] <- verify_iao_data(single_file_data)
            if (single_res[["is_ok"]]) {
               # sequence_length
               # protein_state_mapping
            }

            res[[file_name]] <- single_res
        }

        res
    })    

    # TODO: import summary table generation from the files_meta (clear the meta after generating the table?).
    # TODO: delete button observers and state upadters generation.
}
