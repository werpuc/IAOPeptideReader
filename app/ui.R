library("shiny")
library("magrittr")


sidebar <- function() {
    sidebarPanel(
        class = "scrollable",
        tabsetPanel(
            sidebar.input(),
            sidebar.plot.settings()
        )
    )
}


# Sidebar tabPanel used to upload files and precise which part of data should be used.
sidebar.input <- function() {
    tabPanel(
        "Input settings", br(),
        selectInput("input.mode", label = "Select mode", multiple = FALSE,
                    choices = c("Two files (different experiments)", "Multiple files (one experiment)")),
        fileInput("files.input", "Upload files", multiple = TRUE),
        uiOutput("files.input.settings")
    )
}


# Sidebar tabPanel containing all plot customization settings.
sidebar.plot.settings <- function() {
    tabPanel(
        "Plot settings", br(),
        textInput("plot.settings.title", label = "Title"),
        textInput("plot.settings.text.color", label = "Text color")
    )
}


ui <- fluidPage(
    theme = "HaDeX_theme.css",
    sidebar(),
    mainPanel(
        class = "scrollable",
        uiOutput("results")
    )
)