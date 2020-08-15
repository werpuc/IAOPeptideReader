let IAOReader = class {
    // Canvas dimensions.
    width = 1280; height = 720;
    margin = { top: 40, right: 30, bottom: 30, left: 30 };

    // Plot elements.
    svg; x_axis; y_axis; lines;
    vert; vert_click;

    // Vertical guides mark class names.
    vert_mark = "vert-mark"; vert_click_mark = "vert-click-mark";

    // Axis limits values and other variables.
    x_min = 1; x_max; vert_show; optimize_height; vertical_offset;
    show_background;


    // Data uploaded by the user.
    plot_data_raw = null; plot_data = null; file_names = null;
    file_names_displayed = new Map();
    
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
     * Data handling
     * ---------------------------------------------------------------------- */

    // This function assumes that plot_data is a JSON with three fields: Start,
    // End, and FileName.
    update_plot_data(plot_data) {
        var file_names = [];

        this.plot_data_raw = d3.range(plot_data.Start.length).map(function(i) {
            var file_name = plot_data.FileName[i];

            if (file_name != plot_data.FileName[i - 1]) {
                file_names.push(file_name);
            }

            return {
                Start: plot_data.Start[i],
                End: plot_data.End[i],
                FileName: file_name
            }
        });

        this.file_names = file_names;
    }

    filter_data() {
        if (this.plot_data_raw === null) return null;
        
        var self = this;

        // Note: upper limit isn't inclusive due to lines starting at x_max
        //       were accounted for on Y axis but not actually displayed.
        this.plot_data = this.plot_data_raw
            .filter(d => (
                self.x_min <= d.Start && d.Start < self.x_max &&
                self.file_names_displayed.get(d.FileName))
            )
            .map(function(d, i) {
                d["y"] = i + 1;
                return d;
            });
    }

    set_file_visibility(file_name, display_flag) {
        this.file_names_displayed.set(file_name, display_flag);
    }

    adjust_heights() {
        if (this.plot_data === null) return null;

        var differences = this.height_differences;
        var disp_files = this.displayed_files;
        var self = this;

        this.plot_data = this.plot_data.map(function(d) {
            var offset = self.vertical_offset * disp_files.indexOf(d.FileName);
            d.y = d.y - differences[d.FileName] + offset;
            return d;
        });
    }


    /* -------------------------------------------------------------------------
     * Getters
     * ---------------------------------------------------------------------- */

    get x_scale() {
        return d3.scaleLinear()
            .domain([this.x_min, this.x_max])
            .range([this.margin.left, this.width - this.margin.right]);
    }

    get y_scale() {
        return d3.scaleLinear()
            .domain([1, this.y_max])
            .range([this.height - this.margin.bottom, this.margin.top]);
    }

    get displayed_files() {
        if (this.file_names === null) return [];

        var disp_files = [];
        var self = this;

        this.file_names.forEach(function(file_name) {
            if (self.file_names_displayed.get(file_name)) {
                disp_files.push(file_name);
            }
        });

        return disp_files;
    }

    get height_differences() {
        if (this.file_names === null || this.plot_data === null) return null;

        var disp_files = this.displayed_files;

        // Calculating y positions for every file for every X coordinate.
        var heights = new Map();

        // Initializing arrays.
        var n = this.x_max - this.x_min + 1
        disp_files.forEach(function(d) {
            heights[d] = new Map();
            heights[d]["Max"] = new Array(n).fill(-Infinity);
            heights[d]["Min"] = new Array(n).fill(Infinity);
        });

        // Reading both minimum and maximum Y axis value for every file.
        for (var i = 0; i < n; i++) {
            this.plot_data.forEach(function(d) {
                if (d.Start <= i && i <= d.End) {
                    heights[d.FileName]["Max"][i] = Math.max(d.y, heights[d.FileName]["Max"][i]);
                    heights[d.FileName]["Min"][i] = Math.min(d.y, heights[d.FileName]["Min"][i]);
                }
            });
        }

        // Calculating differences in height between files.
        var differences = new Map();
        differences[disp_files[0]] = 0;
        for (var i = 1; i < disp_files.length; i++) {
            var lower_values = heights[disp_files[i - 1]]["Max"];
            var higher_values = heights[disp_files[i]]["Min"];
            var diffs = new Array(n).fill(Infinity);

            for (var j = 0; j < n; j++) {
                if (Number.isFinite(lower_values[j]) && Number.isFinite(higher_values[j])) {
                    diffs[j] = higher_values[j] - lower_values[j];
                }
            }

            differences[disp_files[i]] = d3.min(diffs) + differences[disp_files[i - 1]];
        }

        return differences;
    }

    get y_max() {
        return d3.max(this.plot_data.map(d => d.y));
    }


    /* -------------------------------------------------------------------------
     * Setters
     * ---------------------------------------------------------------------- */

    set color_palette(col_pal) {
        this.plot_settings.color_palette = col_pal;
        this.update_plot();
    }

    set vert_color(color) {
        document.documentElement.style.setProperty("--plot-color-vert", color);
    }

    set vert_click_color(color) {
        document.documentElement.style
            .setProperty("--plot-color-vert-click", color);
    }


    /* -------------------------------------------------------------------------
     * Drawing plot elements
     * ---------------------------------------------------------------------- */

    update_plot() {
        // This check is performed because some handlers call the update_plot
        // method before the data is uploaded.
        if (this.plot_data_raw === null) return;

        this.filter_data();

        if (this.optimize_height) {
            this.adjust_heights();
        }

        this.draw_x_axis();
        this.draw_y_axis();
        this.draw_lines();

        // Resetting verts to their default states.
        this.unmark_lines(this.vert_mark);
        this.move_vert(this.vert, this.x_min);

        this.unmark_lines(this.vert_click_mark);
        this.vert_click.style("visibility", "hidden");
    }

    draw_x_axis() {
        this.x_axis.call(d3.axisBottom().scale(this.x_scale));
    }

    draw_y_axis() {
        this.y_axis.call(d3.axisLeft().scale(this.y_scale));
    }

    draw_lines() {
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
                    .style("stroke", d => this.file_color(d.FileName));
    }

    update_background_color() {
        var color = document.getElementById("plot_background_color").value;
        this.svg.style("background", this.show_background ? color : "");
    }


    /* -------------------------------------------------------------------------
     * Lines coloring
     * ---------------------------------------------------------------------- */

    mark_lines(x_dest, class_name, remove = false) {
        var lines = this.lines.selectAll("line");

        lines.nodes().forEach(d => d.classList.remove(class_name));

        if (!remove) {
            // This round makes the guide snap to integer values on the axis.
            var x = Math.round(x_dest);

            lines.filter(d => d.Start <= x && x <= d.End).nodes()
                .forEach(d => d.classList.add(class_name));
        }
    }

    unmark_lines(class_name) {
        this.mark_lines(null, class_name, true);
    }
    
    file_color(file_name) {
        var color_id = this.displayed_files.indexOf(file_name);

        // This assures the function will work properly even if file with
        // provided file_name is currently not displayed.
        if (color_id == -1) return "black";

        var col_pal = this.plot_settings.color_palette;

        return col_pal[color_id % col_pal.length];
    }


    /* -------------------------------------------------------------------------
     * Vertical guides handling
     * ---------------------------------------------------------------------- */

    mouse_out_of_bonds(m) {
        return (m[0] < this.margin.left || m[0] > this.width - this.margin.right ||
                m[1] < this.margin.top || m[1] > this.height - this.margin.bottom)
    }

    // TODO: remove if unused.
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
