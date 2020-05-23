#' @importFrom data.table setattr is.data.table
add_class <- function(object, class_name, as_first = TRUE) {
    old_class <- class(object)

    new_class <- c(class_name, old_class)
    if (!as_first) {
        new_class <- c(old_class, class_name)
    }

    if (is.data.table(object)) {
        setattr(object, "class", new_class)
        return(object)
    }

    class(object) <- new_class
    object
}
