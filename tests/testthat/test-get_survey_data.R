# Setup test questions ----------------------------------------------------


food_question <- data.frame(question = "What is your favorite food?",
                            option = "Your Answer",
                            input_type = "text",
                            input_id = "favorite_food",
                            dependence = NA,
                            dependence_value = NA,
                            required = F)

matrix_questions <- data.frame(
  question = c(rep("I love sushi.", 3), rep("I love chocolate.",3),
               "What's your favorite food?", rep("Goat cheese is the GOAT.", 5),
               rep("Yogurt and berries are a great snack.",5),
               rep("SunButter® is a fantastic alternative to peanut butter.", 5)),
  option = c(rep(c("Disagree", "Neutral", "Agree"), 2), "text",
             rep(c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"), 3)),
  input_type = c(rep("matrix", 6), "text", rep("matrix", 15)),
  input_id = c(rep("matId", 6), "favorite_food", rep("matId2", 15)),
  dependence = NA,
  dependence_value = NA,
  required = FALSE
)




library(shiny)
#remotes::install_github("jdtrat/shinysurveys@extend-shinysurveys")
library(shinysurveys)


# Register a date input to {shinysurveys},
# limiting possible dates to a twenty-day period.

extendInputType("date", {
  shiny::dateInput(
    inputId = surveyID(),
    value = Sys.Date(),
    label = surveyLabel(),
    min = Sys.Date()-10,
    max = Sys.Date()+10
  )
})

# Define a question as normal with the `input_type` set to
# the custom date type defined above.

date_question <- data.frame(question = "When do you graduate?",
                            option = NA,
                            input_type = "date",
                            input_id = "grad_date",
                            dependence = NA,
                            dependence_value = NA,
                            required = FALSE)


ui <- fluidPage(
  surveyOutput(df = date_question, "Date Input Extension Example")
)

server <- function(input, output, session) {
  renderSurvey()
}

shinyApp(ui, server)







df <- data.frame(
  question = c("What's your favorite food?", rep("Do you like SunButter®", 2),
               "Where do you live?", "What is the temperature where you are?"),
  option = c("Sushi", "Yes", "No", "North Carolina", "79"),
  input_type = c("text", rep("y/n", 2), "text", "numeric"),
  input_id = c("favorite_food", rep("sunbutter", 2), "location", "temperature"),
  dependence = c(NA, "favorite_food", "favorite_food", NA, NA),
  dependence_value = c(NA, "Sushi", "Sushi", NA, NA),
  required = FALSE
)

ui <- fluidPage(
  surveyOutput(df,
               survey_title = "{shinysurveys} Automatic Response Aggregation Example",
               survey_description = "The function `getSurveyData()` takes into account dependencies,
               and will only include questions that participants saw when aggregating responses."
               )
)

server <- function(input, output, session) {
  renderSurvey()

  observeEvent(input$submit, {
    print(getSurveyData())
  })
}

shinyApp(ui, server)
