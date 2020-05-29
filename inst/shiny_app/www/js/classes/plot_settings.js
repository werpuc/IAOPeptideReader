let PlotSettings = class {
    constructor(svg, margin) {
        this.svg = svg;

        // Creating title.
        svg.append("text")
            .attr("id", "plot_title")
            .attr("text-anchor", "middle")
            .attr("x", "50%")
            .attr("y", margin / 2 + "px");
    }

    get title() {
        return this.svg.select("text#plot_title");
    }
}
