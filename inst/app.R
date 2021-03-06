library(shiny)

ui <- fluidPage(
  surveyInput("first"),
  verbatimTextOutput("first_title"),
  surveyInput("second"),
  verbatimTextOutput("second_title")
)

server <- function(input, output, session) {
  observe({
    print(input$first)
    # print(input$second)
  })
  output$first_title <- renderText({input$first})
  #output$second_title <- renderText({input$second})
}
shinyApp(ui, server)
