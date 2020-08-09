source(file.path("ui", "main_panel_ui.R"), local = TRUE, chdir = TRUE)
source(file.path("ui", "sidebar_panel_ui.R"), local = TRUE, chdir = TRUE)


# Main UI function -------------------------------------------------------------
ui <- function() {
    # TODO: is it okay to have so many small files to organize the code or will
    #       it negatively affect the page loading times?
    css_names <- c(
        "iaoreader_theme.css",
        "HaDeX_theme.css"
    )

    scripts_names <- c(
        "d3.min.js",
        "shiny_handlers.js",
        "color_brewer.js"
    )

    class_scripts_names <- c(
        "iaoreader.js",
        "plot_settings.js"
    )

    tagList(
        # Note: title panel has to be defined before the fluidPage in order to
        #       not get caught within the padding the div.container-fluid has.
        titlePanel(
            tagList(
                div(
                    id = "title",
                    title = paste("Version:", packageVersion("iaoreader")),
                    "IAO Reader",
                    # TODO: remove after development.
                    tags$i("development version", style = "font-size: 14px;")
                ),
                tags$a(
                    id = "github_url",
                    href = "https://github.com/tmakowski/iaoreader",
                    icon("github")
                )
            ),
            "IAO Reader"
        ),
        fluidPage(
            lapply(css_names, attach_css),
            lapply(scripts_names, attach_script),
            lapply(class_scripts_names, attach_script, "www/js/classes"),
            sidebar_panel_ui(),
            main_panel_ui()
        )
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
