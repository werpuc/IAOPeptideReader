# Main panel -------------------------------------------------------------------
mpFunc <- function() {
    mainPanel(
        h3("Main Panel"),

        # TODO: change to div for D3 plot.
        # TODO: add padding.
        plotOutput("plot") 
    )
}
