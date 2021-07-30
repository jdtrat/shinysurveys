#' Remove CSS Class
#'
#' Custom function for removing a CSS class used in {shinysurveys}.
#'
#' @param .id Shiny object inputId
#' @param .class class to be removed
#' @keywords internal
#'
#' @return NA; used for side effects
#'
remove_class <- function(.id, .class) {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    "remove_class",
    list(input_id = .id,
         class_name = .class)
  )
}

#' Add CSS Class
#'
#' Custom function for adding a CSS class used in {shinysurveys}.
#'
#' @param .id Shiny object inputId
#' @param .class class to be added
#' @keywords internal
#'
#' @return NA; used for side effects
#'
add_class <- function(.id, .class) {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    "add_class",
    list(input_id = .id,
         class_name = .class)
  )
}

#' Disable HTML element
#'
#' Custom function for disabling an HTML element in {shinysurveys}.
#'
#' @param .id Shiny object inputId
#' @keywords internal
#'
#' @return NA; used for side effects
#'
disable_element <- function(.id) {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    "disable",
    list(input_id = .id)
  )
}

#' Enable HTML element
#'
#' Custom function for disabling an HTML element in {shinysurveys}.
#'
#' @param .id Shiny object inputId
#' @keywords internal
#'
#' @return NA; used for side effects
#'
enable_element <- function(.id) {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    "enable",
    list(input_id = .id)
  )
}

#' Hide shinysurvey
#'
#' This function allows you to easily hide the survey, something you may wish to
#' do upon submission.
#'
#' @return NA; used to hide the survey.
#'
#' @examples
#'
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinysurveys)
#'
#'   ui <- fluidPage(
#'     surveyOutput(teaching_r_questions,
#'                  survey_title = "Now you see me...",
#'                  survey_description = "A demo showing how to hide the survey body upon submission.")
#'   )
#'
#'   server <- function(input, output, session) {
#'     renderSurvey()
#'     observeEvent(input$submit, hideSurvey())
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
#'
hideSurvey <- function() {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage('hideSurvey', list())
}
