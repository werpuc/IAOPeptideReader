#' IAOReader UI
#'
#' <ToDo>
#'
#' @import shiny
user_interface <- function() {
    shiny::fluidPage(

        # Including CSS theme and JS scripts.
        shiny::includeCSS(get_file_path("HaDeX_theme.css")),
        shiny::includeScript(get_file_path("plot.js")),

        sidebar(),
        mainPanel(
            class = "scrollable",
            uiOutput("results")
        )
    )
}
