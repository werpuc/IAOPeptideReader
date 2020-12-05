source(file.path("modals", "color_info.R"), local = TRUE)
source(file.path("modals", "file_info.R"), local = TRUE)
source(file.path("modals", "measure_info.R"), local = TRUE)
source(file.path("modals", "plot_info.R"), local = TRUE)


modals <- function(input, output, session) {
    # Color info ---------------------------------------------------------------
    observeEvent(input[["color_info"]], {
        modal <- color_info_modal()
        showModal(modal)
    })

    # File info ----------------------------------------------------------------
    observeEvent(input[["file_info"]], {
        modal <- file_info_modal()
        showModal(modal)
    })

    # Measure info -------------------------------------------------------------
    observeEvent(input[["measure_info"]], {
        modal <- measure_info_modal(NULL)
        showModal(modal)
    })

    observeEvent(input[["measure_info_return_plot"]], {
        modal <- measure_info_modal("plot_info")
        showModal(modal)
    })

    # Plot info ----------------------------------------------------------------
    observeEvent(input[["plot_info"]], {
        modal <- plot_info_modal()
        showModal(modal)
    })
}


modal_footer <- function(observer_id = NULL) {
    div(
        align = "center",
        if (!is.null(observer_id)) {
            actionButton(
                sprintf("return_button_%.0f", Sys.time()), "Return",
                onclick = sprintf(
                    "Shiny.setInputValue('%s', Date.now());", observer_id
                )
            )
        },
        modalButton("Dismiss")
    )
}
