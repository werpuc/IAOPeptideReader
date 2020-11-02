# TODO: Grammarly.
plot_info_modal <- function() {
    modalDialog(
        h3(class = "modal_header", "Tooltip"),
        p(
            "The first and simplest functionality the plot offers is a",
            "tooltip. Once any of the lines are hovered over the tooltip with",
            "details regarding the line will appear. An example of said",
            "tooltip is shown below."
        ),
        div(align = "center", img(src = "/www/images/plot_info/tooltip.png")),
        title = h2(class = "modal_title", "Coverage Plot Functionalities"),
        footer = modal_footer(),
        easyClose = TRUE
    )
}
