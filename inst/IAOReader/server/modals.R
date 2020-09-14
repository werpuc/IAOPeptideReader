modals <- function(input, output, session) {
    # TODO: add information to the modal.
    observeEvent(input[["file_info"]], {
        modal <- modalDialog(
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
