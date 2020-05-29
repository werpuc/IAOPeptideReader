let IAOReader = class {
    width = 1280;
    height = 720;
    margin = 30;

    constructor() {
        var plot_div = d3.select("div#plot");
        var svg = plot_div.select("svg");

        // Creating the SVG if it does not exist.
        if (svg.empty()) {
            // TODO: remove redundant parameters
            svg = plot_div.append("svg")
                .attr("_x", this.width)
                .attr("_y", this.height)
                .attr("_margin", this.margin)
                .attr("viewBox", "0 0 " + this.width + " " + this.height);
        }

        this.plot_settings = new PlotSettings(svg, this.margin);
        this.svg = svg;
    }

    // TODO: add plot settings parameters object.
    // TODO: move axis creation, scales, max_seq_len etc. to this class.
}


// This variable has valueu assigned by Shiny main server function.
var iaoreader;
