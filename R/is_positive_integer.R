is_positive_integer <- function(x) {
    if (is.null(x) || is.na(x) || !is.numeric(x)) {
        return(FALSE)
    }

    (x %% 1 == 0) && (x > 0)
}
