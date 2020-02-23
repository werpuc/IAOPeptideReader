# Data Preview server function -------------------------------------------------
data_preview <- function(input, output, session) {
    mock_file_names <- reactive({
        c("File_1", "File_2", "File_with_a_really_long_name_which_could_possibly_make_selectInput_ugly.")
    })


    # TODO: update with uploaded files' names.
    updateSelectInput(session, "previewed_file",
                      choices = isolate(mock_file_names()))
}
