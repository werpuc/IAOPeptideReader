verify_iao_peptide_data <- function(df) {
    is_ok <- TRUE
    err_msg <- NULL

    column_names <- colnames(df)
    check_map <- list(
        "Protein" = list("Func" = is.character, "Type" = "character"),
        "State" = list("Func" = is.character, "Type" = "character"),
        "Start" = list("Func" = is.numeric, "Type" = "numeric"),
        "End" = list("Func" = is.numeric, "Type" = "numeric")
    )

    for (cname in names(check_map)) {
        if (cname %in% column_names) {
            check_func <- check_map[[cname]][["Func"]]
            expected_col_type <- check_map[[cname]][["Type"]]
            col_values <- df[[cname]]

            if (!check_func(col_values)) {
                is_ok <- FALSE
                err_msg <- c(
                    err_msg,
                    sprintf("'%s' column is not %s.", cname, expected_col_type)
                )
            }

            if (any(is.na(col_values) | col_values == "")) {
                is_ok <- FALSE
                err_msg <- c(
                    err_msg,
                    sprintf("'%s' column contains missing (empty) values.", cname)
                )
            }
        } else {
            is_ok <- FALSE
            err_msg <- c(err_msg, sprintf("'%s' column is missing.", cname))
        }
    }

    list("is_ok" = is_ok, "error_messages" = err_msg)
}
