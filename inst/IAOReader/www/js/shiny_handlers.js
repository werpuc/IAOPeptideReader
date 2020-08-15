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
    iaoreader.title.text(title_text);
});


Shiny.addCustomMessageHandler("plot_settings_title_font_size", function(font_size) {
    iaoreader.title_font_size = font_size;
});

// [[ Vertical guide ]]
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


// [[ Height adjustments ]]
Shiny.addCustomMessageHandler("plot_settings_optimize_height", function(optimize_height) {
    iaoreader.optimize_height = optimize_height;
    iaoreader.update_plot();
});

Shiny.addCustomMessageHandler("plot_settings_vertical_offset", function(vertical_offset) {
    iaoreader.vertical_offset = vertical_offset;
    iaoreader.update_plot();
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
    iaoreader.show_background = show_background;

    var color = document.getElementById("plot_background_color").value;
    iaoreader.background_color = color;
});
