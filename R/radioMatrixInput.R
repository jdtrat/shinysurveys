
matrixRadioButtons <- function (inputId, choices, selected = NULL)
{

  options <- lapply(choices, FUN = function(value) {

    inputTag <-  tags$td(tags$input(type = "radio", name = inputId, value = value))

    if (value %in% selected) {
      inputTag$attribs$checked <- "checked"
    }

    inputTag
  })
  div(class = "matrix-radio-buttons", id = paste0("radio-buttons-", inputId),  options)
}

#' Create radio input ID
#'
#' @param .responseItem
#'
#' @return The first 10 characters of the response item title in a form
#'   appropriate for HTML IDs
#' @keywords internal
#'
create_radio_input_id <- function(.responseItem) {
  gsub(" ", "_", gsub("[\\'[:punct:]]", "", tolower(strtrim(.responseItem, 10)), perl = FALSE))
}



radioMatHeader <- function(.choices) {
  tags$tr(
    tags$td(),
    lapply(X = .choices, function(choice) {
      tags$th(choice)
    })
  )
}


radioBody <- function(.responseItems, .choices, .selected = NULL) {

  tags$tbody(
    lapply(
      X = .responseItems, function(item, choice, select) {
        tags$tr(
                tags$td(
                id = paste0("td-", create_radio_input_id(item)),
                  item
                ),
                matrixRadioButtons(inputId = create_radio_input_id(item),
                                    choices = choice,
                                    selected = select)
        )
      },
      choice = .choices,
      select = .selected
    )
  )
}

#' Create a question UI
#'
#' @param inputId The input id
#' @param responseItems The questions to be asked
#' @param choices Possible choices
#' @param selected Selected value initially
#'
#' @return UI
#'
#' @export

radioMatrixInput <- function(inputId, responseItems, choices, selected = NULL) {
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
                 radioMatHeader(.choices = choices),
                 radioBody(.responseItems = responseItems,
                           .choices = choices,
                           .selected = selected)
               )
    )
  )
}
