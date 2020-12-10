source(file.path("ui", "main_panel_ui.R"), local = TRUE, chdir = TRUE)
source(file.path("ui", "sidebar_panel_ui.R"), local = TRUE, chdir = TRUE)


# Main UI function -------------------------------------------------------------
ui <- function() {
    css_names <- c(
        "iaopeptidereader_theme.css",
        "HaDeX_theme.css"
    )

    scripts_names <- c(
        "shiny_handlers.js",
        "iaopeptidereader.js",
        "lambda_measures.js",
        "download_svg.js"
    )

    tagList(
        # Note: title panel has to be defined before the fluidPage in order to
        #       not get caught within the padding the div.container-fluid has.
        titlePanel(
            tagList(
                div(
                    id = "title",
                    title = paste("Version:", packageVersion("IAOPeptideReader")),
                    "IAO Peptide Reader"
                ),
                tags$a(
                    id = "github_url",
                    href = "https://github.com/hadexversum/IAOPeptideReader",
                    title = "Preview source code on GitHub",
                    icon("github")
                )
            ),
            "IAO Peptide Reader"
        ),
        fluidPage(
            lapply(css_names, attach_css),
            lapply(scripts_names, attach_script),
            attach_script("d3.min.js", "www/d3.js"),
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

# This function is a wrapper for making clean external inline links.
# Specifically it allows having the link as a last part of a sentence without
# leaving awkward white space between the link and the dot.
external_link <- function(text, href, trailing_dot = FALSE) {
    a_tag <- sprintf(
        '<a href="%s" target="_blank" rel="noopener noreferrer">%s %s</a>',
        href, text, as.character(icon("external-link"))
    )

    if (trailing_dot) {
        a_tag <- paste0(a_tag, ".")
    }

    HTML(a_tag)
}

modal_link <- function(observer_id, text, trailing_dot = FALSE) {
    onclick <- sprintf("Shiny.setInputValue('%s', Date.now());", observer_id)
    a_tag <- sprintf(
        '<a class="modal_link" onclick="%s">%s</a>', onclick, text
    )

    if (trailing_dot) {
        a_tag <- paste0(a_tag, ".")
    }

    HTML(a_tag)
}

modal_label_link <- function(observer_id, label) {
    tags$label(
        label,
        actionButton(observer_id, icon("info-circle"), class = "label_icon")
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
