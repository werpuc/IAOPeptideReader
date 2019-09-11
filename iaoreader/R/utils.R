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
