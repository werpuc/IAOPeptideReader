# <ToDo>
sidebar <- function() {
    sidebarPanel(
        class = "scrollable",
        tabsetPanel(
            sidebar_input(),
            sidebar_plot_settings()
        )
    )
}


# Sidebar tabPanel used to upload files and precise which part of data should be used.
sidebar_input <- function() {
    tabPanel(
        "Input settings", br(),
        selectInput("mode", label = "Select mode", multiple = FALSE,
                    choices = c("Two files (different experiments)", "Multiple files (one experiment)")),
        fileInput("files_input", "Upload files", multiple = TRUE),
        uiOutput("files_input_settings")
    )
}


# Sidebar tabPanel containing all plot customization settings.
sidebar_plot_settings <- function() {
    tabPanel(
        "Plot settings", br(),
        textInput("plot_settings_title", label = "Title"),
        textInput("plot_settings_text_color", label = "Text color")
    )
}
