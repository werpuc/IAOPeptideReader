server <- function(input, output, session) {
    output[["plot"]] <- renderPlot({
        shinipsum::random_ggplot("dot")
    })


    # TODO: update with real statistics.
    output[["summary_table"]] <- renderTable({
        shinipsum::random_table(3, 8)
    })
}
