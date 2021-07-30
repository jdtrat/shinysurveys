#' Check survey metadata
#'
#' Returns title/description HTML tags as needed.
#'
#' @param survey_description The survey's description from surveyOutput
#' @param survey_title The survey's title from surveyOutput
#'
#' @keywords internal
#'
#' @return Returns error messages if required paramters are not supplied,
#'   otherwise it returns the appropriate code for survey titles and description
#'   for use in surveyOutput.
#'
check_survey_metadata <- function(survey_description, survey_title) {

  if (!missing(survey_description) && missing(survey_title)) {
    stop("Must provide a survey title in order to provide a survey description.")
  } else if (missing(survey_title) && missing(survey_description)) {
    return()
  } else if (!missing(survey_title) && missing(survey_description)) {

    if (is.null(survey_title)) {
      return()
    } else {
      return(
        shiny::div(class = "title-description",
                   shiny::h1(id = "survey-title", survey_title))
      )
    }


  } else if (!missing(survey_title) && !missing(survey_description)) {

    if (is.null(survey_title) && is.null(survey_description)){
      return()
    } else {
      return(
        shiny::div(class = "title-description",
                   shiny::h1(id = "survey-title", survey_title),
                   shiny::p(id = "survey-description", survey_description))
      )
    }

  }
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
