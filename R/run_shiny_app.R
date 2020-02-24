#' @title Run IAO Reader App
#'
#' @description This function is responsible for starting the core application
#'  of this package. The application itself is located inside the
#'  \code{iaoreader} package files.
#' 
#' @param port a port on which the Shiny application will be hosted.
#' 
#' @import shiny
#' @importFrom DT dataTableOutput renderDataTable
#'
#' @export
run_shiny_app <- function(port = 8080) {
    app_Path <- system.file("shiny_App", package = "iaoreader")

    if (app_path == "") {
        stop(paste("Internal package files are missing.",
                   "Consider re-installing the iaoreader package."))
    }

    runApp(app_path, port)
}
