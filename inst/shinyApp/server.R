server <- function(input, output, session) {
    output[["plot"]] <- renderPlot(
        shinipsum::random_ggplot("dot")
    )
}
