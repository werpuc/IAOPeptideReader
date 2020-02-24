source(file.path("server", "data_preview.R"), local = TRUE, chdir = TRUE)


# Main server function ---------------------------------------------------------
server <- function(input, output, session) {
    data_preview(input, output, session)


    output[["plot"]] <- renderPlot({
        shinipsum::random_ggplot("dot")
    })


    # TODO: update with real statistics.
    output[["summary_table"]] <- renderTable({
        shinipsum::random_table(3, 8)
    })
}
