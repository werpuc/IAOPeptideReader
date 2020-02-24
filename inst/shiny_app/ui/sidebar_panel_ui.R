# Sidebar panel UI -------------------------------------------------------------
sidebar_panel_ui <- function() {
    sidebarPanel(
        tags$div(
            id = "sidebar_panel",
            tabsetPanel(
                input_settings_ui(),
                plot_settings_ui()
            )
        )
    )
}


# Input Settings tab UI --------------------------------------------------------
input_settings_ui <- function() {
    tabPanel(
        "Input Settings",
        tags$p("This is Input Settings tab.")
    )
}


# Plot Settings tab UI ---------------------------------------------------------
plot_settings_ui <- function() {
    tabPanel(
        "Plot Settings",
        uiOutput("plot_settings_inputs"),
        tags$div(
            id = "plot_settings_reset_div", align = "center",
            actionButton("plot_settings_reset", "Reset Plot Settings",
                         class = "btn-danger")
        )
    )
}
