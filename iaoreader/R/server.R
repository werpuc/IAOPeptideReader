#' IAOReader server function
#'
#' <ToDo>
#'
#' @import shinipsum
#' @import magrittr
#' @import DT
shiny_server <- function(input, output, session) {

    # Reactive with uploaded files informations.
    files <- reactive({
        if (is.null(input[["files_input"]])) {
            matrix(ncol = 1, nrow = 0) %>% data.frame() %>% setNames("name")
        } else {
            input[["files_input"]]
        }
    })

    # Part responsible for specifying protein - state combination if there are
    # multiple present in single file.
    output[["files_input_settings"]] <- renderUI({
        if (nrow(files()) > 0) {
            fluidPage(
                h3(shinipsum::random_text(nword = 2)),
                numericInput("files_input_settings_sequence", value = 150, # <ToDo: value read from files>
                             min = 1, label = "Specify sequence length"),
                br(),
                h4("Specify protein and state"),
                selectInput("tmp1", label = sample(files()[["name"]], 1),
                            choices = c("Prot1 | State1", "Prot1 | State2", "Prot2 | State"))
            )
        }
    })

    plot_params <- reactive({
        list("plot_settings_title" = input[["plot_settings_title"]],
             "plot_settings_text_color" = input[["plot_settings_text_color"]],
             "tmp_radius" = input[["tmp_radius"]])
    })

    observeEvent(eventExpr = input[["plot_update"]], {
        session$sendCustomMessage("plot_draw", plot_params())
    })

    output[["results_plot"]] <- renderPlot(shinipsum::random_ggplot(type = "bar"))
    output[["tmp_plot"]] <- renderText("Please upload files first.")
    output[["tmp_data"]] <- renderText("Please upload files first.")

    # If files have been uploaded then we display plot and data to browse.
    # Otherwise placeholders are displayed.
    output[["results"]] <- renderUI({
        if (nrow(files()) > 0) {
            results.plot <- plotOutput("results_plot")
            results.data <- fluidPage(
                selectInput("results_data", label = "Select file", choices = files()[["name"]]),
                DT::datatable(shinipsum::random_table(15, 6, type = "numeric")))

            # JS communication example
            click("plot_update")
        } else {
            results.plot <- textOutput("tmp_plot")
            results.data <- textOutput("tmp_data")
        }

        tabsetPanel(
            tabPanel("Peptide Coverage", br(), results.plot),
            tabPanel("Data preview", br(), results.data)
        )
    })
}
