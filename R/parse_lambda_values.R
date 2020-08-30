# Function for parsing lambda values received from JS in JSON format.
# The output is a data.frame with row for each file displayed.
parse_lambda_values <- function(json_data, null_value = "-") {
    stopifnot(!is.null(null_value))

    file_names <- names(json_data[[1]])
    mtx <- matrix(nrow = length(file_names), ncol = length(json_data))
    for (i in seq_along(json_data)) {
        mtx[, i] <- single_lambda_value_to_vec(json_data[[i]], null_value)
    }

    df <- as.data.frame(mtx)
    rownames(df) <- file_names
    colnames(df) <- seq_along(json_data)

    df
}


single_lambda_value_to_vec <- function(x_value_list, null_value) {
    values <- lapply(
        x_value_list,
        function(x_val) {
            if (is.null(x_val)) return(null_value)
            paste0(round(x_val * 100), "%")
        }
    )

    unlist(unname(values))
}
