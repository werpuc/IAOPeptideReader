color_info_modal <- function() {
    default_palette <- "Set1"
    palettes <- c("Accent", "Category10", "Dark2", "Paired", "Pastel1",
                  "Pastel2", "Set1", "Set2", "Set3", "Tableau10")

    modalDialog(
        # TODO: information about palettes source.
        title = h2(class = "modal_title", "Color Palettes"),
        footer = modal_footer(),
        easyClose = TRUE
    )
}
