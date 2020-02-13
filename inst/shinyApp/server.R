server <- function(input, output, session) {
    output[["plot"]] <- renderPlot({
        shinipsum::random_ggplot("dot")
    })


    # TODO: update with real statistics.
    output[["summary_table"]] <- renderTable({
        shinipsum::random_table(3, 8)
    })


    # TODO: update with uploaded files' names.
    updateSelectInput(session, "previewed_file", choices = c(
        "File_1", "File_2", "File_with_a_really_long_name_which_could_possibly_make_selectInput_ugly."))
}
