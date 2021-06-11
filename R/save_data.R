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
                                 function(x) x[1,"input_type"])
  )
  names(shown_input_types) <- "question_type"

  output <- data.frame(
    question_id = shown_questions,
    question_type = shown_input_types,
    response = do.call(rbind,
                       lapply(
                         shown_questions, function(x) {
                           data.frame(response = as.character(session$input[[x]]))
                         }
                       ))
  )

  if ("matrix" %in% survey_env$ordered_question_df$input_type) {

    matrix_ids <- unique(survey_env$ordered_question_df[which(survey_env$ordered_question_df$input_type == "matrix"), "input_id"])

    matrix_responses <- do.call(rbind,
                                lapply(
                                  matrix_ids, function(x) session$input[[x]]
                                )
    )
    output <- rbind(output, matrix_responses)
    rownames(output) <- NULL

    bounded <- survey_env$ordered_question_df
    bounded[which(bounded$input_type == "matrix"), "input_id"] <- bounded[which(bounded$input_type == "matrix"), "question"]
    bounded[which(bounded$input_type == "matrix"),"input_id"] <- vapply(X = bounded[which(bounded$input_type == "matrix"), "input_id"], FUN = function(x) {
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

