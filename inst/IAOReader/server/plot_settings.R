# Plot Settings server function ------------------------------------------------
plot_settings <- function(input, output, session) {
    # Plot Settings input mapping ----------------------------------------------
    # This mapping allows automatic UI and server handlers generation.
    plot_settings_input_mapping <- reactive({
        mapping <- list(
            list("input_id" = "plot_settings_title_text",
                 "input_type" = "text",
                 "label" = "Plot Title",
                 "value" = "Peptide Coverage"),
            h3("Vertical guides"),
            list("input_id" = "plot_settings_vert_show",
                 "input_type" = "checkbox",
                 "label" = "Show guide on mouseover",
                 "value" = TRUE),
            list("input_id" = "plot_settings_allow_verts_marking",
                 "input_type" = "checkbox",
                 "label" = "Color lines crossing the guides",
                 "value" = TRUE),
            h3("Plot space optimization"),
            list("input_id" = "plot_settings_optimize_height",
                 "input_type" = "checkbox",
                 "label" = "Optimize plot's height",
                 "value" = TRUE),
            list("input_id" = "plot_settings_vertical_offset",
                 "input_type" = "numeric",
                 "label" = "Vertical spacing between files",
                 "value" = 5,
                 "min" = 1, "step" = 1, "width" = "40%"),
            h3("Color settings"),
            list("input_id" = "plot_settings_show_background",
                 "input_type" = "checkbox",
                 "label" = "Show background",
                 "value" = TRUE),
            div(id = "background_color_input",
                h5("Background color"),
                tags$input(id = "plot_background_color", type = "color",
                           onchange = "iaoreader.update_background_color()",
                           value = "#ffffff")),
            list("input_id" = "plot_settings_color_palette",
                 "input_type" = "select",
                 "label" = "Lines color palette",
                 "value" = c("Accent", "Category10", "Dark2", "Paired",
                             "Pastel1", "Pastel2", "Set1", "Set2", "Set3",
                             "Tableau10"),
                 "selected" = "Set1", "width" = "40%")
            # TODO: coloring mouseover vert.
            # TODO: coloring click vert.
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
        session$sendCustomMessage("reset_background_color", 1)

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


# Utilities --------------------------------------------------------------------
# Function creating input's server backend.
plot_settings_input_observer <- function(input, session, input_id) {
    observe({
        session$sendCustomMessage(input_id, input[[input_id]])
    })
}

# Function creating input in the UI.
plot_settings_input <- function(input_type, input_id, label, value, ...) {
    stopifnot(input_type %in% c("text", "checkbox", "numeric", "select")) # TODO: extend if needed.

    input_func_name <- sprintf("%sInput", input_type)
    call_args <- list(input_func_name, input_id, label, value, ...)
    input_call <- do.call(call, call_args)

    eval(input_call)
}

is_plot_settings_meta <- function(meta) {
    req_names <- c("input_id", "input_type", "label", "value")
    setequal(names(meta)[1:4], req_names)
}
