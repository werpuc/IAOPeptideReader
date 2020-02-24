# Plot Settings tab UI ---------------------------------------------------------
plot_settings_ui <- function() {
    tabPanel(
        "Plot Settings",
        lapply(
            plot_settings_input_mapping(),
            function(meta) {
                plot_settings_input(meta[["input_type"]], meta[["label"]])
            }
        )
    )
}


# This mapping allows automatic UI and server handlers generation.
plot_settings_input_mapping <- function() {
    list(
        list("input_type" = "text",
             "label" = "Plot Title")
    )
}


# Utilities --------------------------------------------------------------------
plot_settings_input <- function(input_type, label) {
    stopifnot(input_type %in% "text") # TODO: extend if needed.

    input_func_name <- sprintf("%sInput", input_type)
    input_call <- call(input_func_name, label_to_id(label), label)

    eval(input_call)
}


label_to_id <- function(label) {
    gsub(" ", "_", tolower(label))
}
