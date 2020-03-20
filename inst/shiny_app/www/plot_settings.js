Shiny.addCustomMessageHandler("plot_title", function(plot_title_value) {
    var svg = d3.select("#plot > svg");
    var plot_title = svg.select("text#plot_title");

    // Creating the title if it does not exist.
    if (plot_title.empty()) {
        plot_title = svg.append("text").attr("id", "plot_title")
                                       .attr("x", "50%").attr("y", "5px");
    }

    plot_title.text(plot_title_value);
});
