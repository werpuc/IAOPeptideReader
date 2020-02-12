# Main panel -------------------------------------------------------------------
main_panel <- function() {
    mainPanel(
        tabsetPanel(
            peptide_coverage_ui(),
            data_preview_ui()
        )
    )
}


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


data_preview_ui <- function() {
    tabPanel(
        "Data Preview",
        tags$p("This is data preview tab.")
    )
}
