# test-multi-check-other-specify.R

library(shiny)
library(shinysurveys)

# Register a "check" input type
extendInputType("check", {
  shiny::checkboxGroupInput(
    inputId = surveyID()
    ,label = surveyLabel()
    ,choices = surveyOptions()
  )
})

# Define question in the format of a shinysurvey - with multiple options including 'Other'
ice_cream_question <- data.frame(
  question = "Please indicate your top three favorite ice cream flavors."
  ,option = c("Chocolate", "Vanilla", "Strawberry",
              "Mint Chocolate Chip", "Rocky Road", "Cookie Batter",
              "Hazelnut", "Cookies N' Cream", "Pistachio", "Other")
  ,input_type = "check"
  ,input_id = "favorite_ice_cream"
  ,dependence = NA_character_
  ,dependence_value = NA_character_
  ,required = FALSE
  ,page = "1"
)

# Add a question 'Specify:' to be displayed only when 'Other' is one of the selected options from previous question
ice_cream_question_other <- data.frame(
  question = "Specify:"
  ,option = NA_character_
  ,input_type = "text"
  ,input_id = "favorite_ice_cream_other"
  ,dependence = "favorite_ice_cream"
  ,dependence_value = "Other"
  ,required = FALSE
  ,page = "1"
)


ui <- fluidPage(
  surveyOutput(df = dplyr::bind_rows(ice_cream_question,
                                     ice_cream_question_other),
               survey_title = "Ice Cream Survey - Test Multi-Check + Other, specify",
               survey_description = "Please test that you can select `Other` in addition to some pre-specified flavours,
               and you get to specify the 'Other' flavour",
               theme = "#63B8FF"
  )
)



# Define shiny server
server <- function(input, output, session) {
  renderSurvey()
}

# Run the shiny application
shinyApp(ui, server)
