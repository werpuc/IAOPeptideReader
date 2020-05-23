Shiny.addCustomMessageHandler("draw_canvas", function(_) {
    var x = 1280, y = 720, margin = 30;
    var plot_div = d3.select("div#plot");

    // Creating the svg if it does not exist.
    var svg = plot_div.select("svg");
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


Shiny.addCustomMessageHandler("update_data", function(plot_info) {
    var svg = d3.select("div#plot svg");
    if (svg.empty()) return;
    var x = svg.attr("_x"), y = svg.attr("_y"), margin = svg.attr("_margin");


    // Unpacking informations from plot_info JSON.
    var seq_len = plot_info.seq_len;
    var plot_data = plot_info.plot_data;


    // Transforming and preparing the data.
    var n = plot_data.Start.length;
    // TODO: account for varying number of files (modify colors of lines too).
    var plot_data_transformed = d3
        .range(n)
        .map(
            function(i) {
                return {
                    Start: plot_data.Start[i],
                    End: plot_data.End[i],
                    FileName: plot_data.FileName[i],
                    y: i + 1
                }
            }
        );


    // Creating X axis if it does not exist.
    var g_x_axis = svg.select("g#x_axis");
    if (g_x_axis.empty()) {
        g_x_axis = svg
            .append("g")
                .attr("id", "x_axis")
                .attr(
                    "transform",
                    "translate(0, " + (y - margin) + ")"
                );
    }

    var x_scale = d3.scaleLinear()
        .domain([1, seq_len])
        .range([0 + margin, x - margin]);

    var x_axis = d3.axisBottom().scale(x_scale);

    g_x_axis.call(x_axis);


    // Creating Y axis if it does not exist.
    var g_y_axis = svg.select("g#y_axis");
    if (g_y_axis.empty()) {
        g_y_axis = svg
            .append("g")
                .attr("id", "y_axis")
                .attr("transform", "translate(" + margin + ", 0)");
    }

    var y_scale = d3.scaleLinear()
        .domain([1, n])
        .range([y - margin, 0 + margin]);

    var y_axis = d3.axisLeft().scale(y_scale);

    g_y_axis.call(y_axis);


    // Creating lines g if it does not exist
    var g_lines = svg.select("g#lines");
    if (g_lines.empty()) {
        g_lines = svg
            .append("g")
                .attr("id", "lines");
    }


    // Drawing the lines.
    g_lines
        .selectAll("line")
            .data(plot_data_transformed)
            .join("line")
                .attr("x1", d => x_scale(d.Start))
                .attr("y1", d => y_scale(d.y))
                .attr("x2", d => x_scale(d.End))
                .attr("y2", d => y_scale(d.y))
                .style("stroke-width", 2)
                .style("stroke", "black");


    // This will set input[["update_plot_settings"]] to current timestamp what
    // will cause all observers including that phrase to recalculate.
    Shiny.setInputValue("update_plot_settings", Date.now(), null);
});


//    // Drag 
//    // TODO: on mouseover display vertical line snapping to integer X values.
//    // TODO: on click keep the vertical line in place (stop displaying mouseover).
//    // TODO: calculate coverage and lambda_k for mouseover/click line.
//    // TODO: dragging creates an area for which Lambda_k is calculated.
//    // TODO: double click clears vertical line and drag area.
//    // TODO: add hints for the above.
//
//    var drag_coords = {start: null, end: null};
//
//    svg.on("click", function() {
//        // TODO: on click reset coords.
//        drag_coords.start = 0;
//        drag_coords.end = 0;
//    });
//
//    // TODO: translate mouse click to axis values.
//    var drag = d3.drag()
//        .on("start", function() {
//            // TODO: set initial x value to drag_coords.start.
//        })
//        .on("drag", function() {
//            // TODO: keep updating the end value.
//        })
//        .on("end", function() {
//            // TODO: save final x value to drag_coords.end.
//            // TODO: send drag_coords to R for Lambda_k calculation.
//        });
//
//    svg.call(drag);
