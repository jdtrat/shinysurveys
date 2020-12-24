
#' Create a question UI
#'
#' @param question_number The question number
#'
#' @return UI
#'
#' @export

flex_form_question_ui <- function(question_number) {
  shiny::tagList(shiny::div(class = "questions",
    id = paste0("question_", question_number),
                     shiny::fluidRow(
                       shiny::column(
                         width = 8,
                         offset = 0,
                         shiny::textInput(paste0("question_", question_number, "_title"),
                                          "",
                                          "Untitled Question",
                                          width = "600px"),
                       ),
                       shiny::column(width = 3,
                                     offset = 0.5,
                                     shiny::selectInput(paste0("question_", question_number, "_type"),
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
                       shiny::div(id = paste0("option_placeholder_", question_number),
                                  shiny::textInput(inputId = paste0("question_", question_number, "_option_1"),
                                                   label = "",
                                                   value = "Placeholder",
                                                   width = "69%")),
                     ),
                     shiny::fluidRow(
                       shiny::column(
                         width = 2,
                         offset = 6,
                         shiny::actionButton(
                           inputId = paste0("question_", question_number, "_title_delete"),
                           label = "",
                           icon = shiny::icon("trash"),
                           style = "margin-left: 50px;"
                         )
                       ),
                       shiny::column(width = 2,
                                     offset = 0,
                                     shinyWidgets::switchInput(
                                       inputId = paste0("question_", question_number, "_title_required"),
                                       label = "Required",
                                       labelWidth = "60px"
                                     )
                       )
                     )
                 ),
  )
}
