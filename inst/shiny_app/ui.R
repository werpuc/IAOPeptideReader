source(file.path("ui", "main_panel_ui.R"), local = TRUE, chdir = TRUE)
source(file.path("ui", "sidebar_panel_ui.R"), local = TRUE, chdir = TRUE)

# TODO: remove when mocks won't be needed.
if (!nchar(system.file(package = "shinipsum"))) {
    stop(paste("shinipsum package is required for mocks.",
               "remotes::install_github('Thinkr-open/shinipsum')", sep = "\n"))
}


# Main UI function -------------------------------------------------------------
ui <- function() {
    # TODO: is it okay to have so many small files to organize the code or will
    #       it negatively affect the page loading times?
    css_names <- c("iaoreader_theme.css", "HaDeX_theme.css")
    script_names <- c("d3.min.js", "plot.js", "iaoreader.js")
    handler_script_names <- c("plot_settings_title.js", "seq_len_check.js",
                              "update_svg.js")

    fluidPage(
        lapply(css_names, attach_css),
        lapply(script_names, attach_script),
        lapply(handler_script_names, attach_script, "www/js/shiny_handlers"),
        sidebar_panel_ui(),
        main_panel_ui()
    )
}


# Global UI utilities ----------------------------------------------------------
attach_css <- function(css_name, url_static_path = "www/css") {
    tags$head(
        tags$link(
            href = sprintf("%s/%s", url_static_path, css_name),
            rel = "stylesheet"
        )
    )
}

attach_script <- function(script_name, url_static_path = "www/js") {
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
