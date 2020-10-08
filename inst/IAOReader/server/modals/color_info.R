color_info_modal <- function() {
    default_palette <- "Set1"
    palettes <- c("Accent", "Category10", "Dark2", "Paired", "Pastel1",
                  "Pastel2", "Set1", "Set2", "Set3", "Tableau10")

    modalDialog(
        # TODO: information about palettes source.
        actionButton(
            "preview_palettes", "Preview Palettes", class = "collapse-button",
            `data-toggle` = "collapse", `data-target` = "#palettes_preview"
        ),
        div(
            id = "palettes_preview", class = "hideable",
            lapply(
                palettes,
                function(color_palette) {
                    tags$div(
                        class = "palette_preview",
                        tags$label(
                            color_palette,
                            if (color_palette == default_palette) {
                                tags$i("(default)")
                            }
                        ),
                        img(src = sprintf("/www/images/%s.png", color_palette))
                    )
                }
            )
        ),
        title = h2(class = "modal_title", "Color Palettes"),
        footer = modal_footer(),
        easyClose = TRUE
    )
}
