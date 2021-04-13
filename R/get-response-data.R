#' Get Survey Responses
#'
#' Get the user data for the actual survey question items.
#'
#' @param id Input ID
#'
#' @return A dataframe with the user-supplied response
#' @keywords internal
#'
get_survey_responses <- function(id) {
  session <- shiny::getDefaultReactiveDomain()

  if (!is.null(session$input[[id]]) && session$input[[id]] != "") {
    out <- data.frame(session$input[[id]])
  } else {
    out <- data.frame(NA)
  }

  names(out) <- id

  return(out)
}

#' Get Survey MetaData
#'
#' Get the survey metadata (e.g. title, user, submit time).
#'
#' @return A data frame with the survey title, user-id, and submit time.
#' @keywords internal
#'
get_survey_meta <- function() {
  session <- shiny::getDefaultReactiveDomain()
  data.frame(survey_title = session$input$surveyTitle,
             username = session$input$userID,
             submit_time = Sys.time())
}

#' Get Survey Title
#'
#' Send custom message to JS and get the survey title.
#'
#' @return NA; called for side effects. Sets input$surveyTitle to the title or
#'   NA if none is specified.
#' @keywords internal
#'
get_survey_title <- function() {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage("get_title",
                            list())
}

#' Return Survey Data
#'
#' Return a user's responses for a {shinysurvey}.
#'
#' @inheritParams renderSurvey
#'
#' @return A data frame with the values of all survey questions.
#' @export
#'
#' @examples
#' # to come
get_survey_data <- function(df) {

  get_survey_title() # called for side effects

  survey_data <- as.data.frame(
    lapply(unique(df$input_id), get_survey_responses)
  )

  session <- shiny::getDefaultReactiveDomain()
}

get_text <- function() {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage("get_text", list())
}

# append the text from a given ID with the result of "get_text" from JS
append_text <- function(id) {
  get_text()
  session <- shiny::getDefaultReactiveDomain()
  paste(session$input[[id]], session$input$testText)
}
