library(shiny)
library(taskdesignr)
ui <- fluidPage(
    mainPanel(h3("taskdesignr Advanced Survey Feature"),
              h4("URL-based user tracking"),
              p("The taskdesignr survey code supports URL based user tracking.",
                "For illustrative purposes, we will be printing the user id in the main panel.",
                "By default, the user id is \"NO_USER_ID\". To initiate one, place copy and paste the following text after the backslash in the URL:",
                "The user id can be accessed within a reactive Shiny context with `input$userID`.",
                style = "font-weight: 360, line-height: 1.1;"),
              p("?user_id=123456", style = "font-weight: 500; line-height: 1.1"),
              surveyOutput(teaching_r_questions[1,]),
              hr(),
              textOutput("user_id"))
)

server <- function(input, output, session) {
    renderSurvey(input, teaching_r_questions[1,], session)
    output$user_id <- renderText({
        base::paste0("User ID: ", input$userID)
    })
}

shinyApp(ui, server)
