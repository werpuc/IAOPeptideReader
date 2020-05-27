# Main panel UI ----------------------------------------------------------------
main_panel_ui <- function() {
    mainPanel(
        tags$div(
            id = "main_panel",
            tabsetPanel(
                peptide_coverage_ui(),
                data_preview_ui()
            )
        )
    )
}


# Peptide Coverage tab UI ------------------------------------------------------
peptide_coverage_ui <- function() {
    tabPanel(
        "Peptide Coverage",
        no_file_uploaded_wrapper(
            no_file_good_wrapper(

                h3("Coverage Plot"),
                div(id = "plot"),

                h3("Summary Table"),
                div(
                    align = "center",
                    tableOutput("summary_table")
                )
            )
        )
    )
}


# Data Preview tab UI ---------------------------------------------------------
data_preview_ui <- function() {
    tabPanel(
        "Data Preview",
        no_file_uploaded_wrapper(
            no_file_good_wrapper(
                div(
                    id = "previewed_file",
                    selectInput("previewed_file", "Select File to Preview", NULL)
                ),
                DT::dataTableOutput("data_preview")
            )
        )
    )
}
