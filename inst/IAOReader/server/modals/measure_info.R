# TODO: Grammarly.
# TODO: add information to the modal.
measure_info_modal <- function(return_observer_id) {
    modalDialog(
        p(
            "This measure calculates a ratio of long enough peptides covering",
            "a given amino acid residue of the sequence to the total number of",
            "peptides covering this element."
        ),
        p(
            "In other words, the measure calculates as a fraction where",
            "nominator is calculated by verifying how many peptides covering",
            "the residue of choice span at least K amino acid residue in both",
            "directions. The K parameter is configurable within the Plot",
            "Settings tab."
        ),
        title = h2(class = "modal_title", "IAO Reader Measure"),
        footer = modal_footer(return_observer_id),
        easyClose = TRUE
    )
}
