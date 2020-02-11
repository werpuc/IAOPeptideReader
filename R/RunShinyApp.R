#' @title Run IAO Reader App
#'
#' @description This function is responsible for starting the core application
#'  of this package. The application itself is located inside the
#'  \code{iaoreader} package files.
#' 
#' @param port a port on which the Shiny application will be hosted.
#' 
#' @import shiny
#'
#' @export
run_shiny_app <- function(port = 8080) {
    appPath <- system.file("shinyApp", package = "iaoreader")

    if (appPath == "") {
        stop(paste("Internal package files are missing.",
                   "Consider re-installing the iaoreader package."))
    }

    runApp(appPath, port)
}
