# Files handling ---------------------------------------------------------------

#' <ToDo> name
#'
#' <ToDo>
#'
#' @import data.table
load_data <- function(data_path) {
    df_raw <- data.table::fread(data_path, header = TRUE)
    df <- df_raw[, c("Protein", "State", "Start", "End")] %>% as.data.frame() # <ToDo: colNames>

    res <- list(
        "Dataframe" = df,
        "Combinations" = df %>% protein_state_combinations(),
        "MaxSeqLength" = df$End %>% max() # <ToDo: colNames>
    )

    return(res)
}

# Function returns either a vector of values to supply in selectInput for given
# file or a NULL in case of a single combination in a provided data.frame.
protein_state_combinations <- function(df) {
    unique_comb <- df[, c("Protein", "State")] %>% unique() # <ToDo: colNames>

    if (unique_comb %>% nrow > 1) {
        1:nrow(unique_comb) %>% sapply(
            function(i) unique_comb[i, ] %>% unlist %>% paste(collapse = " | "))
    }
}

# Wrapper for retrieving an information from a files meta data structure.
files_meta_get <- function(files_meta, param_name) {
    lapply(files_meta, function(meta) meta[[param_name]])
}


# Package functions ------------------------------------------------------------

# Function returns an absolute path to an internal file contained in one of the
# `inst` folder's subdirectories.
get_file_path <- function(file_name, inst_path = "www") {
    dir_path <- system.file(inst_path, package = "iaoreader")

    if (dir_path == "") {
        stop(paste("It looks like an internal package file is missing.",
                   "Consider reinstalling the package."))
    }

    return(file.path(dir_path, file_name))
}


# Server functions -------------------------------------------------------------
cond_reactive <- function(cond, expr) {
    reactive(
        if (cond) {
            expr
        }
    )
}
