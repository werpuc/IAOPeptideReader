# Plot Settings server function ------------------------------------------------
plot_settings <- function(input, output, session) {

    # Plot Settings input mapping ----------------------------------------------
    # This mapping allows automatic UI and server handlers generation.
    plot_settings_input_mapping <- reactive({
        mapping <- list(
            list("input_type" = "text",
                 "label" = "Plot Title")
        )

        lapply(
            mapping,
            function(meta) {
                meta[["input_id"]] <- label_to_id(meta[["label"]])
                meta
            }
        )
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
                                    meta[["label"]])
            }
        )
    })
}


# Utilities --------------------------------------------------------------------
plot_settings_input_observer <- function(input, session, input_id) {
    observe({
        session$sendCustomMessage(input_id, input[[input_id]])
    })
}

# Function created input in the UI.
plot_settings_input <- function(input_type, input_id, label) {
    stopifnot(input_type %in% "text") # TODO: extend if needed.

    input_func_name <- sprintf("%sInput", input_type)
    input_call <- call(input_func_name, input_id, label)

    eval(input_call)
}

label_to_id <- function(label) {
    gsub(" ", "_", tolower(label))
}
