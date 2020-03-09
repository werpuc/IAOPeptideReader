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
            conditionalPanel(
                "!output.any_file_good",
                tags$p(
                    id = "no_good_file", class = "bad_files_info",
                    "None of the uploaded files passed the verification."
                )
            ),
            conditionalPanel(
                "output.any_file_good",
                splitLayout(
                    cellWidths = c("30%", "70%"),
                    # TODO: add minimal value of 1, add necessary checks and handle incorrect values.
                    numericInput("sequence_length", NULL, NULL, width = "100%"),
                    textOutput("sequence_length_max")
                )
            ),

            h3("Input Files Summary"),
            conditionalPanel(
                "output.any_file_bad",
                tags$p(
                    class = "bad_files_info",
                    "For error details about the files hover a highlighted row."
                )
            ),
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
