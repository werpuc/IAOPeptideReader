#' @title Run IAO Reader App
#'
#' @description This function is responsible for starting the core application
#'  of this package. The application itself is located inside the
#'  \code{iaoreader} package files.
#' 
#' @param port a port on which the Shiny application will be hosted.
#' 
#' @rawNamespace import(shiny, except = c(dataTableOutput, renderDataTable))
#' @importFrom DT dataTableOutput renderDataTable
#' @importFrom data.table fread rbindlist
#'
#' @export
run_shiny_app <- function(port = 8080) {
    ui_path <- system.file("shiny_app", "ui.R", package = "iaoreader")
    server_path <- system.file("shiny_app", "server.R", package = "iaoreader")
    www_path <- system.file("shiny_app", "www", package = "iaoreader")

    if (ui_path == "" || server_path == "" || www_path == "") {
        stop(
            paste(
                "Internal package files are missing.",
                "Consider re-installing the iaoreader package."
            ),
            call. = FALSE
        )
    }

    # Note: sourcing those files allows avoiding namespace issues. If the app
    #       would be run directly with:
    #           runApp(system.file("shiny_app", package = "iaoreader"))
    #       then the functions imported by the package could not be used within
    #       the application due to the Shiny creating its own namespace.
    #       By sourcing those files all functions imported by the package are
    #       available withing the application.
    source(ui_path, local = TRUE, chdir = TRUE)
    source(server_path, local = TRUE, chdir = TRUE)

    # Manually attaching the resources to /www static URL.
    addResourcePath("www", www_path)
    app <- shinyApp(ui(), server)

    runApp(app, port)
}
