modals <- function(input, output, session) {
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
}
