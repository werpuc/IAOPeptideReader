source(file.path("server", "plot_settings.R"), local = TRUE, chdir = TRUE)
source(file.path("server", "input_settings.R"), local = TRUE, chdir = TRUE)


# Main server function ---------------------------------------------------------
server <- function(input, output, session) {

    # Poke the handler to initialize the iaoreader JS variable with a new
    # IAOReader class object. The 1 is sent because something has to be sent
    # for the handler to work.
    session$sendCustomMessage("initialize_iaoreader", 1)

    plot_settings(input, output, session)
    input_settings(input, output, session)

    # TODO: update with real statistics.
    output[["summary_table"]] <- renderTable({
        shinipsum::random_table(3, 8)
    })
}
