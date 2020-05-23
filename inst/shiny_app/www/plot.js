Shiny.addCustomMessageHandler("draw_canvas", function(_) {
    var plot_div = d3.select("div#plot");
    var svg = plot_div.select("svg");

    // Creating the svg if it does not exist.
    if (svg.empty()) {
        svg = plot_div
            .append("svg")
                .attr("viewBox", "0 0 1280 720");
    }
});


Shiny.addCustomMessageHandler("update_data", function(plot_data) {
    // TODO: update the plot.
    // svg.selectAll("g#data_stuff > circle").data(data).join().[...]
    console.log("Received data!");

    // This will set input[["update_plot_settings"]] to current timestamp what
    // will cause all observers including that phrase to recalculate.
    Shiny.setInputValue("update_plot_settings", Date.now(), null);
});
