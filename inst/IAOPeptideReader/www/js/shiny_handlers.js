Shiny.addCustomMessageHandler("initialize_iaopr", function(_) {
    iaopr = new IAOPeptideReader();
});


Shiny.addCustomMessageHandler("update_seq_start", function(seq_start) {
    iaopr.x_min = seq_start;
    iaopr.update_plot();
});


Shiny.addCustomMessageHandler("update_seq_len", function(seq_len) {
    iaopr.x_max = seq_len;
    iaopr.update_plot();
});


Shiny.addCustomMessageHandler("update_data", function(plot_data) {
    iaopr.update_plot_data(plot_data)
    iaopr.update_plot();

    // This setTimeout allows operations to finish.
    setTimeout(function() { iaopr.calculate_summary_table(); }, 300);
});


Shiny.addCustomMessageHandler("set_file_visibility", function(file_vis) {
    iaopr.set_file_visibility(file_vis.FileName, file_vis.Visibility);
    iaopr.update_plot();
});


Shiny.addCustomMessageHandler("seq_start_check", function(is_ok) {
    var seq_start_input = document.getElementById("sequence_start");

    if (is_ok) {
        seq_start_input.removeAttribute("is_wrong");
    } else {
        seq_start_input.setAttribute("is_wrong", "");
    }
});


Shiny.addCustomMessageHandler("seq_len_check", function(is_ok) {
    var seq_len_input = document.getElementById("sequence_length");

    if (is_ok) {
        seq_len_input.removeAttribute("is_wrong");
    } else {
        seq_len_input.setAttribute("is_wrong", "");
    }
});


Shiny.addCustomMessageHandler("download_svg", function(_) {
    iaopr.download_svg();
});


Shiny.addCustomMessageHandler("calculate_summary_table", function(_) {
    iaopr.calculate_summary_table();
});


/* -----------------------------------------------------------------------------
 * Plot settings
 * -------------------------------------------------------------------------- */

Shiny.addCustomMessageHandler("reset_color_input", function(reset_meta) {
    var color_input = document.getElementById(reset_meta.input_id);
    color_input.value = reset_meta.color;
    color_input.dispatchEvent(new Event("change"));
});


// [[ Plot title ]]
Shiny.addCustomMessageHandler("plot_settings_title_text", function(title_text) {
    iaopr.title_text = title_text;
    iaopr.draw_plot_title();
});

Shiny.addCustomMessageHandler("plot_settings_title_font_size", function(font_size) {
    if (10 <= font_size && font_size <= 48) {
        iaopr.title_font_size = font_size;
    }
});

Shiny.addCustomMessageHandler("plot_settings_title_bold", function(title_bold) {
    iaopr.title.attr("font-weight", title_bold ? "bold" : "normal");
});


// [[ Vertical guide ]]
Shiny.addCustomMessageHandler("plot_settings_mark_line", function(mark_line) {
    iaopr.mark_line = mark_line;
});

Shiny.addCustomMessageHandler("plot_settings_show_tooltip", function(show_tooltip) {
    iaopr.show_tooltip = show_tooltip;
});

Shiny.addCustomMessageHandler("plot_settings_vert_show", function(vert_show) {
    // vert_show attribute is tracked by the mousemove handler.
    iaopr.vert_show = vert_show;
    iaopr.vert.style("visibility", vert_show ? "visible" : "hidden");
    iaopr.unmark_lines("vert-mark");
});

Shiny.addCustomMessageHandler("plot_settings_allow_verts_marking", function(allow_marking) {
    var cl = iaopr.lines.node().classList;

    if (allow_marking) {
        cl.add("allow-verts-marking");
        return
    }

    cl.remove("allow-verts-marking");
});

Shiny.addCustomMessageHandler("plot_settings_k_parameter", function(k_parameter) {
    if (k_parameter >= 0) {
        iaopr.k_parameter = k_parameter;
        iaopr.redraw_vert(iaopr.vert);
        iaopr.redraw_vert(iaopr.vert_click);
        iaopr.redraw_vert(iaopr.vert_drag_end);
        iaopr.draw_plot_title();
    }
});

Shiny.addCustomMessageHandler("plot_settings_title_includes_k", function(include_k) {
    iaopr.title_includes_k = include_k;
    iaopr.draw_plot_title();
});

Shiny.addCustomMessageHandler("plot_settings_show_lambda_values", function(show_lambda_values) {
    iaopr.show_lambda_values = show_lambda_values;
    iaopr.redraw_vert(iaopr.vert);
    iaopr.redraw_vert(iaopr.vert_click);
    iaopr.redraw_vert(iaopr.vert_drag_end);
});

Shiny.addCustomMessageHandler("plot_settings_lambda_values_bg_invert", function(lambda_values_bg_invert) {
    iaopr.lambda_values_bg_invert = lambda_values_bg_invert;
    iaopr.svg.selectAll(".verts rect.lambda")
        .style("filter", "invert(" + +lambda_values_bg_invert + ")");
});


// [[ Height adjustments ]]
Shiny.addCustomMessageHandler("plot_settings_optimize_height", function(optimize_height) {
    iaopr.optimize_height = optimize_height;
    iaopr.update_plot();
});

Shiny.addCustomMessageHandler("plot_settings_vertical_offset", function(vertical_offset) {
    iaopr.vertical_offset = vertical_offset;
    iaopr.update_plot();
});


// [[ Axes settings ]]
Shiny.addCustomMessageHandler("plot_settings_axes_labels_font_size", function(font_size) {
    if (0 <= font_size && font_size <= 26) {
        iaopr.axes_labels_font_size = font_size;
        iaopr.redraw_vert(iaopr.vert);
        iaopr.redraw_vert(iaopr.vert_click);
        iaopr.redraw_vert(iaopr.vert_drag_start, false);
        iaopr.redraw_vert(iaopr.vert_drag_end, false);
    }
});


// [[ Legend Settings ]]
Shiny.addCustomMessageHandler("plot_settings_show_legend", function(show_legend) {
    iaopr.legend.style("visibility", show_legend ? "visible" : "hidden");
});

Shiny.addCustomMessageHandler("plot_settings_legend_font_size", function(font_size) {
    if (8 <= font_size && font_size <= 26) {
        iaopr.legend_size = font_size;
        iaopr.draw_legend();
    }
});


// [[ Color settings ]]
Shiny.addCustomMessageHandler("plot_settings_color_palette", function(color_palette_name) {
    var color_palette;

    // For color palette details refer to below links:
    // https://colorbrewer2.org/
    // https://github.com/d3/d3-scale-chromatic
    switch (color_palette_name) {
        case "Accent":
            color_palette = d3.schemeAccent;
            break;
        case "Category10":
            color_palette = d3.schemeCategory10;
            break;
        case "Dark2":
            color_palette = d3.schemeDark2;
            break;
        case "Paired":
            color_palette = d3.schemePaired;
            break;
        case "Pastel1":
            color_palette = d3.schemePastel1;
            break;
        case "Pastel2":
            color_palette = d3.schemePastel2;
            break;
        case "Set1":
            color_palette = d3.schemeSet1;
            break;
        case "Set2":
            color_palette = d3.schemeSet2;
            break;
        case "Set3":
            color_palette = d3.schemeSet3;
            break;
        case "Tableau10":
            color_palette = d3.schemeTableau10;
            break;
        default:
            color_palette = d3.schemeSet1;
    }

    iaopr.color_palette = color_palette;
    iaopr.update_plot();
});

Shiny.addCustomMessageHandler("plot_settings_show_background", function(show_background) {
    iaopr.background
        .style("visibility", show_background ? "visible" : "hidden");
});
