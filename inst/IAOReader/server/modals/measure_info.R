# TODO: Grammarly.
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
