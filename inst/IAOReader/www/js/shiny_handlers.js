Shiny.addCustomMessageHandler("initialize_iaoreader", function(_) {
    iaoreader = new IAOReader();
});


Shiny.addCustomMessageHandler("update_seq_len", function(seq_len) {
    iaoreader.x_max = seq_len;
    iaoreader.update_plot();
});


Shiny.addCustomMessageHandler("update_data", function(plot_data) {
    iaoreader.update_plot_data(plot_data)
    iaoreader.update_plot();
});


Shiny.addCustomMessageHandler("set_file_visibility", function(file_vis) {
    iaoreader.set_file_visibility(file_vis.FileName, file_vis.Visibility);
    iaoreader.update_plot();
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
    iaoreader.download_svg();
});


Shiny.addCustomMessageHandler("update_plot", function(_) {
    iaoreader.update_plot();
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
    iaoreader.title_text = title_text;
    iaoreader.draw_plot_title();
});

Shiny.addCustomMessageHandler("plot_settings_title_font_size", function(font_size) {
    if (10 <= font_size && font_size <= 48) {
        iaoreader.title_font_size = font_size;
    }
});

Shiny.addCustomMessageHandler("plot_settings_title_bold", function(title_bold) {
    iaoreader.title.attr("font-weight", title_bold ? "bold" : "normal");
});


// [[ Vertical guide ]]
Shiny.addCustomMessageHandler("plot_settings_show_tooltip", function(show_tooltip) {
    iaoreader.show_tooltip = show_tooltip;
});

Shiny.addCustomMessageHandler("plot_settings_vert_show", function(vert_show) {
    // vert_show attribute is tracked by the mousemove handler.
    iaoreader.vert_show = vert_show;
    iaoreader.vert.style("visibility", vert_show ? "visible" : "hidden");
    iaoreader.unmark_lines("vert-mark");
});

Shiny.addCustomMessageHandler("plot_settings_allow_verts_marking", function(allow_marking) {
    var cl = iaoreader.lines.node().classList;

    if (allow_marking) {
        cl.add("allow-verts-marking");
        return
    }

    cl.remove("allow-verts-marking");
});

Shiny.addCustomMessageHandler("plot_settings_k_parameter", function(k_parameter) {
    if (k_parameter >= 0) {
        iaoreader.k_parameter = k_parameter;
        iaoreader.redraw_vert(iaoreader.vert);
        iaoreader.redraw_vert(iaoreader.vert_click);
        iaoreader.redraw_vert(iaoreader.vert_drag_end);
        iaoreader.draw_plot_title();
    }
});

Shiny.addCustomMessageHandler("plot_settings_title_includes_k", function(include_k) {
    iaoreader.title_includes_k = include_k;
    iaoreader.draw_plot_title();
});

Shiny.addCustomMessageHandler("plot_settings_show_lambda_values", function(show_lambda_values) {
    iaoreader.show_lambda_values = show_lambda_values;
    iaoreader.redraw_vert(iaoreader.vert);
    iaoreader.redraw_vert(iaoreader.vert_click);
    iaoreader.redraw_vert(iaoreader.vert_drag_end);
});

Shiny.addCustomMessageHandler("plot_settings_lambda_values_bg_invert", function(lambda_values_bg_invert) {
    iaoreader.lambda_values_bg_invert = lambda_values_bg_invert;
    iaoreader.svg.selectAll(".verts rect.lambda")
        .style("filter", "invert(" + +lambda_values_bg_invert + ")");
});


// [[ Height adjustments ]]
Shiny.addCustomMessageHandler("plot_settings_optimize_height", function(optimize_height) {
    iaoreader.optimize_height = optimize_height;
    iaoreader.update_plot();
});

Shiny.addCustomMessageHandler("plot_settings_vertical_offset", function(vertical_offset) {
    iaoreader.vertical_offset = vertical_offset;
    iaoreader.update_plot();
});


// [[ Axes settings ]]
Shiny.addCustomMessageHandler("plot_settings_axes_labels_font_size", function(font_size) {
    if (0 <= font_size && font_size <= 26) {
        iaoreader.axes_labels_font_size = font_size;
        iaoreader.redraw_vert(iaoreader.vert);
        iaoreader.redraw_vert(iaoreader.vert_click);
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

    iaoreader.color_palette = color_palette;
    iaoreader.update_plot();
});

Shiny.addCustomMessageHandler("plot_settings_show_background", function(show_background) {
    iaoreader.background
        .style("visibility", show_background ? "visible" : "hidden");
});
