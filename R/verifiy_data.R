# TODO: add tests.
verify_iao_data <- function(df) {
    # TODO: perform verification with functions found below.
    # TODO: concatenate the error message.
    list("is_ok" = TRUE, "error_messages" = "")
}


verify_colnames <- function(df) {
    expected_colnames <- c("Protein", "State", "Start", "End")
    missing_cols <- which(!expected_colnames %in% colnames(df))

    is_ok <- length(missing_cols) == 0
    if (is_ok) {
        err_msg <- NULL
    } else {
        err_msg <- sprintf(
            "%s column is missing.",
            expected_colnames[missing_cols]
        )
    }

    list("is_ok" = is_ok, "error_messages" = err_msg)
}


# TODO: add tests.
verify_column_data <- function() {
    # TODO: check column elements types.
}
