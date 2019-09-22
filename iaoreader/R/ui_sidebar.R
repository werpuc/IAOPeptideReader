# Main function for creating the sidebar panel.
ui_sidebar <- function() {
    sidebarPanel(
        class = "scrollable",
        tabsetPanel(
            sidebar_input_settings(),
            sidebar_plot_settings()
        )
    )
}


# Input settings ---------------------------------------------------------------

# Sidebar tabPanel used to upload files, set sequence length and select which
# (protein, state) pair should be used in plot if applicable.
sidebar_input_settings <- function() {
    tabPanel(
        "Input settings", br(),

        # A mode selection.
        selectInput("mode", label = "Select mode", multiple = FALSE,
                    choices = mode_names()),

        # A file upload (only if user is under the file upload limit).
        conditionalPanel("output.files_under_limit",
            fileInput("files_input", "Upload files", multiple = TRUE)
        ),

        # A part of the panel for a uploaded files' settings.
        conditionalPanel("output.files_uploaded",

            # Displaying uploaded files' names and ids in a hideable table.
            tags$button("Uploaded files",
                        class = "collapse-button",
                        `data-toggle` = "collapse",
                        `data-target` = "#files_names_table"),
            tags$div(id = "files_names_table",
                     class = "hideable",
                     tableOutput("files_names")
            ),

            h3("Detailed settings"),

            # An input for a sequence length.
            numericInput("sequence_length",
                         label = "Specify sequence length",
                         value = NULL, min = 1),
            textOutput("sequence_length_files"),

            # An inputs for selecting (protein, state) pair for each file which
            # requires a clarification.
            conditionalPanel("output.files_ambiguity",
                br(),
                h4("Specify protein and state"),
                uiOutput("files_settings_ambiguity")
            )
        )
    )
}

# Function returns names of available modes.
mode_names <- function() {
    c(
        "Two files (different experiments)",
        "Multiple files (one experiment)"
    )
}


# Plot settings ----------------------------------------------------------------

# Sidebar tabPanel containing all plot customization settings. Initially
# everything is set to default settings.
sidebar_plot_settings <- function() {
    dps <- default_plot_settings()

    tabPanel(
        "Plot settings", br(),
        placeholder_before_upload(),

        conditionalPanel("output.files_uploaded",

            # A plot title text.
            textInput("title", label = "Title", value = dps$title),

            # A plot lines color.
            colourpicker::colourInput("lines_color", label = "Lines color",
                                      value = dps$lines_color)
        )
    )
}

# Function returns a list containing default plot settings.
default_plot_settings <- function() {
    list(
        "title" = "Coverage plot",
        "lines_color" = "black"
    )
}
