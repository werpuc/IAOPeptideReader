Shiny.addCustomMessageHandler("draw_canvas", function(_) {
    d3.select("#plot > svg").remove();
    var svg = d3.select("#plot").append("svg").attr("viewBox", "-10 -10 1280 800");
});


Shiny.addCustomMessageHandler("update_data", function(plot_data) {
    // TODO: update the plot.
    // svg.selectAll("g#data_stuff > circle").data(data).join().[...]
    console.log("Received data!");

    // This will set input[["update_plot_settings"]] to current timestamp what
    // will cause all observers including that phrase to recalculate.
    Shiny.setInputValue("update_plot_settings", Date.now(), null);
});
