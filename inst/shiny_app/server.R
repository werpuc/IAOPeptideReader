source(file.path("server", "data_preview.R"), local = TRUE, chdir = TRUE)
source(file.path("server", "plot_settings.R"), local = TRUE, chdir = TRUE)
source(file.path("server", "input_settings.R"), local = TRUE, chdir = TRUE)


# Main server function ---------------------------------------------------------
server <- function(input, output, session) {
    data_preview(input, output, session)
    plot_settings(input, output, session)
    input_settings(input, output, session)


    output[["plot"]] <- renderPlot({
        shinipsum::random_ggplot("dot")
    })


    # TODO: update with real statistics.
    output[["summary_table"]] <- renderTable({
        shinipsum::random_table(3, 8)
    })
}
