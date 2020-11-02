# TODO: Grammarly.
# TODO: add information to the modal.
k_param_info_modal <- function(return_observer_id, measure_info_id) {
    modalDialog(
        "To be added...",
        br(), "See also:", modal_link(measure_info_id, "measure"),
        title = h2(class = "modal_title", "IAO Reader Measure's K Parameter"),
        footer = modal_footer(return_observer_id),
        easyClose = TRUE
    )
}
