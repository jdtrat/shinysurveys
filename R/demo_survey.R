#' Demo Survey over multiple pages
#'
#' This function runs a Shiny app that shows an example of running a demographic
#' survey in Shiny. It has a sample title and description and its theme color
#' can be customized using a hex color code.
#'
#' @param theme A valid hex color such as #63B8FF (default)
#'
#' @return A Shiny App
#' @export
#'
#' @examples
#' if (interactive()) demo_survey()
#'
demo_survey <- function(theme = "#63B8FF") {

  ui <- shiny::fluidPage(
        surveyOutput(shinysurveys::teaching_r_questions,
                     survey_title = "A survey title",
                     survey_description = "A description that is longer than the title.",
                     theme = theme)
        )

  server <- function(input, output, session) {

    renderSurvey()

    shiny::observeEvent(input$submit, {

      shiny::showModal(shiny::modalDialog(
        title = "Congratulations, you completed your first shinysurvey!",
        "You can customize what actions happen when a user finishes a survey using input$submit."
      ))

    })

  }

  # Run the application
  shiny::shinyApp(ui = ui, server = server)

}
