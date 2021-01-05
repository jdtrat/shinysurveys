#' Get Unique Questions in a Nested Dataframe
#'
#' @param df A user supplied dataframe in the format of teaching_r_questions.
#'
#' @return A nested dataframe.
#'
#' @importFrom rlang .data
#'
nestUniqueQuestions <- function(df) {
  # nest the sample data
  # replace any NA with "placeholder"
  # I've added the question_number but there has to be a better way to do this...
  df %>%
    dplyr::mutate(option = tidyr::replace_na(.data$option, "Placeholder")) %>%
    dplyr::group_by(.data$question, .data$dependence) %>%
    tidyr::nest() %>%
    dplyr::ungroup() %>%
    dplyr::mutate(question_number = dplyr::row_number(), .before = .data$question) %>%
    tidyr::unnest(.data$data) %>%
    dplyr::group_by(.data$question_number) %>%
    tidyr::nest() %>%
    dplyr::ungroup()
}

#' Check if a question is required
#'
#' This function is for internal use. It will check if a question in the
#' user-supplied questions dataframe is required. If so, it will add the label
#' with an asterisk. If not, it will just return the label.
#'
#' @param df The output of \code{\link{nestUniqueQuestions}}.
#'
#' @return A label with or without an asterisk to signify it is required.
#'
#'
addRequiredUI_internal <- function(df) {

  if (df$required[1] == TRUE) {
    label <- shiny::tagList(base::unique(df$question), shiny::span("*", class = "required"))
  } else if (df$required[1] == FALSE) {
    label <- base::unique(df$question)
  }
  return(label)
}

#' Generate the UI Code for demoraphic questions
#'
#' @param df A nested dataframe.
#' @keywords internal
#' @return UI Code for a Shiny App.
#'
surveyOutput_individual <- function(df) {

  inputType <- base::unique(df$input_type)

  if (inputType ==  "select") {
      output <-
      shiny::selectInput(
        inputId = base::unique(df$input_id),
        label = addRequiredUI_internal(df),
        choices = df$option,
      )
  } else if (inputType == "numeric") {

    output <-
      shiny::numericInput(
        inputId = base::unique(df$input_id),
        label = addRequiredUI_internal(df),
        value = df$option
      )

  } else if (inputType == "mc") {

    output <-
      shiny::radioButtons(
        inputId = base::unique(df$input_id),
        label = addRequiredUI_internal(df),
        selected = base::character(0),
        choices = df$option
      )
  } else if (inputType == "text") {

    output <-
      shiny::textInput(inputId = base::unique(df$input_id),
                       label = addRequiredUI_internal(df),
                value = df$option)

  } else if (inputType == "y/n") {

    output <-
      shiny::radioButtons(
        inputId = base::unique(df$input_id),
        label = addRequiredUI_internal(df),
        selected = base::character(0),
        choices = df$option
      )
  }

  if (!base::is.na(df$dependence[1])) {
    # output <- shinyjs::hidden(output)
    output <-
      shinyjs::hidden(
      shiny::div(class = "questions dependence",
                 id = df$input_id[1],
                 shiny::div(class = "question-input",
                 output))
        )
  } else if (base::is.na(df$dependence[1])) {
    output <- shiny::div(class = "questions",
                         shiny::div(class = "question-input",
                         output))
  }

  return(output)

}



#' Check survey metadata
#'
#' Returns title/description HTML tags as needed.
#'
#' @keywords internal
#' @noRd
#'
check_survey_metadata <- function(survey_description, survey_title) {
  if (!missing(survey_description) && missing(survey_title)) {
    stop("Must provide a survey title in order to provide a survey description.")
  } else if (missing(survey_title) && missing(survey_description)) {
    return()
  } else if (!missing(survey_title) && missing(survey_description)) {
    return(
      shiny::div(class = "title-description",
                 shiny::h1(id = "survey-title", survey_title))
    )
  } else if (!missing(survey_title) && !missing(survey_description)) {
    return(
      shiny::div(class = "title-description",
                 shiny::h1(id = "survey-title", survey_title),
                 shiny::p(id = "survey-description", survey_description))
    )
  }
}

