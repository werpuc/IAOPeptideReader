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
        "The IAO Reader application expects that the uploaded file's format is",
        "the Comma Separated Values. The field separator should be a comma and",
        "the decimal separator should be a dot. If one wishes to upload",
        "multiple files then these files should be contained within a single",
        "directory."
    ),
    tags$p(
        "Additionally, there are four columns that uploaded CSV file is",
        "required to have. The file may contain any additional columns but",
        "those won't be utilized by the IAO Reader."
    ),
    tags$p(
        HTML(
            "The required columns are <code>Protein</code>,",
            "<code>State</code>, <code>Start</code>, and <code>End</code>.",
            "Value types of required columns are <code>character</code>,",
            "<code>character</code>, <code>integer</code>, and",
            "<code>integer</code> values respectively. An example of such data",
            "is presented in the table below."
        )
    )
)
