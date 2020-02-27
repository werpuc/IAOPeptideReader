# Sidebar panel UI -------------------------------------------------------------
sidebar_panel_ui <- function() {
    sidebarPanel(
        tags$div(
            id = "sidebar_panel",
            tabsetPanel(
                input_settings_ui(),
                plot_settings_ui()
            )
        )
    )
}


# Input Settings tab UI --------------------------------------------------------
input_settings_ui <- function() {
    tabPanel(
        "Input Settings",
        fileInput("file_upload", "Upload input files", multiple = TRUE),

        h3("Sequence Length"),
        splitLayout(
            cellWidths = c("30%", "70%"),

            # TODO: update the initial value with a maximum value read from input files.
            numericInput("sequence_length", NULL, 123, width = "100%"),

            # TODO: change to textOutput and update with a maximum value read from input files.
            tags$p("Maximum sequence length read from files: 123",
                   style = "margin-left: 20px;") # textOutput("sequence_length_default")
        ),

        h3("Input Files Summary"),
        tags$table(
            tags$thead(
                tags$tr(
                    lapply(
                        c("File Name", "Sequence Length", "Protein", "State", ""),
                        tags$td,
                        style = "width: 20%;"
                    )
                )
            ),
            # TODO: generate the tables body in the server function based on the uploaded files.
            # TODO: add CSS to this table.
            # TODO: gray out (mark) the rows which have file with incorrect structure.
            tags$tbody(
                tags$tr(
                    tags$td("file1.csv"),
                    tags$td(123),
                    tags$td(selectInput("file1_protein", NULL, c("Prot A", "Prot B"))),
                    tags$td(selectInput("file1_state", NULL, c("State X", "State Y"))),
                    tags$td(actionButton("file1_delete", "Delete file", class = "btn-danger"))
                )
            )
        )
    )
}


# Plot Settings tab UI ---------------------------------------------------------
plot_settings_ui <- function() {
    tabPanel(
        "Plot Settings",
        uiOutput("plot_settings_inputs"),
        tags$div(
            align = "center", style = "margin-top: 35px;",
            actionButton("plot_settings_reset", "Reset Plot Settings",
                         class = "btn-danger")
        )
    )
}
