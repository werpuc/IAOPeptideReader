#' Run shiny application
#'
#' This is a master function used to start an application implemented by this
#' package.
#'
#' @param launch_browser ...
#' @param port ...
#'
#' @import shiny
#' @importFrom magrittr %>%
#'
#' @export
runApp <- function(launch_browser = FALSE, port = 8080) {
    shinyApp(user_interface(), shiny_server,
             options = c("port" = port, "launch.browser" = launch_browser))
}
