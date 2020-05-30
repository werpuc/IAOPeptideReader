let IAOReader = class {
    // Canvas dimensions.
    width = 1280; height = 720;
    margin = { top: 30, right: 30, bottom: 30, left: 30 };

    // Plot elements.
    svg; x_axis; y_axis; lines;
    vert; vert_click;

    // Vertical guides mark class names.
    vert_mark = "vert-mark"; vert_click_mark = "vert-click-mark";

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
            .attr("transform", "translate(0, " + (this.height - this.margin.bottom) + ")");

        // Creating Y axis g tag.
        this.y_axis = this.svg.append("g")
            .attr("id", "y_axis")
            .attr("transform", "translate(" + this.margin.left + ", 0)");

        // Creating lines g tag.
        this.lines = this.svg.append("g")
            .attr("id", "lines");

        // Creating g tag, line and label for mouseover vert.
        this.vert = this.svg.append("g")
            .attr("id", "vert")
            .attr("class", "verts");

        this.vert.append("line")
            .attr("y1", this.height - this.margin.bottom + 6)
            .attr("y2", this.margin.top)
            .style("stroke-width", 2)
            .style("stroke", "var(--plot-color-vert)");

        this.vert.append("text")
            .attr("y", this.height - this.margin.bottom + 6)
            .attr("dy", "1em")
            .style("fill", "var(--plot-color-vert)");

        // This mousemove handler makes the vertical guide follow the cursor.
        var self = this;
        this.svg.on("mousemove", function() {
            if (!self.vert_show) return;

            var m = d3.mouse(this);

            if (self.mouse_out_of_bonds(m)) {
                self.unmark_lines(self.vert_mark);
                self.move_vert(self.vert, self.x_min);
                return;
            }

            var x = self.x_scale.invert(m[0]);

            self.mark_lines(x, self.vert_mark);
            self.move_vert(self.vert, x);
        })

        // This handler resets position of vert. This is particularly useful
        // for a case when user moves mouse outside the plot after pressing
        // mouse wheel and scrolling out.
        this.svg.on("mouseout", function() {
            if (!self.vert_show) return;

            // This check prevents tearing and lagging of the mousemove handler.
            if (!self.mouse_out_of_bonds(d3.mouse(this))) return;

            self.unmark_lines(self.vert_mark);
            self.move_vert(self.vert, self.x_min);
        })

        // Creating g tag, line and label for click vert.
        this.vert_click = this.vert.clone(true)
            .attr("id", "vert_click")
            .style("visibility", "hidden");

        this.vert_click.select("line")
            .style("stroke", "var(--plot-color-vert-click)");

        this.vert_click.select("text")
            .style("fill", "var(--plot-color-vert-click)");

        // This handler creates persistent guide on click.
        this.svg.on("click", function() {
            var m = d3.mouse(this);

            if (self.mouse_out_of_bonds(m)) return;

            var x = self.x_scale.invert(m[0]);

            self.mark_lines(x, self.vert_click_mark);
            self.move_vert(self.vert_click, x);
            self.vert_click.style("visibility", "visible");
        })

        // This handler clears the persistent guide created on click.
        this.svg.on("dblclick", function() {
            var m = d3.mouse(this);

            if (self.mouse_out_of_bonds(m)) return;

            self.unmark_lines(self.vert_click_mark);
            self.vert_click.style("visibility", "hidden");
        })

        this.plot_settings = new PlotSettings(this.svg, this.margin);
    }


    /* -------------------------------------------------------------------------
     * [Getters] Filtering plot data and creating scales
     * ---------------------------------------------------------------------- */

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
            .range([this.margin.left, this.width - this.margin.right]);
    }

    get y_scale() {
        return d3.scaleLinear()
            .domain([1, this.plot_data.length])
            .range([this.height - this.margin.bottom, this.margin.top]);
    }


    /* -------------------------------------------------------------------------
     * Drawing plot elements
     * ---------------------------------------------------------------------- */

    update_plot() {
        // This check is performed because some handlers call the update_plot
        // method before the data is uploaded.
        if (this.plot_data_raw === null) return;

        this.draw_x_axis();
        this.draw_y_axis();
        this.draw_lines();
        this.move_vert(this.vert, this.x_min);
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

    mark_lines(x, class_name, remove = false) {
        var lines = this.lines.selectAll("line");

        lines.nodes().forEach(d => d.classList.remove(class_name));

        if (!remove) {
            lines.filter(d => d.Start <= x && x <= d.End).nodes()
                .forEach(d => d.classList.add(class_name));
        }
    }

    unmark_lines(class_name) {
        this.mark_lines(null, class_name, true);
    }


    /* -------------------------------------------------------------------------
     * Vertical guides handling
     * ---------------------------------------------------------------------- */

    mouse_out_of_bonds(m) {
        return (m[0] < this.margin.left || m[0] > this.width - this.margin.right ||
                m[1] < this.margin.top || m[1] > this.height - this.margin.bottom)
    }

    move_vert_to_mouse(vert, m) {
        this.move_vert(vert, this.x_scale.invert(m[0]));
    }

    move_vert(vert, x_dest) {
        // This round makes the guide snap to integer values on the axis.
        var x = Math.round(x_dest);

        vert
            .attr("transform", "translate(" + this.x_scale(x) + ", 0)")
            .select("text")
                .text(x);
    }
}


// This variable's value is assigned by Shiny main server function.
var iaoreader;

//    // Drag 
//    // TODO: calculate coverage and lambda_k for mouseover/click line.
//    // TODO: dragging creates an area for which Lambda_k is calculated.
//    // TODO: double click clears vertical line and drag area.
//    // TODO: add hints for the above.
//    // TODO: color peptides under the vertical guide.
//    // TODO: reset mouseover vert position on window enter (?) to reset it after alt-tabbing into the app.
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
