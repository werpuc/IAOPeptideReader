source(file.path("ui", "main_panel_ui.R"), local = TRUE, chdir = TRUE)
source(file.path("ui", "sidebar_panel_ui.R"), local = TRUE, chdir = TRUE)

# TODO: remove when mocks won't be needed.
if (!nchar(system.file(package = "shinipsum"))) {
    stop(paste("shinipsum package is required for mocks.",
               "remotes::install_github('Thinkr-open/shinipsum')", sep = "\n"))
}


# Main UI function -------------------------------------------------------------
ui <- function() {
    fluidPage(
        attach_css("iaoreader_theme.css"),
        attach_css("HaDeX_theme.css"),
        attach_script("plot_settings.js"),
        sidebar_panel_ui(),
        main_panel_ui()
    )
}


# Global UI utilities ----------------------------------------------------------
attach_css <- function(css_name, url_static_path = "www") {
    tags$head(
        tags$link(
            href = sprintf("%s/%s", url_static_path, css_name),
            rel = "stylesheet"
        )
    )
}

attach_script <- function(script_name, url_static_path = "www") {
    tags$head(
        tags$script(src = sprintf("%s/%s", url_static_path, script_name))
    )
}

no_file_uploaded_wrapper <- function(...) {
    tagList(
        conditionalPanel(
            "!output.files_uploaded",
            tags$p(class = "no_file_uploaded", "Please upload files first.")
        ),
        conditionalPanel(
            "output.files_uploaded",
            ...
        )
    )
}

no_file_good_wrapper <- function(...) {
    tagList(
        conditionalPanel(
            "!output.any_file_good",
            tags$p(
                class = "no_good_file bad_files_info",
                "None of the uploaded files passed the verification."
            )
        ),
        conditionalPanel(
            "output.any_file_good",
            ...
        )
    )
}
