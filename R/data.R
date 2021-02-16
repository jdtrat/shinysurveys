#' A sample CSV file for demographic questions
#'
#' A dataset containing the prices and other attributes of almost 54,000
#' diamonds.
#'
#'
#' @format A data frame with 54 rows and 6 columns:
#' \describe{
#' \item{question:}{The question to be asked.}
#' \item{option:}{A possible response to the question. In multiple choice questions,
#' for example, this would be the possible answers. For questions without
#' discrete answers, such as a numeric input, this would be the default option
#' shown on the input. For text inputs, it is the placeholder value.}
#' \item{input_type:}{What type of response is expected? Numeric, multiple choice, text, etc...}
#' \item{input_id:}{The input id for Shiny inputs.}
#' \item{dependence:}{Does this question (row) depend on another?
#' That is, should it only appear if a different question has a specific value?
#' This column contains the input_id of whatever question this one depends upon.}
#' \item{dependence_value:}{This column contains the specific value that the dependence
#' question must take for this question (row) to be shown.}
#' \item{required:}{logical TRUE/FALSE signifying if a question is required.}
#' }
#' @source D'Agostino McGowan Data Science Lab at Wake Forest University.
"teaching_r_questions"
