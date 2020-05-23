Shiny.addCustomMessageHandler("draw_canvas", function(_) {
    var x = 1280, y = 720, margin = 20;

    var plot_div = d3.select("div#plot");
    var svg = plot_div.select("svg");

    // Creating the svg if it does not exist.
    if (svg.empty()) {
        svg = plot_div
            .append("svg")
                // Attributes _x, _y and _margin are used to parametrize the
                // size of the plot.
                .attr("_x", x)
                .attr("_y", y)
                .attr("_margin", margin)
                .attr("viewBox", "0 0 " + x + " " + y);
    }
});


Shiny.addCustomMessageHandler("x_axis", function(max_seq_len) {
    var svg = d3.select("div#plot svg");
    var g = svg.select("g#x_axis");

    var x = svg.attr("_x"), y = svg.attr("_y"), margin = svg.attr("_margin");

    if (g.empty()) {
        g = svg
            .append("g")
                .attr("id", "x_axis")
                .attr(
                    "transform",
                    "translate(0, " + (y - margin) + ")"
                );
    }

    var x_scale = d3.scaleLinear()
        .domain([1, max_seq_len])
        .range([0 + margin, x - margin]);

    var x_axis = d3.axisBottom().scale(x_scale);

    g.call(x_axis);
});


Shiny.addCustomMessageHandler("update_data", function(plot_data) {
    // TODO: update the plot.
    // svg.selectAll("g#data_stuff > circle").data(data).join().[...]
    console.log(plot_data);

    // This will set input[["update_plot_settings"]] to current timestamp what
    // will cause all observers including that phrase to recalculate.
    Shiny.setInputValue("update_plot_settings", Date.now(), null);
});
