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

        # Point measure variant
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
            p(
                "In the below picture the point measure for the left-hand side",
                "vertical guide assumes 100%. That is due to the fact that all",
                "four lines representing peptides span left and right by at",
                "least 3 (the K parameter). Therefore, both, nominator and",
                "denominator are equal to 4 resulting in the ratio of 1",
                "(= 4/4)."
            ),
            div(
                align = "center",
                img(
                    src = "/www/images/measure_info/point_measure_example.png",
                    width = "60%"
                )
            ),
            p(
                "However, the right-hand side guide shows only 60% value. This",
                "is due to the fact that out of total of 5 lines the guide",
                "crosses only three span by at least 3 residues (the top and",
                "the bottom are too short). This results in the ratio of 0.6",
                "(= 3/5)."
            )
        ),

        # Segment measure variant
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

        actionButton(
            "show_segment_measure_calc", "Segment measure calculation example",
            class = "collapse-button", `data-toggle` = "collapse",
            `data-target` = "#segment_measure_calc"
        ),
        div(
            id = "segment_measure_calc", class = "hideable",
            div(
                align = "center",
                img(
                    src = "/www/images/measure_info/segment_measure_example.png",
                    width = "80%"
                )
            )
        ),
        title = h2(class = "modal_title", "IAO Reader Measure"),
        footer = modal_footer(return_observer_id),
        easyClose = TRUE
    )
}
