# Plot Settings server function ------------------------------------------------
plot_settings <- function(input, output, session) {

    # Plot Settings input mapping ----------------------------------------------
    # This mapping allows automatic UI and server handlers generation.
    plot_settings_input_mapping <- reactive({
        mapping <- list(
            list("input_id" = "plot_settings_title_text",
                 "input_type" = "text",
                 "label" = "Plot Title",
                 "value" = "Peptide Coverage")
        )

        mapping
    })


    # Server and UI generation -------------------------------------------------
    output[["plot_settings_inputs"]] <- renderUI({
        lapply(
            plot_settings_input_mapping(),
            function(meta) {
                # Server
                plot_settings_input_observer(input, session, meta[["input_id"]])

                # UI (this is the returned value for the renderUI)
                plot_settings_input(meta[["input_type"]], meta[["input_id"]],
                                    meta[["label"]], meta[["value"]])
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
                input_type <- meta[["input_type"]]
                substr(input_type, 1, 1) <- toupper(substr(input_type, 1, 1))

                update_func_name <- sprintf("update%sInput", input_type)
                update_call <- call(update_func_name, session,
                                    meta[["input_id"]], value = meta[["value"]])

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
plot_settings_input <- function(input_type, input_id, label, value) {
    stopifnot(input_type %in% "text") # TODO: extend if needed.

    input_func_name <- sprintf("%sInput", input_type)
    input_call <- call(input_func_name, input_id, label, value)

    eval(input_call)
}
