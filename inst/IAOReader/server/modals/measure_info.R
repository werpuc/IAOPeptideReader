# TODO: Grammarly.
# TODO: add information to the modal.
# TODO: segment measure example.
measure_info_modal <- function(return_observer_id) {
    modalDialog(
        p(
            HTML("<b>Note:</b>"), "the K parameter mentioned below is",
            "configurable via the Plot Settings tab for both, point and",
            "segment measure variants."
        ),

        h3("Point Measure Variant"),
        p(
            "The point measure calculates a ratio of long enough peptides",
            "covering a given amino acid residue of the sequence to the total",
            "number of peptides covering this element."
        ),
        p(
            "In other words, the point measure is calculated as a fraction,",
            "where nominator is calculated by counting how many peptides",
            "covering the element of choice span at least K amino acid residue",
            "in both directions. Whereas the denominator is a number of",
            "peptides covering the given residue, regardless of their length."
        ),

        actionButton(
            "show_point_measure_calc", "Point measure calculation example",
            class = "collapse-button", `data-toggle` = "collapse",
            `data-target` = "#point_measure_calc"
        ),
        div(
            id = "point_measure_calc", class = "hideable",
            # TODO: add description.
            div(
                align = "center",
                img(
                    src = "/www/images/measure_info/point_measure_example.png",
                    width = "50%"
                )
            )
        ),

        h3("Segment Measure Variant"),
        p(
            "The segment measure is analogous to the point variant. However,",
            "the segment variant, as the name suggests, uses a selected",
            "segment of the sequence instead of the point in calculations."
        ),
        p(
            "Therefore, the segment measure calculates a ratio defined by",
            "a fraction, where the nominator is equal to a number of peptides",
            "extending a given segment by at least K amino acid residue in",
            "both directions, while the denominator is the total number of",
            "peptides spanning over a given region."
        ),
        title = h2(class = "modal_title", "IAO Reader Measure"),
        footer = modal_footer(return_observer_id),
        easyClose = TRUE
    )
}
