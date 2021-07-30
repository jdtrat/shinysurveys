
#' Server code for adding survey questions
#'
#' Include server-side logic for shinysurveys.
#'
#'
#' @param df **Deprecated** *please only place argument in
#'   \code{\link{surveyOutput}}.* A user supplied data frame in the format of
#'   teaching_r_questions.
#' @param theme **Deprecated** *please place the theme argument in
#'   \code{\link{surveyOutput}}.* A valid R color: predefined such as "red" or
#'   "blue"; hex colors such as #63B8FF (default). To customize the survey's
#'   appearance entirely, supply NULL.
#'
#' @export
#'
#' @return NA; used for server-side logic in Shiny apps.
#'
#' @examples
#'

#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinysurveys)
#'
#'   df <- data.frame(question = "What is your favorite food?",
#'                    option = "Your Answer",
#'                    input_type = "text",
#'                    input_id = "favorite_food",
#'                    dependence = NA,
#'                    dependence_value = NA,
#'                    required = F)
#'
#'   ui <- fluidPage(
#'     surveyOutput(df = df,
#'                  survey_title = "Hello, World!",
#'                  theme = "#63B8FF")
#'   )
#'
#'   server <- function(input, output, session) {
#'     renderSurvey()
#'
#'     observeEvent(input$submit, {
#'       showModal(modalDialog(
#'         title = "Congrats, you completed your first shinysurvey!",
#'         "You can customize what actions happen when a user finishes a survey using input$submit."
#'       ))
#'     })
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
#'
renderSurvey <- function(df, theme = "#63B8FF") {

  if (missing(df)) {
    df <- survey_env$question_df
  } else if (!missing(df)) {
    warning("The `df` argument in `renderSurvey()` is deprecated and will be removed in a future version. Please only pass the data frame of questions to `surveyOutput()`.")
  }

  if (missing(theme)) {
    theme <- survey_env$theme
  } else if (!missing(theme)) {
    warning("The `theme` argument in `renderSurvey()` is deprecated and will be removed in a future version. Please only pass the theme color to `surveyOutput()`.")
  }

  session <- shiny::getDefaultReactiveDomain()

  required_vec <- getRequired_internal(survey_env$unique_questions)

  shiny::observe({

    query <- shiny::parseQueryString(session$clientData$url_search)
    if (!base::is.null(query[["user_id"]])) {
      new_value <- base_extract_user_id(query)
      shiny::updateTextInput(session, inputId = "userID", value = new_value)
    }

    # Update the dependencies
    for (id in seq_along(survey_env$unique_questions)) showDependence(input = session$input, df = survey_env$unique_questions[[id]])

    toggle_element(id = "submit",
                   condition = checkRequired_internal(input = session$input,
                                                      required_inputs_vector = required_vec))

  })

  # Clean up non-essential internal environmental variables
  shiny::onStop(function() rm(list = ls(survey_env)[which(!ls(survey_env) %in% c("question_df",
                                                                                 "unique_questions",
                                                                                 "input_type",
                                                                                 "input_extension"))], envir = survey_env))

  shiny::onStop(function() unlink(survey_env$css_file))

}
