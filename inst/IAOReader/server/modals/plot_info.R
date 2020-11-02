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

        h3(class = "modal_header", "Plot Settings"),
        p(
            "There are multiple customizable settings for the plot. It is",
            "encouraged to customize those to one's liking in the Plot",
            "Settings tab in the sidebar panel. If one wishes to reset plot",
            "settings to an initial state it can be done with a button found",
            "at the bottom of settings tab."
        ),

        title = h2(class = "modal_title", "Coverage Plot Functionalities"),
        footer = modal_footer(),
        easyClose = TRUE
    )
}
