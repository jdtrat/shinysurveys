# Create a new environment for access within a survey
survey_env <- base::new.env(parent = base::emptyenv())

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

  output <- split(df, factor(df$input_id, levels = unique(df$input_id)))
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

#' Control Title UI Placement for Multi-paged Surveys
#'
#' @param page
#'
#' @keywords internal
#'
#' @return UI for title if applicable
#'
title_placeholder <- function(page) {
  if (page == "1") {
    check_survey_metadata(survey_description = survey_env$description,
                          survey_title = survey_env$title)
  } else {
    NULL
  }
}

#' Button placement on each page of questions
#'
#' @param page Current page to define UI for. Specified in \code{\link{multipaged_ui}}
#'
#' @keywords internal
#'
#' @return UI for "Next", "Previous", and "Submit" buttons
#'
button_placeholders <- function(page) {

  # If there's only one page, just display submit button
  if (page == "1" && length(unique(survey_env$question_df$page)) == 1) {
    shiny::div(class = "survey-buttons",
               shiny::actionButton("submit", "Submit")
    )

  } else if (page == "1" && length(unique(survey_env$question_df$page)) != 1) {
    shiny::div(class = "survey-buttons",
               shiny::actionButton(paste0("next-", page), "Next", `page-action` = "next")
    )
  } else if (page != "1" && page != as.character(survey_env$num_pages)) {
    shiny::div(class = "survey-buttons",
               shiny::actionButton(paste0("previous-", page), "Previous", `page-action` = "previous"),
               shiny::actionButton(paste0("next-", page), "Next", `page-action` = "next")
    )
  } else if (page == as.character(survey_env$num_pages)) {
    shiny::div(class = "survey-buttons",
               shiny::actionButton(paste0("previous-", page), "Previous", `page-action` = "previous"),
               shiny::actionButton("submit", "Submit")
    )
  }
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
