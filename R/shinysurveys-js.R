#' Remove CSS Class
#'
#' Custom function for removing a CSS class used in {shinysurveys}.
#'
#' @param .id Shiny object inputId
#' @param .class class to be removed
#' @keywords internal
#'
#' @return NA; used for side effects
#'
remove_class <- function(.id, .class) {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    "remove_class",
    list(input_id = .id,
         class_name = .class)
  )
}

#' Add CSS Class
#'
#' Custom function for adding a CSS class used in {shinysurveys}.
#'
#' @param .id Shiny object inputId
#' @param .class class to be added
#' @keywords internal
#'
#' @return NA; used for side effects
#'
add_class <- function(.id, .class) {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    "add_class",
    list(input_id = .id,
         class_name = .class)
  )
}

#' Disable HTML element
#'
#' Custom function for disabling an HTML element in {shinysurveys}.
#'
#' @param .id Shiny object inputId
#' @keywords internal
#'
#' @return NA; used for side effects
#'
disable_element <- function(.id) {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    "disable",
    list(input_id = .id)
  )
}

#' Enable HTML element
#'
#' Custom function for disabling an HTML element in {shinysurveys}.
#'
#' @param .id Shiny object inputId
#' @keywords internal
#'
#' @return NA; used for side effects
#'
enable_element <- function(.id) {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    "enable",
    list(input_id = .id)
  )
}


#' Toggle element state
#'
#' Custom function for toggling enable/disable state of HTML element in {shinysurveys}.
#'
#' @param id Shiny object inputId
#' @param condition Condition on which to enable or disable
#' @keywords internal
#'
#' @return NA; used for side effects
#'
toggle_element <- function(id, condition) {

  if (!condition) {
    disable_element(.id = id)
  } else if (condition) {
    enable_element(.id = id)
  }

}
