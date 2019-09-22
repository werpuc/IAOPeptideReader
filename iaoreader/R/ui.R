# Main function for user interface. Returns a complete application UI.
user_interface <- function() {
    fluidPage(

        # Including CSS theme and JS scripts.
        includeCSS(get_file_path("HaDeX_theme.css")),
        includeScript(get_file_path("plot.js")),
        includeScript(get_file_path("d3.v5.js")),

        # Hiding a header of table with files names.
        tags$style(type = "text/css", "#files_names th {display:none;}"),

        ui_sidebar(),
        mainPanel(
            class = "scrollable",
            tabsetPanel(

                # A plot panel. ------------------------------------------------
                tabPanel("Peptide Coverage", br(),
                    placeholder_before_upload(),

                    tags$div(id = "js_plot")
                ),

                # A data preview panel. ----------------------------------------
                tabPanel("Data preview", br(),
                    placeholder_before_upload(),

                    conditionalPanel("output.files_uploaded",
                        selectInput("data_preview_select", choices = NULL,
                                    label = "Select a file for preview"),
                        DT::dataTableOutput("data_preview_df")
                    )
                )
            )
        )
    )
}
