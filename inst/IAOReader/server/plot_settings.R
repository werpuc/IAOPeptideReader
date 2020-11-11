# Plot Settings server function ------------------------------------------------
plot_settings <- function(input, output, session) {
    # Plot Settings input mapping ----------------------------------------------
    # This mapping allows automatic UI and server handlers generation.
    plot_settings_input_mapping <- reactive({
        width <- "40%"
        default_palette <- "Set1"
        palettes <- c("Accent", "Category10", "Dark2", "Paired", "Pastel1",
                      "Pastel2", "Set1", "Set2", "Set3", "Tableau10")

        mapping <- list(
            h3("Title Settings"),
            list("input_id" = "plot_settings_title_text",
                 "input_type" = "text",
                 "label" = "Plot title",
                 "value" = "Peptide Coverage"),
            list("input_id" = "plot_settings_title_font_size",
                 "input_type" = "numeric",
                 "label" = "Title font size [px]",
                 "value" = "20",
                 "min" = 10, "max" = 48, "step" = 1, "width" = width),
            list("input_id" = "plot_settings_title_bold",
                 "input_type" = "checkbox",
                 "label" = "Bold font",
                 "value" = FALSE),
            list("input_id" = "plot_settings_title_color",
                 "input_type" = "color",
                 "label" = "Title color",
                 "value" = "#000000",
                 "onchange" = "iaoreader.title_color = this.value;",
                 "width" = width),
            h3("Vertical Guides and Mouse Events"),
            list("input_id" = "plot_settings_show_tooltip",
                 "input_type" = "checkbox",
                 "label" = "Show toolip",
                 "value" = TRUE),
            list("input_id" = "plot_settings_mark_line",
                 "input_type" = "checkbox",
                 "label" = "Bold lines on mouseover",
                 "value" = TRUE),
            list("input_id" = "plot_settings_vert_show",
                 "input_type" = "checkbox",
                 "label" = "Show guide on mouseover",
                 "value" = TRUE),
            list("input_id" = "plot_settings_allow_verts_marking",
                 "input_type" = "checkbox",
                 "label" = "Color lines crossing the guides",
                 "value" = TRUE),
            list("input_id" = "plot_settings_vert_color",
                 "input_type" = "color",
                 "label" = "Mouseover guide color",
                 "value" = "#00008B",
                 "onchange" = "iaoreader.vert_color = this.value;",
                 "width" = width),
            list("input_id" = "plot_settings_vert_click_color",
                 "input_type" = "color",
                 "label" = "Persistent guide color",
                 "value" = "#8B008B",
                 "onchange" = "iaoreader.vert_click_color = this.value;",
                 "width" = width),
            list("input_id" = "plot_settings_vert_drag_color",
                 "input_type" = "color",
                 "label" = "Drag guides color",
                 "value" = "#FF1493",
                 "onchange" = "iaoreader.vert_drag_color = this.value;",
                 "width" = width),
            list("input_id" = "plot_settings_show_lambda_values",
                 "input_type" = "checkbox",
                 "label" = "Show measure values",
                 "value" = TRUE),
            modal_label_link("k_param_info", "K penalty parameter"),
            list("input_id" = "plot_settings_k_parameter",
                 "input_type" = "numeric",
                 "label" = NULL,
                 "value" = "3",
                 "min" = 0, "step" = 1, "width" = width),
            list("input_id" = "plot_settings_title_includes_k",
                 "input_type" = "checkbox",
                 "label" = "Include k parameter in title",
                 "value" = TRUE),
            list("input_id" = "plot_settings_lambda_values_bg",
                 "input_type" = "color",
                 "label" = "Measure values background color",
                 "value" = "#FFFFFF",
                 "onchange" = "iaoreader.lambda_values_bg = this.value;",
                 "width" = width),
            list("input_id" = "plot_settings_lambda_values_bg_invert",
                 "input_type" = "checkbox",
                 "label" = "Invert measure values background color",
                 "value" = TRUE),
            h3("Plot Space Optimization"),
            list("input_id" = "plot_settings_optimize_height",
                 "input_type" = "checkbox",
                 "label" = "Optimize the plot's height",
                 "value" = TRUE),
            list("input_id" = "plot_settings_vertical_offset",
                 "input_type" = "numeric",
                 "label" = "Vertical spacing between files",
                 "value" = 5,
                 "min" = 1, "step" = 1, "width" = width),
            h3("Axes Settings"),
            list("input_id" = "plot_settings_axes_color",
                 "input_type" = "color",
                 "label" = "Axes color",
                 "value" = "#000000",
                 "onchange" = "iaoreader.axes_color = this.value;",
                 "width" = width),
            list("input_id" = "plot_settings_axes_labels_color",
                 "input_type" = "color",
                 "label" = "Axes labels color",
                 "value" = "#000000",
                 "onchange" = "iaoreader.axes_labels_color = this.value;",
                 "width" = width),
            list("input_id" = "plot_settings_axes_labels_font_size",
                 "input_type" = "numeric",
                 "label" = "Axes labels font size [px]",
                 "value" = "10",
                 "min" = 0, "max" = 26, "step" = 1, "width" = width),
            h3("Legend Settings"),
            list("input_id" = "plot_settings_show_legend",
                 "input_type" = "checkbox",
                 "label" = "Show legend",
                 "value" = TRUE),
            list("input_id" = "plot_settings_legend_font_size",
                 "input_type" = "numeric",
                 "label" = "Legend labels font size [px]",
                 "value" = 12,
                 "min" = 8, "max" = 26, "step" = 1, "width" = width),
            h3("Color Settings"),
            modal_label_link("color_info", "Lines color palette"),
            list("input_id" = "plot_settings_color_palette",
                 "input_type" = "select",
                 "label" = NULL,
                 "value" = palettes,
                 "selected" = default_palette, "width" = width),
            list("input_id" = "plot_settings_show_background",
                 "input_type" = "checkbox",
                 "label" = "Show background",
                 "value" = TRUE),
            list("input_id" = "plot_background_color",
                 "input_type" = "color",
                 "label" = "Background color",
                 "value" = "#FFFFFF",
                 "onchange" = "iaoreader.background_color = this.value;",
                 "width" = width)
        )

        mapping
    })


    # Server and UI generation -------------------------------------------------
    output[["plot_settings_inputs"]] <- renderUI({
        lapply(
            plot_settings_input_mapping(),
            function(meta) {
                if (!is_plot_settings_meta(meta)) return(meta)
                # Server
                plot_settings_input_observer(input, session, meta[["input_id"]])

                # UI (this is the returned value for the renderUI)
                do.call(plot_settings_input, meta)
            }
        )
    })

    # This line makes the UI render before the Plot Settings tab is selected,
    # therefore creating the server functions and updating the plot without the
    # need of entering this tab first.
    outputOptions(output, "plot_settings_inputs", suspendWhenHidden = FALSE)


    # Reset button observer ----------------------------------------------------
    observeEvent(input[["plot_settings_reset"]], {
        lapply(
            plot_settings_input_mapping(),
            function(meta) {
                if (!is_plot_settings_meta(meta)) return()

                input_type <- meta[["input_type"]]
                substr(input_type, 1, 1) <- toupper(substr(input_type, 1, 1))

                update_func_name <- sprintf("update%sInput", input_type)

                update_call <- call(update_func_name, session,
                                    meta[["input_id"]], value = meta[["value"]])

                if (input_type == "Select") {
                    update_call <- call(update_func_name, session,
                                        meta[["input_id"]], NULL,
                                        meta[["value"]], meta[["selected"]])
                }

                eval(update_call)
            }
        )
    })
}


# Color Input ------------------------------------------------------------------
colorInput <- function(input_id, label, value, onchange, width) {
    div(class = "color_input",
        h5(label),
        tags$input(id = input_id, type = "color", value = value,
                   onchange = onchange, style = sprintf("width: %s;", width)))
}

updateColorInput <- function(session, input_id, value) {
    reset_meta <- list("input_id" = input_id, "color" = value)
    session$sendCustomMessage("reset_color_input", reset_meta)
}


# Utilities --------------------------------------------------------------------
# Function creating input's server backend.
plot_settings_input_observer <- function(input, session, input_id) {
    observe({
        session$sendCustomMessage(input_id, input[[input_id]])
    })
}

# Function creating input in the UI.
plot_settings_input <- function(input_type, input_id, label, value, ...) {
    stopifnot(input_type %in% c("text", "checkbox", "numeric", "select",
                                "color"))

    input_func_name <- sprintf("%sInput", input_type)
    call_args <- list(input_func_name, input_id, label, value, ...)
    input_call <- do.call(call, call_args)

    eval(input_call)
}

is_plot_settings_meta <- function(meta) {
    req_names <- c("input_id", "input_type", "label", "value")
    setequal(names(meta)[1:4], req_names)
}
