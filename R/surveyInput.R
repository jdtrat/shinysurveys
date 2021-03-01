
#' Create a question UI
#'
#' @param inputId The input id
#'
#' @return UI
#'
#' @export

surveyInput <- function(inputId, color, width) {
  shiny::tagList(
    htmltools::htmlDependency(
      name = "surveyInput",
      version = utils::packageVersion("shinysurveys"),
      package = "shinysurveys",
      src = "surveyInput",
      script = "js/surveyInput.js",
      stylesheet = "css/surveyInput.css"
    ),
    shiny::div(class = "surveyInput",
               id = inputId,
               `data-input-id` = inputId,
               `data-width` = width,
               shiny::fluidRow(
                 shiny::column(
                   width = 8,
                   offset = 0,
                   shiny::textInput("question_title",
                                    "",
                                    "Untitled Question",
                                    width = "600px"),
                 ),
                 shiny::column(width = 3,
                               offset = 0.5,
                               shiny::selectInput("question_type",
                                                  "",
                                                  choices = c(
                                                    "Select",
                                                    "Numeric",
                                                    "Multiple Choice",
                                                    "Text",
                                                    "Yes/No"
                                                  )
                               )
                 ),
                 shiny::div(id = paste0("option_placeholder"),
                            shiny::textInput(inputId = "option_1",
                                             label = "",
                                             value = "Placeholder",
                                             width = "69%"),
                            shiny::actionButton("add_option",
                                                label = "",
                                                icon = shiny::icon("plus"))
                            )
               ),
               shiny::fluidRow(
                 shiny::column(
                   width = 2,
                   offset = 6,
                   shiny::actionButton(
                     inputId = paste0("question_delete"),
                     label = "",
                     icon = shiny::icon("trash"),
                     style = "margin-left: 50px;"
                   )
                 ),
                 shiny::column(width = 2,
                               offset = 0,
                               shiny::checkboxInput(
                                 inputId = "question_required",
                                 label = "Required",
                                 value = FALSE
                               )
                 )
               )
    ),
  )
}
