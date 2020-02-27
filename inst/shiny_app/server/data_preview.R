# Data Preview server function -------------------------------------------------
data_preview <- function(input, output, session) {
    mock_file_names <- reactive({
        c("File_1", "File_2", "File_with_a_really_long_name_which_could_possibly_make_selectInput_ugly.")
    })


    # TODO: update with uploaded files' names.
    updateSelectInput(session, "previewed_file",
                      choices = isolate(mock_file_names()))


    # TODO: update the table with selected uploaded file.
    # TODO: format the table to handle data with large number of columns.
    # TODO: customize the table.
    output[["data_preview"]] <- DT::renderDataTable({
        iris
    })
}
