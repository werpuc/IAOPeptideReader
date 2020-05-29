let IAOReader = class {
    // Canvas dimensions.
    width = 1280; height = 720; margin = 30;

    // Plot elements.
    svg; x_axis; y_axis; lines; vert;

    // Axis limits values and other variables.
    x_min = 1; x_max; vert_show;

    // Data uploaded by the user.
    plot_data_raw = null;

    constructor() {
        // Creating the SVG tag.
        this.svg = d3.select("div#plot").append("svg")
            .attr("viewBox", "0 0 " + this.width + " " + this.height);

        // Creating X axis g tag.
        this.x_axis = this.svg.append("g")
            .attr("id", "x_axis")
            .attr("transform", "translate(0, " + (this.height - this.margin) + ")");

        // Creating Y axis g tag.
        this.y_axis = this.svg.append("g")
            .attr("id", "y_axis")
            .attr("transform", "translate(" + this.margin + ", 0)");

        // Creating lines g tag.
        this.lines = this.svg.append("g")
            .attr("id", "lines");

        // Adding the vertical line and it's g tag.
        this.vert = this.svg.append("g")
            .attr("id", "vert")
            .append("line")
                .attr("x1", this.margin)
                .attr("x2", this.margin)
                .attr("y1", this.height - this.margin)
                .attr("y2", this.margin)
                .style("stroke-width", 2)
                .style("stroke", "orangered");

        // This mousemove handler makes the vertical guide follow the cursor.
        var self = this;
        this.svg.on("mousemove", function() {
            var m = d3.mouse(this);

            if (self.mouse_in_svg(m)) {
                self.move_vert(self.x_min);
                return;
            }

            self.move_vert_to_mouse(m);
        })

        this.plot_settings = new PlotSettings(this.svg, this.margin);
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

    mouse_in_svg(m) {
        return (m[0] < this.margin || m[0] > this.width - this.margin ||
                m[1] < this.margin || m[1] > this.height - this.margin)
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

    move_vert_to_mouse(m) {
        this.move_vert(this.x_scale.invert(m[0]));
    }

    move_vert(x) {
        if (!this.vert_show) return;

        // This round makes the guide snap to integer values on the axis.
        var axis_x = this.x_scale(Math.round(x));

        this.vert
            .attr("x1", axis_x)
            .attr("x2", axis_x)
            .style("visibility", "visible");
    }
}


// This variable has valueu assigned by Shiny main server function.
var iaoreader;

//    // Drag 
//    // TODO: on click keep the vertical line in place (stop displaying mouseover).
//    // TODO: calculate coverage and lambda_k for mouseover/click line.
//    // TODO: dragging creates an area for which Lambda_k is calculated.
//    // TODO: double click clears vertical line and drag area.
//    // TODO: add hints for the above.
//    // TODO: color peptides under the vertical guide.
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
