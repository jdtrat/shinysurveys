#' A sample CSV file for demographic questions
#'
#' @format A data frame with 54 rows and 6 columns:
#' \describe{
#' \item{question:}{The question to be asked.}
#' \item{option:}{A possible response to the question. In multiple choice questions,
#' for example, this would be the possible answers. For questions without
#' discrete answers, such as a numeric input, this would be the default option
#' shown on the input. For text inputs, it is the placeholder value.}
#' \item{input_type:}{What type of response is expected? A string with one of the 
#' 6 values below, which will determine which type of Shiny widget is created:}
#' \item{input_type: "select":}{selectInput Shiny widget (dropdown list)}
#' \item{input_type: "numeric":}{numericInput Shiny widget (editable numeric input with spinners)}
#' \item{input_type: "mc" (multiple choice):}{radioButtons Shiny widget
#' (with several mutually exclusive options)}
#' \item{input_type: "text":}{textInput Shiny widget }
#' \item{input_type: "y/n":}{radioButtons  Shiny widget (yes or no choice).
#' Two rows are needed, and the "option" field should contain the two alternatives, such as "Yes" and "No".}
#' \item{input_type: "rank_{{X}}" (where X is to be replaced by an integer, the number of items):}
#' {sets of radioButtons Shiny widgets layed-out in a square matrix, with numbers (1, 2... X) as column headers,
#' and item names as row headers. Lets respondents rank a set of items (in a range from 1 to X), with one item
#' per row, where they can select only one button per row: '1' for the item they rank first, '2' for the item
#' they rank second, etc. (till 'X' for the last item). The text of the items to rank should be listed in the 'options' field.}
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
