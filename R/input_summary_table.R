# single_file_input_meta structure:
#   list(
#       "input_id" = /character/
#       "file_name" = /character/,
#       "is_ok" = /TRUE or FALSE/,
#       "error_messages" = /character vector or NULL/,
#       "sequence_length" = /numeric or NULL/,
#       "protein_state_mapping" = /named (character) list of character vectors or NULL/
#       "selected_protein" = /character or NULL/,
#       "selected_state" = /character or NULL/,
#       "display" = /TRUE or FALSE/
#   )
input_summary_row_ui <- function(single_file_input_meta) {
    input_id <- single_file_input_meta[["input_id"]]
    is_ok <- single_file_input_meta[["is_ok"]]

    row_class <- "import_summary_row"
    if (!is_ok) {
        row_class <- c(row_class, "error")
    }

    prot_state_mapping <- single_file_input_meta[["protein_state_mapping"]]

    protein_choices <- names(prot_state_mapping)
    protein <- single_file_input_meta[["selected_protein"]]
    if (is.null(protein)) protein <- protein_choices[1]

    state_choices <- prot_state_mapping[[protein]]
    state <- single_file_input_meta[["selected_state"]]
    if (is.null(state)) state <- state_choices[1]

    tags$tr(
        class = paste(row_class, collapse = " "),
        title = paste(
            single_file_input_meta[["error_messages"]],
            collapse = "\n"
        ),
        tags$td(
            tags$p(
                title = single_file_input_meta[["file_name"]],
                single_file_input_meta[["file_name"]]
            )
        ),
        tags$td(tags$p(single_file_input_meta[["sequence_length"]])),
        tags$td(
            if (is_ok) {
                selectInput(
                    sprintf("%s_protein", input_id), NULL, protein_choices, protein
                )
            }
        ),
        tags$td(
            if (is_ok) {
                selectInput(
                    sprintf("%s_state", input_id), NULL, state_choices, state
                )
            }
        ),
        tags$td(
            if (is_ok) {
                checkboxInput(sprintf("%s_display", input_id), NULL, single_file_input_meta[["display"]])
            }
        ),
        tags$td(
            actionButton(
                sprintf("%s_remove", input_id), "Remove",
                title = "Removes uploaded file."
            )
        )
    )
}


input_summary_row_server <- function(single_file_input_meta, input, session,
                                     input_settings_rv) {
    input_id <- single_file_input_meta[["input_id"]]
    protein_id <- sprintf("%s_protein", input_id)
    state_id <- sprintf("%s_state", input_id)
    display_id <- sprintf("%s_display", input_id)
    remove_id <- sprintf("%s_remove", input_id)
    file_name <- single_file_input_meta[["file_name"]]
    prot_state_mapping <- single_file_input_meta[["protein_state_mapping"]]

    # Updater for the state choices based on protein selection.
    obs1 <- observe({
        selected_protein <- input[[protein_id]]
        req(selected_protein)

        state_choices <- prot_state_mapping[[selected_protein]]
        updateSelectInput(session, state_id, choices = state_choices)
    })

    # This observer saves state of every row to file_meta in order to redraw
    # the summary table without the deleted row preserving other rows settings.
    obs2 <- observeEvent(input[[remove_id]], ignoreInit = TRUE, once = TRUE, {
        input_settings_rv[["fm"]][[file_name]] <- NULL
        input_settings_rv[["data"]][[file_name]] <- NULL

        # Note: sfim_* objects refer to the row currently being saved while
        #       objects without this prefix refer to the deleted row.
        for (sfim in input_settings_rv[["fm"]]) {
            sfim_file_name <- sfim[["file_name"]]
            sfim_input_id <- sfim[["input_id"]]
            sfim_protein_id <- sprintf("%s_protein", sfim_input_id)
            sfim_state_id <- sprintf("%s_state", sfim_input_id)
            sfim_display_id <- sprintf("%s_display", sfim_input_id)

            input_settings_rv[["fm"]][[sfim_file_name]][["selected_protein"]] <- input[[sfim_protein_id]]
            input_settings_rv[["fm"]][[sfim_file_name]][["selected_state"]] <- input[[sfim_state_id]]
            input_settings_rv[["fm"]][[sfim_file_name]][["display"]] <- input[[sfim_display_id]]
        }
    })

    # This observer updates visibility settings for given file.
    obs3 <- observe({
        display <- input[[display_id]]
        file_vis <- list("FileName" = file_name, "Visibility" = display)
        session$sendCustomMessage("set_file_visibility", file_vis)

        req(
            !is.null(display),
            # In order to not trigger on file's removal.
            isolate(input_settings_rv[["fm"]][[file_name]])
        )
        input_settings_rv[["fm"]][[file_name]][["display"]] <- display
    })

    # Saving the observers to destroy them manually on new file upload.
    old_observers <- isolate(input_settings_rv[["obs"]])
    input_settings_rv[["obs"]] <- c(old_observers, obs1, obs2, obs3)
}
