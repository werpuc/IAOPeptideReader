let IAOReader = class {
    // Canvas dimensions.
    width = 1280; height = 720; margin = 30;

    // Plot elements.
    svg; x_axis; y_axis; lines;

    // Axis limits values.
    x_min; x_max;

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


    draw_data(plot_info) {
        var svg = this.svg;
        var x = svg.attr("_x"), y = svg.attr("_y"), margin = svg.attr("_margin");
        // Unpacking informations from plot_info JSON.
        var seq_len = plot_info.seq_len;
        var plot_data = plot_info.plot_data;

        this.x_min = 1;
        this.x_max = seq_len;

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

//    x_axis = {
//        domain: {
//            min: 1,
//            max: 2
//        },
//        scale: function() {
//            return d3.scaleLinear().domain([this.x_axis.domain.min, this.x_axis.domain.max]).range([this.margin, this.width - this.margin]);
//        }
//    }
//    get x_scale() {
//        // TODO: on scale update redraw the data.
//        return d3.scaleLinear().domain([this.x_axis.domain.min, this.x_axis.domain.max]).range([this.margin, this.width - this.margin]);
//    }
