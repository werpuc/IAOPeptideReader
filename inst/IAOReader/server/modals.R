source(file.path("modals", "color_info.R"), local = TRUE, chdir = TRUE)
source(file.path("modals", "file_info.R"), local = TRUE, chdir = TRUE)
source(file.path("modals", "k_param_info.R"), local = TRUE, chdir = TRUE)
source(file.path("modals", "measure_info.R"), local = TRUE, chdir = TRUE)


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
        modal <- k_param_info_modal()
        showModal(modal)
    })

    observeEvent(input[["k_param_info_return"]], {
        modal <- k_param_info_modal("measure_info")
        showModal(modal)
    })

    # Measure info -------------------------------------------------------------
    observeEvent(input[["measure_info"]], {
        modal <- measure_info_modal()
        showModal(modal)
    })

    observeEvent(input[["measure_info_return"]], {
        modal <- measure_info_modal("k_param_info")
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
