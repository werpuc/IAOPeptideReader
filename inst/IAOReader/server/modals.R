modals <- function(input, output, session) {
    # TODO: add information to the modal.
    observeEvent(input[["file_info"]], {
        table_values <- list(
            c("A", "x", 1, 12),
            c("A", "x", 7, 20),
            c("A", "x", 14, 24)
        )

        modal <- modalDialog(
            tags$div(
                align = "center",
                tags$table(
                    id = "file_info_example",
                    tags$thead(
                        tags$tr(
                            lapply(
                                c("Protein", "State", "Start", "End"),
                                tags$th
                            )
                        )
                    ),
                    # TODO: update with realistic values.
                    tags$tbody(
                        lapply(
                            lapply(
                                table_values,
                                function(row) lapply(row, tags$td)
                            ),
                            tags$tr
                        )
                    )
                )
            ),
            title = h2(
                class = "modal_title",
                "IAO Reader Input Files' Structure"
            ),
            easyClose = TRUE
        )
        showModal(modal)
    })

    # TODO: add information to the modal.
    observeEvent(input[["measure_info"]], {
        modal <- modalDialog(
            title = h2(
                class = "modal_title",
                "IAO Reader Measure"
            ),
            easyClose = TRUE
        )
        showModal(modal)
    })
}
