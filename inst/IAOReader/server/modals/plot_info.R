plot_info_modal <- function() {
    modalDialog(
        h3(class = "modal_header", "Tooltip"),
        p(
            "The first and simplest functionality the plot offers is a",
            "tooltip. To display the tooltip with information regarding the",
            "line one has to hover over the line of choice. An example of the",
            "said tooltip is shown below."
        ),
        div(align = "center", img(src = "/www/images/plot_info/tooltip.png")),

        h3("Vertical Guides"),
        p(
            "The plot features three types of vertical guides to aid the",
            "analysis of the shown data. Every guide is tied to either the",
            "point or the segment measure. The point measure is displayed with",
            "a mouseover dynamic guide as well as a static guide appearing",
            "after clicking on the plot. The segment measure requires marking",
            "the ends of the segment with dragging within the plot area. To",
            "reset both the on-drag and the on-click guide the plot has to be",
            "double-clicked. The guides with default plot settings are shown",
            "below (left to right: mouseover, on-click, and on-drag)."
        ),
        div(
            align = "center",
            img(src = "/www/images/plot_info/guides.png", width = "75%")
        ),

        h3("Plot Settings"),
        p(
            "There are multiple customizable settings for the plot. It is",
            "encouraged to customize those to one's liking in the Plot",
            "Settings tab in the sidebar panel. If one wishes to reset plot",
            "settings to an initial state it can be done with a button found",
            "at the bottom of the settings tab."
        ),

        title = h2(class = "modal_title", "Coverage Plot Functionalities"),
        footer = modal_footer(),
        easyClose = TRUE
    )
}
