source(file.path("modals", "color_info.R"), local = TRUE)
source(file.path("modals", "file_info.R"), local = TRUE)
source(file.path("modals", "k_param_info.R"), local = TRUE)
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

    # K parameter info ---------------------------------------------------------
    observeEvent(input[["k_param_info"]], {
        # No return, link to measure info modal with return.
        modal <- k_param_info_modal(NULL, "measure_info_return")
        showModal(modal)
    })

    observeEvent(input[["k_param_info_return"]], {
        # Return to measure info modal without return, link to measure info
        # modal with return.
        modal <- k_param_info_modal("measure_info", "measure_info_return")
        showModal(modal)
    })

    observeEvent(input[["k_param_info_return_plot"]], {
        # Return and link to measure info modal which returns to plot info
        # modal.
        modal <- k_param_info_modal(
            "measure_info_return_plot",
            "measure_info_return_plot"
        )
        showModal(modal)
    })

    # Measure info -------------------------------------------------------------
    observeEvent(input[["measure_info"]], {
        # No return, link to k param info modal with return.
        modal <- measure_info_modal(NULL, "k_param_info_return")
        showModal(modal)
    })

    observeEvent(input[["measure_info_return"]], {
        # Return to k param info modal without return, link to k param info
        # modal with return.
        modal <- measure_info_modal("k_param_info", "k_param_info_return")
        showModal(modal)
    })

    observeEvent(input[["measure_info_return_plot"]], {
        # Return to plot info modal, link to k param info modal which returns to
        # this modal.
        modal <- measure_info_modal("plot_info", "k_param_info_return_plot")
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