#' Generate the UI Code for demoraphic questions
#'
#' Create the UI code for a Shiny app based on user-supplied questions. Possible
#' question (input) types include numeric, text, multiple choice, or selection.
#'
#' @param df A user supplied dataframe in the format of teaching_r_questions.
#' @param survey_title (Optional) user supplied title for the survey
#' @param survey_description (Optional) user supplied description for the survey
#' @param ... Additional arguments to pass into \link[shiny]{actionButton} used to submit survey responses.
#'
#' @return UI Code for a Shiny App.
#' @export
#'
#' @examples
#' \dontrun{
#' surveyOutput(teaching_r_questions,
#' "Teaching R Questions",
#' "Survey used in the Teaching R Study (McGowan et al., 2021)")
#' }
surveyOutput <- function(df, survey_title, survey_description, ...) {

  nested <- nestUniqueQuestions(df)

  shiny::tagList(shinyjs::useShinyjs(),
                 shiny::div(class = "grid",
                            shiny::div(class = "survey",
                                       shiny::uiOutput("sass"),
                                       shinyjs::hidden(shiny::textInput(inputId = "userID",
                                                                        label = "Enter your username.",
                                                                        value = "NO_USER_ID")),
                                       check_survey_metadata(survey_title = survey_title,
                                                             survey_description = survey_description),
                                       purrr::map(nested$data, ~surveyOutput_individual(.x)),
                                       shiny::actionButton("submit",
                                                           "Submit",
                                                           ...))))

}

#' Show dependence questions
#'
#' @param input Input from server
#' @param df The output of \code{\link{nestUniqueQuestions}} (indexed into the data column)..
#'
#' @return NA; shows a dependence question in the UI.
#'
showDependence <- function(input = input, df) {

  if(is.na(df$dependence_value[1]) || is.null(input[[df$dependence[1]]])) {
    return()
  }

 # if there is a dependence
  if (!base::is.na(df$dependence[1])) {
    # check that the input of that question's dependence
    # is equal to its dependence value. If so,
    # show the question.
    if (input[[df$dependence[1]]] == df$dependence_value[1]) {
      shinyjs::show(df$input_id[1])
      shinyjs::removeClass(df$input_id[1], class = "dependence")
      df$required <- TRUE
    } else {
      shinyjs::addClass(df$input_id[1], class = "dependence")
      shinyjs::hide(df$input_id[1])
      df$required <- FALSE
    }
  }
}


#' Get required IDs
#'
#' @keywords internal
#' @noRd
getID <- function(df) {
  if (df$required[1] == TRUE) {
    base::unique(df$input_id)
  } else {
    return(NA)
  }
}

#' Get a character vector of required questions
#'
#' @param df The output of \code{\link{nestUniqueQuestions}} (indexing into the data column).
#'
#' @return A character vectors with the input ID of required questions.
#' @export
#'
getRequired_internal <- function(df) {

  out <- purrr::map_df(df, ~base::list("required_id" = getID(.x)))
  out <- out$required_id

  return(out)

}



#' Check if individual inputs have a value
#'
#' @param input Input from server
#' @param input_id The input_id to check
#'
#' @return TRUE if the input has a value; false otherwise.
#'
checkIndividual <- function(input = input, input_id) {
  if (!is.null(input[[input_id]]) && input[[input_id]] != "") {
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
#' @return TRUE if all required questions have been answered. FALSE otherwise.
#'

checkRequired_internal <- function(input = input, required_inputs_vector) {
  if (all(is.na(required_inputs_vector))) {
    return(TRUE)
  } else {
    required_inputs_vector <- required_inputs_vector[!is.na(required_inputs_vector)]
  }
  all(purrr::map_lgl(.x = required_inputs_vector, ~checkIndividual(input = input, input_id = .x)))
}



#' Server code for adding survey questions
#'
#' Create the UI code for a Shiny app based on user-supplied questions. Possible
#' question (input) types include numeric, text, multiple choice, or selection.
#'
#' @param df A user supplied dataframe in the format of teaching_r_questions.
#' @param input Input from server
#' @param output Output from server
#' @param session Session from server
#' @param theme A valid hex color such as #63B8FF (default)
#'
#' @return NA; server code
#' @export
#'
renderSurvey <- function(input, output, df, session, theme = "#63B8FF") {

  output$sass <- shiny::renderUI({
    shiny::tags$head(
      shiny::tags$style(
        css())
      )
  })

  css <- shiny::reactive({
    sass::sass(list(
      list(color = theme),
      readLines(
        system.file("render_survey.scss",
                    package = "shinysurveys")
        )
    ))
  })

  nested <- nestUniqueQuestions(df)
  required_vec <- getRequired_internal(nested$data)

  shiny::observe({

      query <- shiny::parseQueryString(session$clientData$url_search)
      if (!base::is.null(query[["user_id"]])) {
        new_value <- stringr::str_extract(string = query[["user_id"]],
                                          pattern = "[^*/]+")
        shiny::updateTextInput(session, inputId = "userID", value = new_value)
      }

    purrr::walk(nested$data, ~showDependence(input = input, df = .x))
    shinyjs::toggleState(id = "submit",
                         condition = checkRequired_internal(input = input,
                                                            required_inputs_vector = required_vec))
  })

}

