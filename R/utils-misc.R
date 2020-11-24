
#' Old ui generator
#' @param form
#'
#' @keywords internal
#' @return Old UI
#' @export
#'
#' @examples
form_question_ui <- function(form) {
  shiny::div(
    class = "binder",
    id = form$input_id,
    shiny::div(
      class = "relative",
      surveyOutput_individual(form)
    ),
    shiny::div(
      class = "absolute",
      shiny::actionButton(
        inputId = paste0(form$input_id, "remove", sep = "_"),
        label = "Remove",
        icon = shiny::icon("trash")
      ),
      shinyWidgets::switchInput(
        inputId = paste0(form$input_id, "required", sep = "_"),
        label = "Required",
        labelWidth = "60px",
        size = "mini",
      )
    )
  )
}
