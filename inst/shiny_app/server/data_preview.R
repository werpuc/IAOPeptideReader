# Data Preview server function -------------------------------------------------
data_preview <- function(input, output, session, input_settings_rv, any_file_good) {
    observe({
        req(any_file_good())

        name_ok_mapping <- sapply(input_settings_rv[["fm"]], `[[`, "is_ok")
        file_names <- names(name_ok_mapping[which(name_ok_mapping)])

        updateSelectInput(
            session, "previewed_file", choices = file_names,
            selected = file_names[1]
        )
    })

    # TODO: customize the table.
    output[["data_preview"]] <- DT::renderDataTable({
        selected_file <- input[["previewed_file"]]
        isolate(input_settings_rv[["data"]][[selected_file]])
    })
}
