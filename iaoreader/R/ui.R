user_interface <- function() {
    fluidPage(

        # Including CSS theme and JS scripts.
        includeCSS(get_file_path("HaDeX_theme.css")),
        # includeScript(get_file_path("plot.js")),
        # includeScript(get_file_path("d3.v5.js")),

        ui_sidebar(),
        mainPanel(
            class = "scrollable",
            tabsetPanel(

                # Plot panel
                # tabPanel("Peptide Coverage", br(),
                #     placeholder_before_upload(),
                #
                #     tags$div(id = "js_plot")
                # ),

                # Data preview panel
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
