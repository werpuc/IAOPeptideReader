input_summary_row_ui <- function(single_file_input_meta) {
    input_id <- single_file_input_meta[["input_id"]]
    row_class <- "import_summary_row"
    if (!single_file_input_meta[["is_ok"]]) {
        row_class <- c(row_class, "error")
    }

    # TODO: disable inputs and pass errors to the user.
    tags$tr(
        class = paste(row_class, collapse = " "),
        tags$td(single_file_input_meta[["file_name"]]),
        tags$td(single_file_input_meta[["sequence_length"]]),
        tags$td(selectInput(sprintf("%s_protein", input_id), NULL, NULL)),
        tags$td(selectInput(sprintf("%s_state", input_id), NULL, NULL)),
        tags$td(actionButton(sprintf("%s_delete", input_id), "Delete"))
    )
}


input_summary_row_server <- function(single_file_input_meta) {
    # TODO: implement this.
}
