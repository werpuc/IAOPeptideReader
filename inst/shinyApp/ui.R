source(file.path("ui", "MainPanel.R"), local = TRUE)
source(file.path("ui", "SidebarPanel.R"), local = TRUE)

# TODO: remove when mocks won't be needed.
if (!nchar(system.file(package = "shinipsum"))) {
    stop(paste("shinipsum package is required for mocks.",
               "remotes::install_github('Thinkr-open/shinipsum')", sep = "\n"))
}


# Main UI function -------------------------------------------------------------
ui_func <- function() {
    fluidPage(
        attach_css("iaoreader_theme.css"),
        attach_css("HaDeX_theme.css"),
        sidebar_panel(),
        main_panel()
    )
}


# Global UI utilities ----------------------------------------------------------
attach_css <- function(cssPath) {
    tags$head(
        tags$link(href = cssPath, rel = "stylesheet")
    )
}


# Calling the UI at the end of the script allows top-bottom structure.
# If UI would not be wrapped in a function then an error would be thrown due to
# the utilities functions being used before their definition.
ui <- ui_func()

