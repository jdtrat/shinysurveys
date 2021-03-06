
#' Create a question UI
#'
#' @param inputId The input id
#'
#' @return UI
#'
#' @export

surveyInput <- function(inputId, color, width = "300px") {
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
               shiny::div(class="header-inputs",
                  shiny::textInput(paste0(inputId,"_question_title"),"","Untitled Question"),
                  shiny::selectInput(paste0(inputId, "_question_type"),
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
                            div(class="options",
                                shiny::textInput(inputId = "option_1",
                                             label = "",
                                             value = "Placeholder",
                                             width = "69%"))
                            ),
               shiny::div(class="footer-icons",
                 shiny::div(class="left-icons",
                   shiny::actionButton(paste0(inputId, "_add_option"), label = "", icon = shiny::icon("plus"))
                 ),
                 shiny::div(class="right-icons",
                   shiny::actionButton(paste0(inputId, "_question_delete"), label = "", icon = shiny::icon("trash")),
                   shiny::checkboxInput(paste0(inputId, "_question_required"), label = "Required", value = FALSE)
                 )
               )
    )
  )
}
