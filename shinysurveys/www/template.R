library(shiny)
library(shinysurveys)
library(shinyjs)
library(shinyalert)
library(rdrop2)
library(glue)

#establish SASS file
sass::sass(
  sass::sass_file("www/survey.scss"),
  output = "www/survey.css"
)


survey_questions <- read.csv("www/survey_questions.csv")

ui <- shiny::fillPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "survey.css")
  ),
  shinyjs::useShinyjs(),
div(class = "survey",
    h1({{{survey_title}}}),
    shinysurveys::surveyOutput(df = survey_questions,
                              icon = icon("check"))))


server <- function(input, output, session) {

  shinysurveys::renderSurvey(input = input,
                            df = survey_questions,
                            session = session)

  # Perform some action upon user submitting
  observeEvent(input$submit, {
    # Create an action to save survey responses
  })

}

shiny::shinyApp(ui = ui, server = server)
