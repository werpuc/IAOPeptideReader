source(file.path("ui", "MainPanel.R"), local = TRUE)
source(file.path("ui", "SidebarPanel.R"), local = TRUE)


# Main UI function -------------------------------------------------------------
ui <- fluidPage(
    attachCSS("theme.css"),
    attachCSS("HaDeX_theme.css"),
    sp,
    mp
)


# Global UI utilities ----------------------------------------------------------
attachCSS <- function(cssPath) {
    tags$head(
        tags$link(href = cssPath, rel = "stylesheet")
    )
}
