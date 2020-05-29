let IAOReader = class {
    // Canvas dimensions.
    width = 1280; height = 720; margin = 30;

    // Plot elements.
    svg; x_axis; y_axis; lines;

    // Axis limits values.
    x_min = 1; x_max;

    constructor() {
        var plot_div = d3.select("div#plot");
        var svg = plot_div.select("svg");

        // Creating the SVG tag if it does not exist.
        if (svg.empty()) {
            // TODO: remove redundant parameters
            svg = plot_div.append("svg")
                .attr("_x", this.width)
                .attr("_y", this.height)
                .attr("_margin", this.margin)
                .attr("viewBox", "0 0 " + this.width + " " + this.height);
        }
        this.svg = svg;

        // Creating X axis g tag if it does not exist.
        var x_axis = svg.select("g#x_axis");
        if (x_axis.empty()) {
            x_axis = svg.append("g")
                .attr("id", "x_axis")
                .attr("transform", "translate(0, " + (this.height - this.margin) + ")");
        }
        this.x_axis = x_axis;

        // Creating Y axis g tag if it does not exist.
        var y_axis = svg.select("g#y_axis");
        if (y_axis.empty()) {
            y_axis = svg.append("g")
                .attr("id", "y_axis")
                .attr("transform", "translate(" + this.margin + ", 0)");
        }
        this.y_axis = y_axis;

        // Creating lines g tag if it does not exist.
        var lines = svg.select("g#lines");
        if (lines.empty()) {
            lines = svg.append("g")
                .attr("id", "lines");
        }
        this.lines = lines;

        this.plot_settings = new PlotSettings(svg, this.margin);
    }

    draw_x_axis() {
        this.x_axis.call(d3.axisBottom().scale(this.x_scale));
    }

    get x_scale() {
        return d3.scaleLinear()
            .domain([this.x_min, this.x_max])
            .range([this.margin, this.width - this.margin]);
    }


    draw_data(plot_data) {
        var svg = this.svg;
        var x = svg.attr("_x"), y = svg.attr("_y"), margin = svg.attr("_margin");

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

        this.draw_x_axis();


        var y_scale = d3.scaleLinear()
            .domain([1, n])
            .range([y - margin, 0 + margin]);

        var y_axis = d3.axisLeft().scale(y_scale);

        this.y_axis.call(y_axis);


        // Drawing the lines.
        this.lines
            .selectAll("line")
                .data(plot_data_transformed)
                .join("line")
                    .attr("x1", d => this.x_scale(d.Start))
                    .attr("y1", d => y_scale(d.y))
                    .attr("x2", d => this.x_scale(d.End))
                    .attr("y2", d => y_scale(d.y))
                    .style("stroke-width", 2)
                    .style("stroke", "black");


    }


    // TODO: add plot settings parameters object.
    // TODO: move axis creation, scales, max_seq_len etc. to this class.
}


// This variable has valueu assigned by Shiny main server function.
var iaoreader;

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
