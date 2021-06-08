
radioMatrixButtons <- function (inputId, choices, selected = NULL)
{

  options <- lapply(choices, FUN = function(value) {

    inputTag <-  tags$td(tags$input(type = "radio", name = inputId, value = value))

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
#' @return The first 10 characters of the response item title in a form
#'   appropriate for HTML IDs
#' @keywords internal
#'
create_radio_input_id <- function(.responseItem) {
  gsub(" ", "_", gsub("[\\'[:punct:]]", "", tolower(.responseItem), perl = FALSE))
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
        tags$tr(class = "radio-matrix-buttons",
                id = paste0("tr-", create_radio_input_id(item)),
                tags$td(
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
