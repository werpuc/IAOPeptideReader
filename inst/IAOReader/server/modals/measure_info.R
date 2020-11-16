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
            "In other words, the measure is calculated as a fraction, where",
            "nominator is calculated by counting how many peptides covering",
            "the element of choice span at least K amino acid residue in both",
            "directions. Whereas the denominator is a number of peptides",
            "covering the given residue, regardless of their length."
        ),
        p(
            "The K parameter is configurable via the Plot Settings tab."
        ),
        title = h2(class = "modal_title", "IAO Reader Measure"),
        footer = modal_footer(return_observer_id),
        easyClose = TRUE
    )
}
