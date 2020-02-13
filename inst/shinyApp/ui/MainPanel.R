# Main panel -------------------------------------------------------------------
main_panel <- function() {
    mainPanel(
        tabsetPanel(
            peptide_coverage_ui(),
            data_preview_ui()
        )
    )
}


# Peptide Coverage tab ---------------------------------------------------------
peptide_coverage_ui <- function() {
    tabPanel(
        "Peptide Coverage",

        # TODO: change to div for D3 plot.
        # TODO: add padding.
        h3("Coverage Plot"),
        plotOutput("plot"),

        h3("Summary Table"),
        div(
            align = "center",
            tableOutput("summary_table")
        )
    )
}


# Data Preview tab ------------------------------------------------------------
data_preview_ui <- function() {
    tabPanel(
        "Data Preview",
        div(
            id = "previewed_file",
            selectInput("previewed_file", "Select File to Preview", NULL)
        ),
        tags$p("This is data preview tab.")
    )
}
