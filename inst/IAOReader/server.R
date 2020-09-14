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

    observeEvent(input[["download_svg"]], {
        session$sendCustomMessage("download_svg", 1)
    }, ignoreInit = TRUE)

    observeEvent(input[["file_info"]], {
        modal <- modalDialog(
            title = h2(
                class = "modal_title",
                "IAO Reader Input Files' Structure"
            ),
            easyClose = TRUE
        )
        showModal(modal)
    })
}
