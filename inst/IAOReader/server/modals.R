modals <- function(input, output, session) {
    observeEvent(input[["file_info"]], {
        # TODO: update with realistic values.
        table_values <- list(
            c("A", "x", 1, 12),
            c("A", "x", 7, 20),
            c("A", "x", 14, 24)
        )

        modal <- modalDialog(
            tags$div(
                tags$span(
                    id = "file_info_description",
                    file_info_description
                )
            ),
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
                    tags$tbody(
                        lapply(
                            lapply(
                                table_values,
                                function(row) lapply(row, tags$td)
                            ),
                            tags$tr
                        )
                    )
                ),
                tags$span(
                    id = "file_info_example_caption",
                    "An example fragment of an IAO Reader input file."
                )
            ),
            title = h2(
                class = "modal_title",
                "IAO Reader Input Files' Structure"
            ),
            footer = div(align = "center", modalButton("Dismiss")),
            easyClose = TRUE
        )
        showModal(modal)
    })

    # TODO: add information to the modal.
    # TODO: add option to open k_param_info modal from this modal.
    observeEvent(input[["measure_info"]], {
        modal <- modalDialog(
            title = h2(
                class = "modal_title",
                "IAO Reader Measure"
            ),
            footer = div(align = "center", modalButton("Dismiss")),
            easyClose = TRUE
        )
        showModal(modal)
    })

    # TODO: add information to the modal.
    # TODO: add option to open measure_info modal from this modal.
    observeEvent(input[["k_param_info"]], {
        modal <- modalDialog(
            title = h2(
                class = "modal_title",
                "IAO Reader Measure's K Parameter"
            ),
            footer = div(align = "center", modalButton("Dismiss")),
            easyClose = TRUE
        )
        showModal(modal)
    })
}


file_info_description <- tagList(
    tags$p(
        "The IAO Reader application expects that uploaded file's format is the",
        "Comma Separated Values. Additionally, there are four columns which",
        "uploaded CSV file is required to have. The file may contain any",
        "additional columns but those won't be utilized by the IAO Reader."
    ),
    tags$p(
        HTML(
            "The required columns are: <code>Protein</code>,",
            "<code>State</code>, <code>Start</code>, and <code>End</code>.",
            "Value types of required columns are <code>character</code>,",
            "<code>character</code>, <code>integer</code>, and",
            "<code>integer</code> values respectively. An example of such data",
            "is presented in a table below."
        )
    )
)
