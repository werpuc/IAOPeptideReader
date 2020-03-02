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


# TODO: check if columns are not NA after reading (missing values in file).
verify_column_types <- function(df) {
    is_ok <- TRUE
    err_msg <- NULL

    column_names <- colnames(df)
    cols_to_check <- c("Start", "End")
    for (cname in cols_to_check) {
        if (cname %in% column_names && !is.numeric(df[[cname]])) {
            is_ok <- FALSE
            err_msg <- c(err_msg, sprintf("'%s' column is not numeric.", cname))
        }
    }

    list("is_ok" = is_ok, "error_messages" = err_msg)
}
