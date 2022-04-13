
#' Check if a question is required
#'
#' This function is for internal use. It will check if a question in the
#' user-supplied questions dataframe is required. If so, it will add the label
#' with an asterisk. If not, it will just return the label.
#'
#' @param df One element (a dataframe) in the list of unique questions.
#'
#'
#' @keywords internal
#' @return A label with or without an asterisk to signify it is required.
#'
#'
addRequiredUI_internal <- function(df) {

  if (length(base::unique(df$question)) != 1 & base::unique(df$input_type) != "matrix") {
    stop(paste0("The question with input ID '", df$input_id, "' has more than one question in the `question` column. Perhaps there is a spelling error?"))
  }

  if (df$required[1] == TRUE) {
    label <- shiny::tagList(base::unique(df$question), shiny::span("*", class = "required"))
  } else if (df$required[1] == FALSE) {
    label <- base::unique(df$question)
  }
  return(label)
}

#' Toggle element state
#'
#' Custom function for toggling enable/disable state of HTML element in {shinysurveys}.
#'
#' @param id Shiny object inputId
#' @param condition Condition on which to enable or disable
#' @keywords internal
#'
#' @return NA; used for side effects
#'
toggle_element <- function(id, condition) {

  if (!condition) {
    disable_element(.id = id)
  } else if (condition) {
    enable_element(.id = id)
  }

}

#' Show dependence questions
#'
#' @param input Input from server
#' @param df One element (a dataframe) in the list of unique questions.
#'
#'
#' @keywords internal
#' @return NA; shows a dependence question in the UI.
#'
showDependence <- function(input = input, df) {

  # Are there any dependencies?
  if (any(!is.na(df$dependence_value))) {

    # Using the first dependence value for a question
    # assumes all dependence values per question are equal
    if (any(input[[df$dependence[1]]] == df$dependence_value[1])) {
        remove_class(
          .id = paste0(df$input_id[1], "-question"),
          .class = "dependence"
          )
      df$required <- TRUE
    } else {
      add_class(
        .id = paste0(df$input_id[1], "-question"),
        .class = "dependence"
        )
      df$required <- FALSE
    }
  }

}


#' Get required IDs
#'
#' @param df The dataframe of questions
#'
#' @keywords internal
#'
#' @return The input ID for required questions
#'
getID <- function(df) {
  if (df$required[1] == TRUE) {
    base::unique(df$input_id)
  } else {
    return(NA)
  }
}


#' Get a character vector of required questions
#'
#' @param questions The list of unique questions from \code{\link{listUniqueQuestions}}.
#'
#'
#' @keywords internal
#' @return A character vectors with the input ID of required questions.
#'
getRequired_internal <- function(questions) {

  out <- as.data.frame(
    do.call(
      rbind,
      lapply(questions, getID)
    ),
    stringsAsFactors = FALSE
  )

  names(out) <- "required_id"

  out <- out$required_id

  return(out)

}

#' Check if individual inputs have a value
#'
#' @param input Input from server
#' @param input_id The input_id to check
#'
#'
#' @keywords internal
#' @return TRUE if the input has a value; false otherwise.
#'
checkIndividual <- function(input = input, input_id) {
  if (!is.null(input[[input_id]]) && as.character(input[[input_id]]) != "" && !is.na(input[[input_id]])) {
    TRUE
  } else {
    FALSE
  }
}

#' Check all required questions have been answered
#'
#' @param input Input from server
#' @param required_inputs_vector The output of \code{\link{getRequired_internal}}.
#'
#'
#' @keywords internal
#'
#' @return TRUE if all required questions have been answered. FALSE otherwise.
#'

checkRequired_internal <- function(input = input, required_inputs_vector) {
  if (all(is.na(required_inputs_vector))) {
    return(TRUE)
  } else {
    required_inputs_vector <- required_inputs_vector[!is.na(required_inputs_vector)]
  }

  instructions_id <- do.call(c, lapply(survey_env$unique_questions, function(question) {
    if (all(question$input_type == "instructions")) unique(question$input_id)
  }))

  required_inputs_vector <- required_inputs_vector[which(!required_inputs_vector %in% c(input$shinysurveysHiddenInputs, instructions_id))]

  all(vapply(required_inputs_vector, checkIndividual, input = input, FUN.VALUE = logical(1), USE.NAMES = FALSE))
}

