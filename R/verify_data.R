verify_iao_data <- function(df) {
    check1 <- verify_colnames(df)
    check2 <- verify_column_types(df)

    list(
        "is_ok" = check1[["is_ok"]] && check2[["is_ok"]],
        "error_messages" = c(
            check1[["error_messages"]],
            check2[["error_messages"]]
        )
    )
}


verify_colnames <- function(df) {
    expected_colnames <- c("Protein", "State", "Start", "End")
    missing_cols <- which(!expected_colnames %in% colnames(df))

    is_ok <- length(missing_cols) == 0
    if (is_ok) {
        err_msg <- NULL
    } else {
        err_msg <- sprintf(
            "'%s' column is missing.",
            expected_colnames[missing_cols]
        )
    }

    list("is_ok" = is_ok, "error_messages" = err_msg)
}


verify_column_types <- function(df) {
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
        }
    }

    list("is_ok" = is_ok, "error_messages" = err_msg)
}
