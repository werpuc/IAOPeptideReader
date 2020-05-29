let IAOReader = class {
    // Canvas dimensions.
    width = 1280; height = 720; margin = 30;

    // Plot elements.
    svg; x_axis; y_axis; lines;

    // Axis limits values.
    x_min = 1; x_max;

    // Data uploaded by the user.
    plot_data_raw = null;

    constructor() {
        var plot_div = d3.select("div#plot");
        var svg = plot_div.select("svg");

        // Creating the SVG tag if it does not exist.
        if (svg.empty()) {
            svg = plot_div.append("svg")
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

    get plot_data() {
        if (this.plot_data_raw === null) return null;

        var self = this;

        // Note: upper limit isn't inclusive due to lines starting at x_max
        //       were accounted for on Y axis but not actually displayed.
        return this.plot_data_raw
            .filter(d => (self.x_min <= d.Start && d.Start < self.x_max));
    }

    get x_scale() {
        return d3.scaleLinear()
            .domain([this.x_min, this.x_max])
            .range([this.margin, this.width - this.margin]);
    }

    get y_scale() {
        return d3.scaleLinear()
            .domain([1, this.plot_data.length])
            .range([this.height - this.margin, this.margin]);
    }

    update_plot() {
        // This check is performed because some handlers call the update_plot
        // method before the data is uploaded.
        if (this.plot_data_raw === null) return;

        this.draw_x_axis();
        this.draw_y_axis();
        this.draw_lines();
    }

    draw_x_axis() {
        this.x_axis.call(d3.axisBottom().scale(this.x_scale));
    }

    draw_y_axis() {
        this.y_axis.call(d3.axisLeft().scale(this.y_scale));
    }

    draw_lines() {
        // TODO: account for varying number of files (modify colors of lines too).
        // Note: max and min functions trim the line to not extend over
        //       the plots edge into the margin.
        this.lines
            .selectAll("line")
                .data(this.plot_data)
                .join("line")
                    .attr("x1", d => this.x_scale(Math.max(d.Start, this.x_min)))
                    .attr("y1", d => this.y_scale(d.y))
                    .attr("x2", d => this.x_scale(Math.min(d.End, this.x_max)))
                    .attr("y2", d => this.y_scale(d.y))
                    .style("stroke-width", 2)
                    .style("stroke", "black");
    }
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
