
#' Create a question UI
#'
#' @param inputId The input id
#'
#' @return UI
#'
#' @export

surveyInput <- function(inputId) {
  shiny::tagList(
    htmltools::htmlDependency(
      name = "surveyInput",
      version = utils::packageVersion("shinysurveys"),
      package = "shinysurveys",
      src = "surveyInput",
      script = "js/surveyInput.js",
      stylesheet = "css/surveyInput.scss"
    ),
    shiny::div(class = "surveyInput",
               id = inputId,
               `data-input-id` = inputId,
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
                               shiny::selectInput(paste0("question_", inputId, "_type"),
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
                 shiny::div(id = paste0("option_placeholder_", inputId),
                            shiny::textInput(inputId = paste0("question_", inputId, "_option_1"),
                                             label = "",
                                             value = "Placeholder",
                                             width = "69%")),
                 shiny::div(class = "form-options",
                     id = paste0("form-options-question_", inputId),
                     shiny::actionButton("add_option",
                                         "Op"),
                     shiny::actionButton(
                       "create_question",
                       label = "",
                       icon = shiny::icon("plus")
                     )
                 )
               ),
               shiny::fluidRow(
                 shiny::column(
                   width = 2,
                   offset = 6,
                   shiny::actionButton(
                     inputId = paste0("question_", inputId, "_title_delete"),
                     label = "",
                     icon = shiny::icon("trash"),
                     style = "margin-left: 50px;"
                   )
                 ),
                 shiny::column(width = 2,
                               offset = 0,
                               shinyWidgets::switchInput(
                                 inputId = paste0("question_", inputId, "_title_required"),
                                 label = "Required",
                                 labelWidth = "60px"
                               )
                 )
               )
    ),
  )
}
