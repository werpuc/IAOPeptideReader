source(file.path("ui", "MainPanel.R"), local = TRUE)
source(file.path("ui", "SidebarPanel.R"), local = TRUE)


# Main UI function -------------------------------------------------------------
uiFunc <- function() {
    fluidPage(
        attachCSS("theme.css"),
        attachCSS("HaDeX_theme.css"),
        sp,
        mp
    )
}


# Global UI utilities ----------------------------------------------------------
attachCSS <- function(cssPath) {
    tags$head(
        tags$link(href = cssPath, rel = "stylesheet")
    )
}


# Calling the UI at the end of the script allows top-bottom structure.
# If UI would not be wrapped in a function then an error would be thrown due to
# the utilities functions being used before their definition.
ui <- uiFunc()
