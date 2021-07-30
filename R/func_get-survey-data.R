#' Get survey data
#'
#' Get a participant's responses.
#'
#' @param custom_id A unique identifier for the survey's respondents. NULL by
#'   default, and the built-in {shinysurveys} userID will be used.
#' @param include_dependencies LOGICAL: TRUE (default) and all dependency
#'   questions will be returned, regardless of if the individual respondent saw
#'   it. For respondents who did not see a specific question, the 'response'
#'   will take on the value from the `dependency_string` argument. If FALSE, the
#'   output will have variable rows depending on which questions a given
#'   participant answered.
#' @param dependency_string A character string to be imputed for dependency
#'   questions that a respondent did not see. Default is "HIDDEN-QUESTION".
#'
#' @return A data frame with four columns containing information about the
#'   participant's survey responses: The 'subject_id' column can be used for
#'   identifying respondents. By default, it utilizes shinysurveys URL-based
#'   user tracking feature. The 'question_id' and 'question_type' columns
#'   correspond to  'input_id' and 'input_type' from the original data frame of
#'   questions. The 'response' column is the participant's answer.
#'
#'   The number of rows, corresponding to the questions an individual saw,
#'   depends on the `include_dependencies` argument. If TRUE, by default, then
#'   the resulting data frame will have one row per unique input ID. If FALSE,
#'   the data frame may have variable length depending on which questions a
#'   given individual answers.
#'
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
#'      print(getSurveyData())
#'    })
#'  }
#'
#'  shinyApp(ui, server)
#'
#'  }
#'
getSurveyData <- function(custom_id = NULL, include_dependencies = TRUE, dependency_string = "HIDDEN-QUESTION") {

  session <- shiny::getDefaultReactiveDomain()

  # get id of instructions input types to exclude from survey response collection
  instructions_id <- survey_env$question_df[which(survey_env$question_df$input_type == "instructions"), "input_id", drop = FALSE]$input_id
  shown_questions <- unique(survey_env$question_df$input_id[which(!survey_env$question_df$input_id %in% instructions_id)])

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

  if (include_dependencies) {
    output[which(output$question_id %in% session$input$shinysurveysHiddenInputs), "response"] <- dependency_string
  } else if (!include_dependencies) {
    output <- output[which(!output$question_id %in% session$input$shinysurveysHiddenInputs),]
  }

  return(output)

 }

