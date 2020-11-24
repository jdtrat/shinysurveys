#' Get input questions parameter
#'
#' @param num_options A vector containing the number of options each question
#'   has. Output from the \code{get_num_options_per_question}.
#' @param input The Shiny input
#' @param form The form reactiveValues object
#'
#' @keywords internal
#'
#'
#'

get_questions <- function(num_options, input, form) {

  purrr::map2_df(.x = num_options,
                 .y = 1:form$num_questions,
                 ~ base::list(question = rep(input[[paste0("question_", .y, "_title")]], .x)))

}

#' Get input question type parameter
#'
#' @param num_options A vector containing the number of options each question
#'   has. Output from the \code{get_num_options_per_question}.
#' @param input The Shiny input
#' @param form The form reactiveValues object
#' @keywords internal
#'
#'
#'

get_question_type <- function(num_options, input, form) {

  purrr::map2_df(.x = num_options,
                 .y = 1:form$num_questions,
                 ~ base::list(input_type = rep(input[[paste0("question_", .y, "_type")]], .x)))

}

#' Get input question required parameter
#' @param num_options A vector containing the number of options each question
#'   has. Output from the \code{get_num_options_per_question}.
#' @param input The Shiny input
#' @param form The form reactiveValues object
#' @keywords internal
#'
#'
#'

get_question_required <- function(num_options, input, form) {

  purrr::map2_df(.x = num_options,
                 .y = 1:form$num_questions,
                 ~ base::list(required = rep(input[[paste0("question_", .y, "_title_", "required")]], .x)))

}

#' Get input individual question options parameter
#'
#' @param input The Shiny input
#' @param question_num The question number
#' @keywords internal
#'
#'
#'
get_individual_question_options <- function(input, question_num) {

  question_options <- names(input)[stringr::str_detect(names(input), paste0("question_", question_num, "_option"))]
  purrr::map_df(.x = question_options,
                ~ base::list(option = input[[.x]]))

}

#' Get number of options per question
#'
#' @param input The Shiny input
#' @param question_num The question number
#' @keywords internal
#'
#'
#'
get_num_options_per_question <- function(input, question_num) {

  # get the number of options that each question has
  length(names(input)[stringr::str_detect(names(input), paste0("question_", question_num, "_option"))])

}

#' Get input question options parameter
#'
#' @param input The Shiny input
#' @param form The form reactiveValues object
#' @keywords internal
#'
#'
#'
get_question_options <- function(input, form) {


  purrr::map_df(.x = 1:form$num_questions,
                ~ get_individual_question_options(input, question_num = .x))

}

#' Get question id parameter
#'
#' @param num_options A vector containing the number of options each question
#'   has. Output from the \code{get_num_options_per_question}.
#' @param input The Shiny input
#' @param form The form reactiveValues object
#'
#' @keywords internal
#'
#'
#'
get_question_id <- function(num_options, input, form) {

  purrr::map2_df(.x = num_options,
                 .y = 1:form$num_questions,
                 ~ base::list(input_id = rep(input[[paste0("question_", .y, "_title")]], .x) %>%
                                snakecase::to_snake_case()))


}

make_question_dataframe <- function(input, form) {

  options_per_question <- purrr::map(.x = 1:form$num_questions,
                              ~get_num_options_per_question(input, question_num = .x))

  questions <- get_questions(num_options = options_per_question, input = input, form = form)
  print(questions)
  options <- get_question_options(input = input, form = form)
  print(options)
  type <- get_question_type(num_options = options_per_question, input = input, form = form)
  print(type)
  input_id <- get_question_id(num_options = options_per_question, input = input, form = form)
  print(input_id)
  dependence <- rep(NA, nrow(questions))
  print(dependence)
  dependence_value <- rep(NA, nrow(questions))
  print(dependence_value)
  required <- get_question_required(num_options = options_per_question, input = input, form = form)
  print(required)


  output <- data.frame("question" = questions,
                       "option" = options,
                       "input_type" = type,
                       "input_id" = input_id,
                       "dependence" = dependence,
                       "dependence_value" = dependence_value,
                       "required" = required)

  return(output)

}
