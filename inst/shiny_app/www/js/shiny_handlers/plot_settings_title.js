Shiny.addCustomMessageHandler("plot_settings_title", function(plot_title_value) {
    var svg = d3.select("div#plot svg");
    if (svg.empty()) return;

    // Creating the title if it does not exist.
    var plot_title = svg.select("text#plot_title");
    if (plot_title.empty()) {
        plot_title = svg
            .append("text")
                .attr("id", "plot_title")
                .attr("text-anchor", "middle")
                .attr("x", "50%")
                .attr("y", margin / 2 + "px");
    }

    plot_title.text(plot_title_value);
});
