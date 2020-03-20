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
            div(
                id = "seq_len_div", class = "sidebar_margin", align = "center",
                no_file_good_wrapper(
                    div(
                        class = "manual_split_layout", style = "width: 29%;",
                        {
                            # Note: setting value to one makes the initial value
                            #       okay. This prevents the red border flashing on
                            #       the initial upload.
                            x <- numericInput("sequence_length", NULL, 1, width = "100%")
                            x[["attribs"]][["title"]] <- "Sequence length should be a positive integer."
                            x
                        }
                    ),
                    div(
                        class = "manual_split_layout", style = "width: 69%;",
                        textOutput("sequence_length_max")
                    )
                )
            ),

            h3("Input Files Summary"),
            div(
                class = "sidebar_margin",
                conditionalPanel(
                    "output.any_file_bad",
                    tags$p(
                        class = "bad_files_info",
                        "For error details about the files hover a highlighted row."
                    )
                ),
                uiOutput("input_summary_table")
            )
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
