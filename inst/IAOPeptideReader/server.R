source(file.path("server", "plot_settings.R"), local = TRUE, chdir = TRUE)
source(file.path("server", "input_settings.R"), local = TRUE, chdir = TRUE)
source(file.path("server", "modals.R"), local = TRUE, chdir = TRUE)


# Main server function ---------------------------------------------------------
server <- function(input, output, session) {

    # Poke the handler to initialize the iaoreader JS variable with a new
    # IAOPeptideReader class object. The 1 is sent because something has to be
    # sent for the handler to work.
    session$sendCustomMessage("initialize_iaoreader", 1)

    plot_settings(input, output, session)
    input_settings(input, output, session)
    modals(input, output, session)

    observeEvent(input[["download_svg"]], {
        session$sendCustomMessage("download_svg", 1)
    }, ignoreInit = TRUE)
}
