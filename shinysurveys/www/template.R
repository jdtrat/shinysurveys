library(shiny)
library(shinysurveys)

# Load survey questions
survey_questions <- read.csv("www/survey_questions.csv")

ui <- shiny::fluidPage(
    shinysurveys::surveyOutput(df = survey_questions,
                               survey_title = {{{survey_title}}},
                               survey_description = {{{survey_description}}},
                               icon = icon("check"))
    )


server <- function(input, output, session) {

  shinysurveys::renderSurvey(input = input,
                             output = output,
                             df = survey_questions,
                             session = session,
                             theme = {{{theme_color}}})

  # Perform some action upon user submitting
  shiny::observeEvent(input$submit, {
    # Create an action to save survey responses
  })

}

# Run app
shiny::shinyApp(ui = ui, server = server)
