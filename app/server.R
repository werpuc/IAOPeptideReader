server <- function(input, output) {
    
    # Reactive with uploaded files informations.
    files <- reactive({
        if (is.null(input[["files.input"]])) {
            matrix(ncol = 1, nrow = 0) %>% data.frame() %>% setNames("name")
        } else {
            input[["files.input"]]   
        }
    })
    
    # Part responsible for specifying protein - state combination if there are
    # multiple present in single file.
    output[["files.input.settings"]] <- renderUI({
        if (nrow(files()) > 0) {
            fluidPage(
                h3(shinipsum::random_text(nword = 2)),
                numericInput("files.input.settings.sequence", value = 150, # <ToDo: value read from files>
                             min = 1, label = "Specify sequence length"), 
                br(),
                h4("Specify protein and state"),
                selectInput("tmp1", label = sample(files()[["name"]], 1),
                            choices = c("Prot1 | State1", "Prot1 | State2", "Prot2 | State"))
            )
        }
    })
    
    output[["results.plot"]] <- renderPlot(shinipsum::random_ggplot(type = "bar"))
    output[["tmp.plot"]] <- renderText("Please upload files first.")
    output[["tmp.data"]] <- renderText("Please upload files first.")
    
    # If files have been uploaded then we display plot and data to browse.
    # Otherwise placeholders are displayed.
    output[["results"]] <- renderUI({
        if (nrow(files()) > 0) {
            results.plot <- plotOutput("results.plot")
            results.data <- fluidPage(
                selectInput("data.files", label = "Select file", choices = files()[["name"]]),
                DT::datatable(shinipsum::random_table(15, 6, type = "numeric")))
        } else {
            results.plot <- textOutput("tmp.plot")
            results.data <- textOutput("tmp.data")
        }
        
        tabsetPanel(
            tabPanel("Peptide Coverage", br(), results.plot),
            tabPanel("Data preview", br(), results.data)
        )
    })
}