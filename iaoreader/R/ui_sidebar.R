ui_sidebar <- function() {
    sidebarPanel(
        class = "scrollable",
        tabsetPanel(
            sidebar_input_settings(),
            sidebar_plot_settings()
        )
    )
}


# Sidebar tabPanel used to upload files and precise which part of data should be used.
sidebar_input_settings <- function() {
    tabPanel(
        "Input settings", br(),
        selectInput("mode", label = "Select mode", multiple = FALSE,
                    choices = mode_names()),
        fileInput("files_input", "Upload files", multiple = TRUE),
        conditionalPanel("output.files_uploaded",
                         h3("Detailed settings"),
                         numericInput("sequence_length",
                                      label = "Specify sequence length",
                                      value = NULL, min = 1),
                         textOutput("sequence_length_files")
        )
    )
}

mode_names <- function() {
    c(
        "Two files (different experiments)",
        "Multiple files (one experiment)"
    )
}


# Sidebar tabPanel containing all plot customization settings.
sidebar_plot_settings <- function() {
    tabPanel(
        "Plot settings", br(),
        placeholder_before_upload(),
        conditionalPanel("output.files_uploaded",
            textInput("plot_settings_title", label = "Title"),
            textInput("plot_settings_text_color", label = "Text color"),
            sliderInput("tmp_radius", label = "Radius", min = 1, max = 30, value = 10),
            br(),
            actionButton("plot_update", label = "Update plot")
        )
    )
}
