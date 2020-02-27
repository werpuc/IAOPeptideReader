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

        # TODO: change to div for D3 plot.
        h3("Coverage Plot"),
        plotOutput("plot"),

        h3("Summary Table"),
        div(
            align = "center",
            tableOutput("summary_table")
        )
    )
}


# Data Preview tab UI ---------------------------------------------------------
data_preview_ui <- function() {
    tabPanel(
        "Data Preview",
        div(
            id = "previewed_file",
            selectInput("previewed_file", "Select File to Preview", NULL)
        ),
        DT::dataTableOutput("data_preview")
    )
}
