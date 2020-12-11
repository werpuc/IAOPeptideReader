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
                    src = paste0(img_url, "/measure_info/point_measure_example.png"),
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
            "segment of the sequence instead of the point in calculations.",
            "Additionally, the segment measure requires at least one peptide",
            "spanning across the whole selected segment."
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
            p(
                "In the picture below, there is a fragment of the plot for",
                "three different files. However, only two colors have measure",
                "values assigned. That is due to the fact that in the top file",
                "none of the lines spans across the whole segment."
            ),
            p(
                "On the other hand, the middle file has a measure's value",
                "assigned. However, it is a zero due to the fact that none of",
                "the lines extend the selected segment by at least 4 (the K",
                "parameter). Therefore the denominator is and thus the measure",
                "is equal to 0 (= 0/3)."
            ),
            div(
                align = "center",
                img(
                    src = paste0(img_url, "/measure_info/segment_measure_example.png"),
                    width = "80%"
                )
            ),
            p(
                "Finally, the bottommost file has a value of 75%. Since only a",
                "single peptide does not span by at least 3 in both directions",
                "(the bottom one) the nominator in the ratio is equal to 3.",
                "Therefore the measure is equal to 0.75 (= 3/4)."
            )
        ),
        title = h2(class = "modal_title", "IAO Peptide Reader Measure"),
        footer = modal_footer(return_observer_id),
        easyClose = TRUE
    )
}
