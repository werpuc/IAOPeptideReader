# single_file_input_meta structure:
#   list(
#       "input_id" = /character/
#       "file_name" = /character/,
#       "is_ok" = /TRUE or FALSE/,
#       "error_messages" = /character vector or NULL/,
#       "sequence_length" = /numeric or NULL/,
#       "protein_state_mapping" = /named (character) list of character vectors or NULL/
#       "selected_protein" = /character or NULL/,
#       "selected_state" = /character or NULL/
#   )
input_summary_row_ui <- function(single_file_input_meta) {
    input_id <- single_file_input_meta[["input_id"]]
    row_class <- "import_summary_row"
    if (!single_file_input_meta[["is_ok"]]) {
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
        tags$td(single_file_input_meta[["file_name"]]),
        tags$td(single_file_input_meta[["sequence_length"]]),
        tags$td(
            selectInput(
                sprintf("%s_protein", input_id), NULL, protein_choices, protein
            )
        ),
        tags$td(
            selectInput(
                sprintf("%s_state", input_id), NULL, state_choices, state
            )
        ),
        tags$td(actionButton(sprintf("%s_delete", input_id), "Delete")) # TODO: consider changin this label.
    )
}


input_summary_row_server <- function(single_file_input_meta, input, session,
                                     input_settings_rv) {
    input_id <- single_file_input_meta[["input_id"]]
    protein_id <- sprintf("%s_protein", input_id)
    state_id <- sprintf("%s_state", input_id)
    delete_id <- sprintf("%s_delete", input_id)
    file_name <- single_file_input_meta[["file_name"]]
    prot_state_mapping <- single_file_input_meta[["protein_state_mapping"]]

    # Updater for the state choices based on protein selection.
    obs1 <- observe({
        selected_protein <- input[[protein_id]]
        req(selected_protein)

        state_choices <- prot_state_mapping[[selected_protein]]
        updateSelectInput(session, state_id, choices = state_choices)
    })

    obs2 <- observeEvent(input[[delete_id]], ignoreInit = TRUE, once = TRUE, {
        input_settings_rv[["fm"]][[file_name]] <- NULL

        for (sfim in input_settings_rv[["fm"]]) {
            sfim_file_name <- sfim[["file_name"]]
            sfim_input_id <- sfim[["input_id"]]
            sfim_protein_id <- sprintf("%s_protein", sfim_input_id)
            sfim_state_id <- sprintf("%s_state", sfim_input_id)

            input_settings_rv[["fm"]][[sfim_file_name]][["selected_protein"]] <- input[[sfim_protein_id]]
            input_settings_rv[["fm"]][[sfim_file_name]][["selected_state"]] <- input[[sfim_state_id]]
        }
    })

    # Saving the observers to destroy them manually on new file upload.
    old_observers <- isolate(input_settings_rv[["obs"]])
    input_settings_rv[["obs"]] <- c(old_observers, obs1, obs2)
}
