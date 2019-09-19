#' Run IAOReader application
#'
#' This is a master function used to start an application implemented by this
#' package.
#'
#' @import shiny
#' @importFrom magrittr %>%
#'
#' @export
runApp <- function() {
    shinyApp(user_interface(), shiny_server)
}
