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
