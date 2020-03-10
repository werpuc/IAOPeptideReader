# Input settings server function -----------------------------------------------
input_settings <- function(input, output, session) {

    # Outputs for the conditionalPanel -----------------------------------------
    output[["files_uploaded"]] <- reactive({
        req(input[["files_upload"]])
        TRUE
    })
    outputOptions(output, "files_uploaded", suspendWhenHidden = FALSE)

    any_file_good <- reactive(any(is_okay_values()))
    output[["any_file_good"]] <- any_file_good
    outputOptions(output, "any_file_good", suspendWhenHidden = FALSE)

    output[["any_file_bad"]] <- reactive(!all(is_okay_values()))
    outputOptions(output, "any_file_bad", suspendWhenHidden = FALSE)


    # Uploaded files meta information ------------------------------------------
    input_settings_rv <- reactiveValues("fm" = NULL, "obs" = list(),
                                        "data" = list())
    files_meta <- reactive({
        fm <- input_settings_rv[["fm"]]
        req(fm)
        fm[order(names(fm))]
    })
    
    observe({
        file_input_meta <- input[["files_upload"]]
        req(file_input_meta)

        res <- list()
        for (i in 1:nrow(file_input_meta)) {
            single_file_input_meta <- file_input_meta[i, , drop = FALSE]
            file_name <- single_file_input_meta[["name"]]
            file_path <- single_file_input_meta[["datapath"]]

            single_res <- list(
                "input_id" = sprintf("IS_row%d", i),
                "file_name" = file_name,
                "is_ok" = NULL,
                "error_messages" = NULL,
                "sequence_length" = NULL,
                "protein_state_mapping" = NULL,
                "selected_protein" = NULL,
                "selected_state" = NULL
            )

            # TODO: save the data somewhere (concatenate data before saving).
            single_file_data <- fread(file_path) # TODO: tryCatch this.
            single_res[c("is_ok", "error_messages")] <- verify_iao_data(single_file_data)
            if (single_res[["is_ok"]]) {
                single_res[["sequence_length"]] <- max(single_file_data[["End"]])
                single_res[["protein_state_mapping"]] <- read_protein_state_mapping(single_file_data)
            }

            res[[file_name]] <- single_res
        }

        input_settings_rv[["fm"]] <- res
    })

    is_okay_values <- reactive({
        sapply(files_meta(), function(sfim) sfim[["is_ok"]])
    })


    # Max sequence length ------------------------------------------------------
    # This reactive is updated when any_file_good updates thus making this
    # reactive indirectly dependent on files_meta.
    # Note: if the isolate would be by the any_file_good and files_meta didn't
    #       have it this reactive won't work correctly.
    sequence_max_length <- reactive({
        req(any_file_good())

        # Note: sapply does not work (unlist) correctly when one of the results
        #       is NULL. Hence the lapply & unlist combination is used.
        max(
            unlist(
                lapply(
                    isolate(files_meta()),
                    function(sfim) sfim[["sequence_length"]]
                )
            )
        )
    })

    observeEvent(input[["files_upload"]], {
        updateNumericInput(
            session, "sequence_length", value = sequence_max_length())
    })

    output[["sequence_length_max"]] <- renderText({
        sprintf(
            "Maximum sequence length read from files: %d.",
            sequence_max_length()
        )
    })


    # Import summary table UI --------------------------------------------------
    output[["input_summary_table"]] <- renderUI({
        tags$table(
            tags$thead(
                tags$tr(
                    lapply(
                        c("File Name", "Sequence Length", "Protein", "State", ""),
                        tags$td,
                        style = "width: 20%;"
                    )
                )
            ),
            tags$tbody(
                lapply(
                    files_meta(),
                    function(sfim) {
                        input_summary_row_ui(
                            sfim,
                            sfim[["selected_protein"]],
                            sfim[["selected_state"]]
                        )
                    }
                )
            )
        )
    })

    # The server is created separately because we don't want to re-create
    # observes with every deletion. Additionally, it destroys every already
    # existing observer to prevent stacking them infinitely.
    observeEvent(input[["files_upload"]], {
        lapply(input_settings_rv[["obs"]], function(obs) obs$destroy())

        lapply(
            files_meta(),
            function(sfim) {
                input_summary_row_server(sfim, input, session, input_settings_rv)
            }
        )
    })
}
