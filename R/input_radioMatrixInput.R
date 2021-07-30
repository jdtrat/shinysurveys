
#' Create the actual radio button inputs
#'
#' @param inputId This is the ID for the question to which the radio button
#'   inputs correspond
#' @param choices The choices (values) for each radio button to indicate
#' @param selected A default selected value
#'
#' @return radio button input UI
#' @keywords internal
#'
radioMatrixButtons <- function (inputId, choices, selected = NULL) {

  options <- lapply(choices, FUN = function(value) {

    inputTag <-  shiny::tags$td(shiny::tags$input(type = "radio", name = inputId, value = value))

    if (value %in% selected) {
      inputTag$attribs$checked <- "checked"
    }

    inputTag
  })
  options
}

#' Create radio input ID
#'
#' @param .responseItem
#'
#' @return The response item title in a form appropriate for HTML IDs (and tidy data)
#' @keywords internal
#'
create_radio_input_id <- function(.responseItem) {
  gsub(" ", "_", gsub("[\\'[:punct:]]", "", tolower(.responseItem), perl = FALSE))
}



#' Create the radio matrix input's header
#'
#' @param .choices Possible choices
#' @param .required Logical: TRUE/FALSE should a required asterisk be placed on the matrix question
#'
#' @return Header for the table (matrix input)
#' @keywords internal
#'
radioMatHeader <- function(.choices, .required) {

  if (.required) {
    required_placeholder <- shiny::tags$th(class = "required", "*", style = "font-size: 18px;")
  } else {
    required_placeholder <- shiny::tags$th()
  }

  shiny::tags$tr(
    required_placeholder,
    lapply(X = .choices, function(choice) {
      shiny::tags$th(choice)
    })
  )
}


#' Create the table body
#'
#' @param .responseItems Questions to be asked (row labels)
#' @param .choices Possible choices (values for radio buttons)
#' @param .selected Initial selected value
#'
#' @return UI for the matrix input (table) body
#' @keywords internal
#'
radioBody <- function(.responseItems, .choices, .selected = NULL) {

  shiny::tags$tbody(
    lapply(
      X = .responseItems, function(item, choice, select) {
        shiny::tags$tr(class = "radio-matrix-buttons",
                id = paste0("tr-", create_radio_input_id(item)),
                shiny::tags$td(class = "radio-matrix-buttons-label",
                id = paste0("td-", create_radio_input_id(item)),
                  item
                ),
                radioMatrixButtons(inputId = create_radio_input_id(item),
                                    choices = choice,
                                    selected = select)
        )
      },
      choice = .choices,
      select = .selected
    )
  )
}

#' Create a matrix of radio buttons.
#'
#' @param inputId The input id
#' @param responseItems The questions to be asked (row labels)
#' @param choices Possible choices (column labels)
#' @param selected Initial selected value
#' @param ... Additional arguments specific to {shinysurveys} required questions.
#'
#' @return A matrix of radio buttons that can be added to a UI definition. When
#'   run in a Shiny application, this will return \code{NULL} until all possible
#'   response items have been answered, at which time a data frame with the
#'   question_id, question_type, and response, the format used in
#'   \code{\link{getSurveyData}}.
#'
#' @export
#'
#' @examples
#' # For use as a normal Shiny input:
#'
#' if (interactive()) {
#'
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     radioMatrixInput("matInput",
#'                      responseItems = c("Love sushi?", "Love chocolate?"),
#'                      choices = c("Disagree", "Neutral", "Agree"))
#'   )
#'
#'   server <- function(input, output, session) {
#'     observe({
#'       print(input$matInput)
#'     })
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
#'
#' # For use in {shinysurveys}
#'
#' if (interactive()) {
#'
#'  df <- data.frame(
#'    question = c(rep("I love sushi.", 3), rep("I love chocolate.",3),
#'    "What's your favorite food?", rep("Goat cheese is the GOAT.", 5),
#'    rep("Yogurt and berries are a great snack.",5),
#'    rep("SunButter® is a fantastic alternative to peanut butter.", 5)),
#'    option = c(rep(c("Disagree", "Neutral", "Agree"), 2), "text",
#'    rep(c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"), 3)),
#'    input_type = c(rep("matrix", 6), "text", rep("matrix", 15)),
#'    # For matrix questions, the IDs should be the same for each question
#'    # but different for each matrix input unit
#'    input_id = c(rep("matId", 6), "favorite_food", rep("matId2", 15)),
#'    dependence = NA,
#'    dependence_value = NA,
#'    required = FALSE
#'  )
#'
#'  library(shiny)
#'
#'  ui <- fluidPage(
#'    surveyOutput(df)
#'  )
#'
#'  server <- function(input, output, session) {
#'    renderSurvey()
#'    observe({
#'      print(input$matId)
#'      print(input$favorite_food)
#'      print(input$matId2)
#'    })
#'  }
#'
#'  shinyApp(ui, server)
#'
#' }
#'
radioMatrixInput <- function(inputId, responseItems, choices, selected = NULL, ...) {
  shiny::tagList(
    htmltools::htmlDependency(
      name = "radioMatrixInput",
      version = utils::packageVersion("shinysurveys"),
      package = "shinysurveys",
      src = "radioMatrixInput",
      script = "js/radioMatrixInput.js",
      stylesheet = "css/radioMatrixInput.css"
    ),
    shiny::div(class = "radioMatrixInput",
               id = inputId,
               shiny::tags$table(
                 radioMatHeader(.choices = choices, ...),
                 radioBody(.responseItems = responseItems,
                           .choices = choices,
                           .selected = selected)
               )
    )
  )
}
