#' Generate the UI Code for demographic questions
#'
#' @param df One element (a dataframe) in the list of unique questions.
#'
#' @keywords internal
#' @return UI Code for a Shiny App.
#'
surveyOutput_individual <- function(df) {

  inputType <- base::unique(df$input_type)

  if (length(inputType) != 1) {
    if (!"instructions" %in% inputType) {
      stop("Please double check your data frame and ensure that the input type for all questions is supported.")
    } else if ("instructions" %in% inputType) {
      instructions <- df[which(df$input_type == "instructions"), "question", drop = FALSE]$question
      instructions <- shiny::tagList(
        shiny::div(class = "question-instructions",
                   instructions)
      )

      inputType <- inputType[which(inputType != "instructions")]
      df <- df[which(df$input_type != "instructions"),]
    }
  } else if (length(inputType == 1)) {
    instructions <- NULL
  }

  if (grepl("rank_{{", inputType, perl = T)) {
    stop('Ranking input types have been superseded by the "matrix" input type.')
  }

  survey_env$current_question <- df

  if (inputType ==  "select") {
    output <-
      shiny::selectizeInput(
        inputId = base::unique(df$input_id),
        label = addRequiredUI_internal(df),
        choices = df$option,
        options = list(
          placeholder = '',
          onInitialize = I('function() { this.setValue(""); }')
        )
      )
  } else if (inputType == "numeric") {

    output <-
      numberInput(
        inputId = base::unique(df$input_id),
        label = addRequiredUI_internal(df),
        placeholder = df$option
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
                       placeholder = df$option)

  } else if (inputType == "y/n") {

    output <-
      shiny::radioButtons(
        inputId = base::unique(df$input_id),
        label = addRequiredUI_internal(df),
        selected = base::character(0),
        choices = df$option
      )

  } else if (inputType == "matrix") {

    required_matrix <- ifelse(all(df$required), TRUE, FALSE)

    output <-
      radioMatrixInput(
        inputId = base::unique(df$input_id),
        responseItems = base::unique(df$question),
        choices = base::unique(df$option),
        selected = NULL,
        .required = required_matrix
      )

  } else if (inputType == "instructions") {

    output <- shiny::div(
      class = "instructions-only",
      shiny::markdown(df$question)
    )

  } else if (inputType %in% survey_env$input_type) {
    output <- eval(survey_env$input_extension[[inputType]])
  } else {
    stop(paste0("Input type '", inputType, "' from the supplied data frame of questions is not recognized by {shinysurveys}.
                Did you mean to register a custom input extension with `extendInputType()`?"))
  }

  if (!base::is.na(df$dependence[1])) {
    output <- shiny::div(class = "questions dependence",
                         id = paste0(df$input_id[1], "-question"),
                         shiny::div(class = "question-input",
                                    instructions,
                                    output))
  } else if (base::is.na(df$dependence[1])) {
    output <- shiny::div(class = "questions",
                         id = paste0(df$input_id[1], "-question"),
                         shiny::div(class = "question-input",
                                    instructions,
                                    output))
  }

  return(output)

}


#' Generate the UI Code for demographic questions
#'
#' Create the UI code for a Shiny app based on user-supplied questions.
#'
#' @param df A user supplied data frame in the format of teaching_r_questions.
#' @param survey_title (Optional) user supplied title for the survey
#' @param survey_description (Optional) user supplied description for the survey
#' @param theme A valid R color: predefined such as "red" or "blue"; hex colors
#'   such as #63B8FF (default). To customize the survey's appearance entirely, supply NULL.
#' @param ... Additional arguments to pass into \link[shiny]{actionButton} used to submit survey responses.
#'
#' @return UI Code for a Shiny App.
#' @export
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


surveyOutput <- function(df, survey_title, survey_description, theme = "#63B8FF", ...) {

  survey_env$theme <- theme
  survey_env$question_df <- df
  survey_env$unique_questions <- listUniqueQuestions(df)
  if (!missing(survey_title)) {
    survey_env$title <- survey_title
  }
  if (!missing(survey_description)) {
    survey_env$description <- survey_description
  }

  if ("page" %in% names(df)) {
    main_ui <- multipaged_ui(df = df)
  } else if (!"page" %in% names(df)) {
    main_ui <- shiny::tagList(
      check_survey_metadata(survey_title = survey_title,
                            survey_description = survey_description),
      lapply(survey_env$unique_questions, surveyOutput_individual),
      shiny::div(class = "survey-buttons",
                 shiny::actionButton("submit",
                                     "Submit",
                                     ...)
      )
    )
  }

  if (!is.null(survey_env$theme)) {
    survey_style <- sass::sass(list(
      list(color = survey_env$theme),
      readLines(
        system.file("render_survey.scss",
                    package = "shinysurveys")
      )
    ))
  } else if (is.null(survey_env$theme)) {
    survey_style <- NULL
  }


  shiny::tagList(shiny::includeScript(system.file("shinysurveys-js.js",
                                                  package = "shinysurveys")),
                 shiny::includeScript(system.file("save_data.js",
                                                  package = "shinysurveys")),
                 shiny::tags$style(shiny::HTML(survey_style)),
                 shiny::div(class = "survey",
                            shiny::div(style = "display: none !important;",
                                       shiny::textInput(inputId = "userID",
                                                        label = "Enter your username.",
                                                        value = "NO_USER_ID")),
                            main_ui))

}
