modals <- function(input, output, session) {
    observeEvent(input[["file_info"]], {
        modal <- file_info_modal()
        showModal(modal)
    })

    observeEvent(input[["measure_info"]], {
        modal <- measure_info_modal()
        showModal(modal)
    })

    observeEvent(input[["measure_info_return"]], {
        modal <- measure_info_modal("k_param_info")
        showModal(modal)
    })

    observeEvent(input[["k_param_info"]], {
        modal <- k_param_info_modal()
        showModal(modal)
    })

    observeEvent(input[["k_param_info_return"]], {
        modal <- k_param_info_modal("measure_info")
        showModal(modal)
    })
}


# TODO: add information to the modal.
measure_info_modal <- function(return_observer_id = NULL) {
    modalDialog(
        "To be added...",
        br(), "See also:", modal_link("k_param_info_return", "K parameter"),
        title = h2(class = "modal_title", "IAO Reader Measure"),
        footer = modal_footer(return_observer_id),
        easyClose = TRUE
    )
}


# TODO: add information to the modal.
k_param_info_modal <- function(return_observer_id = NULL) {
    modalDialog(
        "To be added...",
        br(), "See also:", modal_link("measure_info_return", "measure"),
        title = h2(class = "modal_title", "IAO Reader Measure's K Parameter"),
        footer = modal_footer(return_observer_id),
        easyClose = TRUE
    )
}


file_info_modal <- function() {
    # TODO: update with realistic values.
    table_values <- list(
        c("A", "x", 1, 12),
        c("A", "x", 7, 20),
        c("A", "x", 14, 24)
    )

    modalDialog(
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
        title = h2(class = "modal_title", "IAO Reader Input Files' Structure"),
        footer = modal_footer(),
        easyClose = TRUE
    )
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


modal_footer <- function(observer_id = NULL) {
    div(
        align = "center",
        if (!is.null(observer_id)) {
            actionButton(
                sprintf("return_button_%.0f", Sys.time()), "Return",
                onclick = sprintf(
                    "Shiny.setInputValue('%s', Date.now());", observer_id
                )
            )
        },
        modalButton("Dismiss")
    )
}
