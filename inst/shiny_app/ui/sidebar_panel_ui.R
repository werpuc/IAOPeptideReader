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
        fileInput("files_upload", "Upload input files", multiple = TRUE),

        conditionalPanel(
            "output.files_uploaded",

            h3("Sequence Length"),
            splitLayout(
                cellWidths = c("30%", "70%"),

                # TODO: update the initial value with a maximum value read from input files.
                numericInput("sequence_length", NULL, 123, width = "100%"),

                # TODO: change to textOutput and update with a maximum value read from input files.
                tags$p("Maximum sequence length read from files: 123",
                       style = "margin-left: 20px;") # textOutput("sequence_length_default")
            ),

            h3("Input Files Summary"),
            uiOutput("input_summary_table")
            # TODO: add CSS to this table.
            # TODO: gray out (mark) the rows which have file with incorrect structure.
        )
    )
}


# Plot Settings tab UI ---------------------------------------------------------
plot_settings_ui <- function() {
    tabPanel(
        "Plot Settings",
        uiOutput("plot_settings_inputs"),
        tags$div(
            align = "center", style = "margin-top: 35px;",
            actionButton("plot_settings_reset", "Reset Plot Settings",
                         class = "btn-danger")
        )
    )
}
