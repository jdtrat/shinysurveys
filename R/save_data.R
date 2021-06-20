# Internal function to make the survey response data frame when there are mismatched
# data frame rows, as is likely to happen with custom input extensions.
make_survey_response_df <- function(.question_id, .question_type, .response) {

  numId <- length(.question_id)
  numType <- length(.question_type)
  numResponse <- nrow(.response)

  if (numId == numType & numId == numResponse) {
    output <- data.frame(
      question_id = .question_id,
      question_type = .question_type,
      response = .response
    )
  } else if (numId == numType & numId > numResponse) {

    output <- data.frame(
      question_id = .question_id,
      question_type = .question_type,
      response = rbind(.response, rep(NA, numId - numResponse))
    )

  } else if (numId == numType & numId < numResponse) {

    output <- data.frame(
      question_id = c(.question_id, rep(NA, numResponse - numId)),
      question_type = c(.question_type, rep(NA, numResponse - numType)),
      response = .response
    )

  } else {
    stop("Could not save data. Unknown error.\n Please file an issue at https://github.com/jdtrat/shinysurveys/issues, including a data set that recreates this problem.")
  }

  return(output)
}

# Check for questions that return multiple answers
# such as selectInput(multiple = TRUE) or checkboxGroupInput
# If that's the case, collapse the input into one row for aggregating responses
check_length <- function(.input) {
  if (length(.input) == 1) {
    as.character(.input)
  } else if (length(.input) != 1) {
    as.character(paste0(.input, collapse = ","))
  }
}

#' Get survey data
#'
#' Get a participant's responses.
#'
#' @param custom_id A unique identifier for the survey's respondents. NULL by
#'   default, and the built-in {shinysurveys} userID will be used.
#'
#' @return A participant's responses.
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#'
#'  library(shiny)
#'
#'  ui <- fluidPage(
#'    surveyOutput(teaching_r_questions)
#'  )
#'
#'  server <- function(input, output, session) {
#'    renderSurvey()
#'    # Upon submission, print a data frame with participant responses
#'    observeEvent(input$submit, {
#'      print(get_survey_data())
#'    })
#'  }
#'
#'  shinyApp(ui, server)
#'
#'  }
#'
get_survey_data <- function(custom_id = NULL) {

  session <- shiny::getDefaultReactiveDomain()

  shown_questions <- unique(survey_env$question_df$input_id[which(!survey_env$question_df$input_id %in% session$input$shinysurveysHiddenInputs)])

  for (i in seq_along(survey_env$unique_questions)) {
    survey_env$unique_questions[[i]]$question_number <- rep(i, nrow(survey_env$unique_questions[[i]]))
  }

  survey_env$ordered_question_df <- do.call(rbind, survey_env$unique_questions)

  shown_subset <- survey_env$ordered_question_df[which(survey_env$ordered_question_df$input_id %in% shown_questions),]
  shown_input_types <- do.call(rbind,
                               lapply(
                                 split(shown_subset, factor(shown_subset$input_id, levels = unique(shown_subset$input_id))),
                                 function(x) x[1,"input_type", drop = FALSE]$input_type)
  )

  responses <- do.call(rbind,
                      lapply(
                        shown_questions, function(x) {
                          data.frame(response = check_length(.input = session$input[[x]]))
                        }
                      ))

  output <- make_survey_response_df(.question_id = shown_questions,
                                    .question_type = shown_input_types,
                                    .response = responses)

  if ("matrix" %in% survey_env$ordered_question_df$input_type) {

    matrix_ids <- unique(survey_env$ordered_question_df[which(survey_env$ordered_question_df$input_type == "matrix"), "input_id"])$input_id

    matrix_responses <- do.call(rbind,
                                lapply(
                                  matrix_ids, function(x) session$input[[x]]
                                )
    )
    output <- rbind(output, matrix_responses)
    rownames(output) <- NULL

    bounded <- survey_env$ordered_question_df
    bounded[which(bounded$input_type == "matrix"), "input_id"] <- bounded[which(bounded$input_type == "matrix"), "question"]
    bounded[which(bounded$input_type == "matrix"),"input_id"] <- vapply(X = bounded[which(bounded$input_type == "matrix"), "input_id"]$input_id, FUN = function(x) {
      create_radio_input_id(x)}, FUN.VALUE = character(1), USE.NAMES = FALSE)
    bounded <- bounded[,c("input_id", "input_type", "question_number")]
    names(bounded) <- c("question_id", "question_type", "question_number")

    output <- merge(output, bounded)
    output <- output[order(output$question_number), ]
    output <- output[,-4]

  }

  if (!is.null(custom_id)) {
    output <- cbind(subject_id = custom_id,
                    output)
  } else if (is.null(custom_id)) {
    output <- cbind(subject_id = session$input$userID,
                    output)
  }


  output <- split(output, factor(output$question_id, levels = unique(output$question_id)))
  output <- do.call(rbind, lapply(
    output, function(x) x[1,]
  ))
  rownames(output) <- NULL

  return(output)

 }

