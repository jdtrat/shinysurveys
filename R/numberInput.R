shinyInputLabel <- utils::getFromNamespace("shinyInputLabel", "shiny")

#' Create a numeric input
#'
#' Create an input control for entry of numeric values. This is identical to
#' [shiny::numericInput()] but is more flexible in **not** requiring an initial
#' value and in allowing placeholders.
#'
#'
#'
#' @param inputId The `input` slot that will be used to access the value.
#' @param label Display label for the control, or `NULL` for no label.
#' @param value Initial value. NULL by default.
#' @param width The width of the input, e.g. `'400px'`, or `'100%'`; see
#'   [validateCssUnit()].
#' @param placeholder A character string giving the user a hint as to what can
#'   be entered into the control. Internet Explorer 8 and 9 do not support this
#'   option.
#' @param min Minimum allowed value
#' @param max Maximum allowed value
#' @param step Interval to use when stepping between min and max
#'
#' @return A numeric input control that can be added to a UI definition.
#'
#' @seealso [shiny::updateNumericInput()]
#'
#' @examples
#'
#' if (interactive()) {
#' library(shiny)
#' library(shinysurveys)
#'
#' ui <- fluidPage(
#'   numberInput("obs", "Observations:", placeholder = "How many do you see?", min = 1, max = 100),
#'   verbatimTextOutput("value")
#' )
#' server <- function(input, output) {
#'   output$value <- renderText({ input$obs })
#' }
#' shinyApp(ui, server)
#' }
#'
#' @section Server value: A numeric vector of length 1.
#'
#' @export
#'
numberInput <- function(inputId, label, value = NULL, min = NA, max = NA, step = NA,
                        placeholder = NULL, width = NULL) {

  inputTag <- shiny::tags$input(id = inputId, type = "number",
                                class = "form-control",
                                placeholder = placeholder)

  if (!is.na(min))
    inputTag$attribs$min <- min
  if (!is.na(max))
    inputTag$attribs$max <- max
  if (!is.na(step))
    inputTag$attribs$step <- step
  if (!is.null(value))
    inputTag$attribs$value <- value

  shiny::tagList(
    shiny::div(class = "surveyNumericInput",
               style = htmltools::css(width = shiny::validateCssUnit(width)),
               shinyInputLabel(inputId, label), inputTag)

    )
}

