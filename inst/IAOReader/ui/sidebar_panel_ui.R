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

        div(
            id = "file_upload_div",
            splitLayout(
                cellWidths = c("90%", "auto"),
                tagList(
                    # Manually creating the label so that it won't prompt file
                    # upload on clicking it.
                    tags$label(
                        "Upload input files",
                        actionButton(
                            "file_info", icon("info-circle"),
                            class = "label_icon"
                        )
                    ),
                    fileInput("files_upload", NULL, multiple = TRUE,
                              accept = ".csv")
                ),

                # Button for uploading sample data into the application.
                actionButton(
                    "sample_upload", icon("upload"),
                    title = "Upload sample data",
                    onclick = paste0(
                        'Shiny.setInputValue("files_upload", null);',
                        'Shiny.setInputValue("files_upload", -1);'
                    )
                )
            )
        ),

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
                        div(
                            tags$strong("Maximum Sequence Length")
                        ),
                        textOutput("sequence_length_max"),
                        htmlOutput("sequence_length_max_displayed"),
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
        no_file_uploaded_wrapper(
            no_file_good_wrapper(
                uiOutput("plot_settings_inputs"),
                tags$div(
                    align = "center", style = "margin-top: 35px;",
                    actionButton("plot_settings_reset", "Reset Plot Settings",
                                 class = "btn-danger")
                )
            )
        )
    )
}
