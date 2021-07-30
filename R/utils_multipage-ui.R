

#' Wrap Questions in the Appropriate Page Divider
#'
#' @param question_df The data frame of questions supplied by the user,
#' split in \code{\link{multipaged_ui}}.
#' @param page_id The page ID
#'
#' @keywords internal
#'
#' @return UI for a "page" of questions
#'
addPages <- function(question_df, page_id) {

  shiny::div(class = ifelse(page_id != "1", "page page-hidden", "page page-visible"),
             id = paste0("page-", page_id),
             title_placeholder(page = page_id),
             lapply(question_df, surveyOutput_individual),
             button_placeholders(page = page_id))

}


#' Place survey questions on multiple pages
#'
#' @param df The data frame of questions supplied by the user
#'
#' @keywords internal
#'
#' @return UI for all pages
#'
multipaged_ui <- function(df) {

  paged <- split(df, factor(df$page, levels = unique(df$page)))
  paged <- lapply(paged, listUniqueQuestions)
  # Keep track of number of pages for controlling button behavior
  survey_env$num_pages <- length(names(paged))
  # convert all page indicators to ordered list
  names(paged) <- as.character(seq(1:length(names(paged))))
  class(paged) <- c("list", "paged")
  output <- mapply(FUN = addPages,
                   question_df = paged,
                   page_id = names(paged),
                   SIMPLIFY = FALSE)
  return(output)
}
