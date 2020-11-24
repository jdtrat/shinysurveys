
#' Create a question UI
#'
#' @param question_number The question number
#'
#' @return UI
#'
#' @export

flex_form_question_ui <- function(question_number) {
  shiny::tagList(div(id = paste0("question_", question_number),
                     shiny::fluidRow(
                       shiny::column(
                         width = 4,
                         offset = 0,
                         shiny::textInput(paste0("question_", question_number, "_title"),
                                          "",
                                          "Untitled Question",
                                          width = "600px"),
                       ),
                       shiny::column(width = 2,
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
                                  shiny::textInput(inputId = "question_1_option_1",
                                                   label = "Option 1",
                                                   value = "Placeholder")),
                     ),
                     shiny::fluidRow(
                       shiny::column(
                         width = 1,
                         offset = 2,
                         shiny::actionButton(
                           inputId = paste0("question_", question_number, "_title_", "remove"),
                           label = "Remove",
                           icon = shiny::icon("trash")
                         )
                       ),
                       shiny::column(width = 1,
                                     offset = 2.9,
                                     shinyWidgets::switchInput(
                                       inputId = paste0("question_", question_number, "_title_", "required"),
                                       label = "Required",
                                       labelWidth = "60px"
                                     )
                       )
                     )
                 ),
                     # shiny::div(id = paste0("question_", c(question_number + 1)))
  )
}
