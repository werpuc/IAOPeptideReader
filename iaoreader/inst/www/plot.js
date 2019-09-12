// <ToDo: description>
Shiny.addCustomMessageHandler('plot_draw', function(data) {

    // Margin
    var
        margin = {top: 30, right: 20, bottom: 30, left: 20},
        width = 960 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

    // Svg canvas
    d3.select("#js_plot").select("svg").remove();
    var svg = d3.select("#js_plot").append("svg");

    svg.attr("width", width)
        .attr("height", height);

    // Example circles positions and radius
    var radius = data.tmp_radius;
    const circles = d3.range(20).map(i => ({
        x: Math.random() * (width - radius * 2) + radius,
        y: Math.random() * (height - radius * 2) + radius
    }));

    // Drawing circles
    svg.selectAll("circle")
        .data(circles)
        .join("circle")
            .attr("cx", d => d.x)
            .attr("cy", d => d.y)
            .attr("r", radius)
            .style("fill", data.plot_settings_text_color);

    // Adding text
    svg.append("text")
        .attr("x", width / 2)
        .attr("y", height / 2)
        .text(data.plot_settings_title);
});
