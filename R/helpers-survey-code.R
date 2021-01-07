#' Replace NA values in a column using only base R
#'
#' @keywords internal
#' @param df A dataframe
#' @param column A column name (unqouted -- similar to tidyverse syntax)
#' @param replacement An NA replacement value
#'
#' @return The data frame with replacements for NA in the specified column
#'
#'
#' @examples
#'
#' \dontrun{base_replace_na(teaching_r_questions, option, "Placeholder")}
#'
base_replace_na <- function(df, column, replacement) {
  col <- substitute(column)
  df[[eval(deparse(col), envir = df)]][is.na(df[[eval(deparse(col), envir = df)]])] <- replacement
  df
}

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
