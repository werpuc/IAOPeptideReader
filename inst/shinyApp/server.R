server <- function(input, output, session) {
    output[["text"]] <- renderText("Hello world!")
}
