#' Demo Survey over multiple pages
#'
#' This function runs a Shiny app that shows an example of running a demographic
#' survey in Shiny. Upon submission, it saves the responses to your downloads
#' folder.
#'
#' It requires shiny, shinyjs, and shinyWidgets.
#'
#' @return A Shiny App
#' @export
#'
#' @examples
#'
#' \dontrun{
#' demo_survey()
#' }
demo_survey <- function() {

  requireNamespace("shiny")
  requireNamespace("shinyjs")
  requireNamespace("shinyWidgets")

  ui <- shiny::fluidPage(
    shiny::tags$head(
      shiny::tags$style(
        shiny::HTML('
            @import url("https://fonts.googleapis.com/css?family=Source+Code+Pro|Montserrat|Raleway");
@import url("https://fonts.googleapis.com/css?family=Inconsolata");
.grid {
  display: grid;
  overflow: scroll;
  width: 100%;
  height: 100%;
  grid-template-columns: 1fr 1fr 1fr;
  background-color: #e8f4f8;
}

.container-fluid {
  background-color: #c1e1ec;
}

.survey {
  padding: 20px;
  /* border: 1px solid black; */
  grid-column-start: 2;
  grid-column-end: 2;
  /* justify-items: center;
  justify-self: center; */
  position: center;
  background-color: #c1e1ec;
}

.input-pane {
  grid-column-start: 1;
  padding: 20px;
  border: 1px solid black;
  grid-column-end: 1;
  position: fixed;
  background-color: #d4ebf2;
}

body {
  font-family: \'Raleway\', sans-serif;
  background-color: #e8f4f8;
}

code {
  font-family: \'Source Code Pro\', monospace;
  font-size: 14px;
}

.console {
  font-family: \'Inconsolata\', monospace;
  position: fixed;
  bottom: 0;
  width: 100%;
  background: black;
  opacity: .8;
  padding: 20px;
  color: white;
  z-index: 99999;
}

h1, h2, h3, h4, h5, h6 {
  color: #333;
  font-family: \'Montserrat\', sans-serif;
}

h1, h2, h3 {
  text-transform: uppercase;
  text-align: left;
  letter-spacing: .1em;
  line-height: 1.2;
}

h1 {
  margin: 36px 0;
}

h1.title {
  color: #416983;
}

h3 {
  font-style: italic;
  font-family: \'Montserrat\', sans-serif;
}

p {
  color: #333;
  margin: 35px;
  margin-bottom: 10px;
}

li.l {
  margin-left: 40px;
  margin-right: 35px;
}

')
      )
    ),
shiny::div(class = "grid",
    shiny::div(class = "survey",
        shiny::h1("Sample Survey"),
        surveyOutput(shinysurveys::teaching_r_questions)
        )
    )
  )

  server <- function(input, output, session) {

    renderSurvey(input = input, df = shinysurveys::teaching_r_questions, session = session)

    shiny::observeEvent(input$submit, {

      shiny::showModal(shiny::modalDialog(
        title = "Congrats, you submitted your first shinysurvey!",
        "You can customize what actions happen when a user finishes a survey using input$submit."
      ))

    })

  }

  # Run the application
  shiny::shinyApp(ui = ui, server = server)

}
