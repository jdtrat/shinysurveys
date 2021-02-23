#' Extract user ID from query string
#'
#'
#' @param query_list The query list object from \code{shiny::parseQueryString}
#'
#' @keywords internal
#' @return User ID
#'
base_extract_user_id <- function(query_list) {
  regmatches(query_list[["user_id"]], regexpr(pattern = "[^*/]+", text = query_list[["user_id"]]))
}


#' Get unique questions from user-input dataframe
#'
#' @param df User-input dataframe of questions
#'
#' @keywords internal
#'
#' @return List of questions
#'
get_questions <- function(df) {

  output <- split(df, factor(df$question, levels = unique(df$question)))
  names(output) <- NULL
  return(output)

}

#' Split questions based on dependency
#'
#' @param df A data frame subset for one question
#'
#' @keywords internal
#'
#' @return A list where each element is one UI question.
#'
split_dependence <- function(df) {
  if (all(is.na(df$dependence)) | all(!is.na(df$dependence))) {
    list(df)
  } else {
    list(
      df[is.na(df$dependence),],
      df[!is.na(df$dependence),]
    )
  }
}

#' Simple pluck
#'
#' simple and specific version of purrr::pluck to meet use-case
#' @param list A list object
#' @param index A numeric index
#'
#'
#' @keywords internal
#'
#' @return Returns list element.
#'
pluck_by_index <- function(list, index) {
  list[[index]]
}

#' Create rank UI for individual options
#'
#' @param df Individual option rows of the df
#' @param num_ranks The number of ranking
#' @keywords internal
#'
#' @return UI for individual rank elements
#'
rank_ui_internal <- function(df, num_ranks) {
  shiny::radioButtons(inputId = base::unique(df$input_id),
                      label = addRequiredUI_internal(df),
                      selected = base::character(0),
                      choices = seq(1, num_ranks, by = 1),
                      inline = TRUE)
}


#' Parse the number of ranks to include for rank questions
#'
#' @param input_type The input type
#' @keywords internal
#'
#' @return Numeric to be used for determining number of ranks
#'
parse_num_ranks <- function(input_type) {

  as.numeric(
    regmatches(input_type, gregexpr(pattern = "(?<={{).*(?=}})",
                                    text = input_type, perl = T))[[1]]
  )

}


