color_info_modal <- function() {
    default_palette <- "Set1"
    palettes <- c("Accent", "Category10", "Dark2", "Paired", "Pastel1",
                  "Pastel2", "Set1", "Set2", "Set3", "Tableau10")

    modalDialog(
        p(
            "The color palettes used in the IAO Reader are the ones",
            "implemented in the D3.js library's",
            external_link(
                "d3-scale-chromatic module",
                "https://github.com/d3/d3-scale-chromatic",
                trailing_dot = TRUE
            ),
            "These palettes were derived from Cynthia A. Brewer's",
            external_link("ColorBrewer", "https://colorbrewer2.org", TRUE),
        ),
        p(
            "The palettes included in the settings are categorical color sets",
            "which can be previewed below.",
        ),
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
