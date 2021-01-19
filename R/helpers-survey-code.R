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
#' @keywords internal
#' @noRd
#' @param df User-input dataframe of questions
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
#' @keywords internal
#' @noRd
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

