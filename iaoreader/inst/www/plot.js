// <ToDo: description & commenting>
Shiny.addCustomMessageHandler('plot_draw', function(plot_data) {

    console.log(plot_data);

    const ps = plot_data.plot_settings;

    // Transforming the data
    var single_data = plot_data.data[0];
    const dane = d3.range(single_data.Start.length).map(idx => ({
        Start: single_data.Start[idx],
        End: single_data.End[idx],
        y: idx
    }));

    console.log(dane);

    // Margin
    var
        margin = {top: 30, right: 20, bottom: 30, left: 20},
        width = 960 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

    // Svg canvas
    d3.select("#js_plot").select("svg").remove();
    var svg = d3.select("#js_plot").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
    .append("g")
        .attr("transform", "translate(" + margin.left + ", " + margin.top + ")");

    /*
    var
        plot_top = margin.top,
        plot_bottom = height - margin.bottom,

        plot_left = margin.left,
        plot_right = width - margin.right;

    // Creating axes variables
    var xAxis = d3.scaleLinear()
        .domain([0, d3.max(data, function(d) { return d.End })]) // Values on the axis
        .range([plot_left, plot_right]) // Position of the axis (pixels)

    var yAxis = d3.scaleLinear()
        .domain([0, d3.max(data, function(d) { return d.y })]) // Values on the axi
        .range([plot_bottom, plot_top]) // Position of the axis (pixels)

    // Adding axes to the plot
    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0, " + height + ")")
        .call(d3.axisBottom(xAxis))
    */

    svg.append("g").selectAll("line")
        .data(dane)
        .join("line")
            .attr("x1", d => d.Start)
            .attr("y1", d => d.y)
            .attr("x2", d => d.End)
            .attr("y2", d => d.y)
            .style("stroke-width", 2)
            .style("stroke", ps.lines_color);

    // Adding text
    svg.append("text")
        .attr("x", width / 5)
        .attr("y", height / 8)
        .text(ps.title);
});
