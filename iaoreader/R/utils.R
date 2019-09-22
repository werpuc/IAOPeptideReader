# Files and data handling. -----------------------------------------------------

# Function for loading a data file from a given path.
load_data <- function(data_path) {
    df_raw <- data.table::fread(data_path, header = TRUE) %>% as.data.frame()
    df <- df_raw %>% dplyr::arrange(Protein, State, Start, End) %>%
        dplyr::select(Protein, State, Start, End)

    list(
        "Dataframe" = df,
        "Combinations" = df %>% protein_state_combinations(),
        "MaxSeqLength" = df$End %>% max()
    )
}

# Function returns either a vector of choices to supply for a selectInput
# corresponding to a given file or a NULL in case of a single unique combination
# in the provided data.frame.
protein_state_combinations <- function(df) {
    unique_comb <- df %>% dplyr::select(Protein, State) %>% unique()

    if (unique_comb %>% nrow > 1) {
        1:nrow(unique_comb) %>% sapply(
            function(i) unique_comb[i, ] %>% unlist %>% paste(collapse = " | "))
    }
}

# Wrapper for retrieving an information from a files meta data structure.
files_meta_get <- function(files_meta, param_name) {
    lapply(files_meta, function(meta) meta[[param_name]])
}

# Function returns a data.frame uploaded under a name of file_name.
get_data <- function(input_data, file_name) {
    file_id <- which(input_data$names == file_name)
    input_data$data[[file_id]]
}

# Function prepares a single data.frame for JS plot by filtering out only
# selected protein and state.
prepare_for_plot <- function(df, protein_state) {
    if (!is.null(protein_state)) {
        protein_state <- protein_state %>% strsplit(" | ", fixed = TRUE) %>%
            unlist()

        df <- df %>% dplyr::filter(Protein == protein_state[1],
                                   State == protein_state[2])
    }

    df %>% dplyr::select(Start, End)
}


# Package functions. -----------------------------------------------------------

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


# Server functions. ------------------------------------------------------------
placeholder_before_upload <- function() {
    conditionalPanel("!output.files_uploaded", h5("Please upload files first."))
}

# Convenience function for creating an ambiguity input id.
ambi_input <- function(file_id) {
    paste0("files_settings_ambiguity_", file_id)
}
