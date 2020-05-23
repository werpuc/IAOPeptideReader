Shiny.addCustomMessageHandler("plot_title", function(plot_title_value) {
    var svg = d3.select("div#plot svg");
    if (svg.empty()) return;

    // Creating the title if it does not exist.
    var plot_title = svg.select("text#plot_title");
    if (plot_title.empty()) {
        plot_title = svg
            .append("text")
                .attr("id", "plot_title")
                .attr("x", "50%")
                .attr("y", svg.attr("_margin") / 2 + "px");
    }

    plot_title.text(plot_title_value);
});
