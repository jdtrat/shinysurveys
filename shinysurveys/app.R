library(shiny)
library(shinysurveys)
library(shinyjs)
library(shinyalert)
library(whisker)

ui <- shiny::fillPage(
    shinyjs::useShinyjs(),
    uiOutput("sass"),
    div(class = "binder",
        shiny::tagList(
          fluidRow(
            column(width = 2,
                   offset = 8,
                   fluidRow(
                shiny::tags$i(id = "palette-icon", class = "fas fa-palette"),
                colourpicker::colourInput("survey_color", "", value = "#add8e6", palette = "limited")
                ))),
          fluidRow(
            column(width = 2,
                   offset = 8,
            shiny::downloadButton("download_app", "Download App", style = "margin-left: -30px;")
          )
          )
    )
    ),
    div(class = "grid",
        div(class = "survey",
            div(class = "title-description",
            shiny::textInput("survey_title",
                             "",
                             "Untitled Survey"),
            shiny::textInput("survey_description",
                             "",
                             "Survey description")
            ),
            #default question
            flex_form_question_ui(question_number = 1),
        ),
        div(class = "footer",
            "Designed by Jonathan Trattner. Github link. Other stuff.")
    )

)

server <- function(input, output, session) {

    output$sass <- renderUI({
        tags$head(tags$style(css()))
    })

    css <- reactive({
        sass::sass(list(
            list(color = input$survey_color),
            "
@import url('https://fonts.googleapis.com/css?family=Source+Code+Pro|Montserrat|Raleway');
@import url('https://fonts.googleapis.com/css?family=Inconsolata');

$little_dark: darken($color, 5%);
$middle_dark: darken($color, 10%);
$little_light: lighten($color, 5%);
$middle_light: lighten($color, 10%);
$questions_background: $middle_light;
$light: lighten($color, 15%);
$dark: darken($color, 15%);

.binder {
  background-color: white;
  padding-bottom: 10px;
  border-bottom: 0.5px solid $dark;
}

.grid {
  display: grid;
  overflow: scroll;
  width: 100%;
  height: 100%;
  grid-template-columns: 1fr 1fr 1fr;
  background-color: $light;
  padding-bottom: 200px;
}

.footer {

  visibility: hidden;
  grid-column-start: 1;
  grid-column-end: 4;
  background-color: white;
  border-top: 0.5px solid $dark;

}

.shiny-input-container:not(.shiny-input-container-inline) {
  width: 100%;
}

.container-fluid {
  background-color: $little_light;
}

.survey {
  padding: 20px;
  /* border: 1px solid black; */
  grid-column-start: 2;
  grid-column-end: 2;
  /* justify-items: center;
  justify-self: center; */
  position: center;
  background-color: transparent;
}

.questions {
  background-color: white;
  border-radius: 20px;
  margin-bottom: 12px;
}

.title-description {
  background-color: white;
  border-radius: 20px;
  border-top: 20px solid $middle_dark;
  padding-left: 10px;
  padding-bottom: 10px;
  margin-bottom: 12px;
}

.input-pane {
  grid-column-start: 1;
  padding: 20px;
  border: 1px solid black;
  grid-column-end: 1;
  position: fixed;
  background-color: $middle_light;
}

body {
	font-family: 'Raleway', sans-serif;
	background-color: $light;
}

code {
	font-family: 'Source Code Pro', monospace;
	font-size: 14px;
}

.console {
	font-family: 'Inconsolata', monospace;
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
	font-family: 'Montserrat', sans-serif;
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

h1.title{
	color: #416983;
}


h3 {
	font-style: italic;
	font-family: 'Montserrat', sans-serif;
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

#survey_title {
  height: 50px;
  font-size: 24pt;
  background-color: transparent;
  width: 91%;
}

#survey_description {
  width: 91%;
}

input[type=text]:focus {
  border-bottom: 1.5px solid $little_dark;
  -webkit-box-shadow: none
}

input[type=text] {
  font-size: 12pt;
  border: none;
  box-shadow: none;
  border-radius: 0;
  border-bottom: 1px dashed rgba(0,0,0,0.12);
  padding: 15px;
  outline: none;
  color: #3A506B;
  background-color: transparent;
}


input[id^='question_'][id$='_title'] {
  margin-left: 10px;
  font-size: 14pt;
}

div[id^='option_placeholder'] {
  margin-left: 26px;
}

.colourpicker-input-container {
  background-image: none;
  padding-left: 45px;
  margin-top: -52px;
}

#survey_color {
  width: 20px;
}

#palette-icon {
  color: $color;
  font-size: 2em;
  padding-top: 22px;
  padding-left: 10px;
}

            "
        ))
    })

    # Have a question already present
    # Have options as 0 by default
    form <- reactiveValues(num_questions = 1,
                           num_options = 1)


    # # IF DEPENDENCE IS NOT NA IT WILL BE HIDDEN SO IT WILL "WORK" BUT NOT
    # shiny::observe({
    #
    #     if (input$dependency == TRUE) {
    #         shinyjs::show(id = "question_dependence")
    #         shiny::updateSelectInput(session, "question_dependence", choices = "question")
    #         shinyjs::show(id = "question_dependence_value")
    #         shiny::updateSelectInput(session, "question_dependence_value",
    #                                  label = paste0("For what value of ", input$question_dependence, " should this question appear?")
    #         )
    #     } else {
    #         shinyjs::hide(id = "question_dependence")
    #         shinyjs::hide(id = "question_dependence_value")
    #     }
    # })

    observeEvent(input$add_option, {
        form$num_options <- form$num_options + 1
        insertUI(selector = paste0("#option_placeholder_", form$num_questions),
                 ui = textInput(inputId = paste0("question_", form$num_questions, "_option_", form$num_options),
                                label = "",
                                value = "Placeholder",
                                width = "69%"))
    })

    observeEvent(input$create_question, {

        #reset option numbers
        form$num_options <- 1
        # add new question
        form$num_questions <- form$num_questions + 1

        # create a new question
        insertUI(
            selector = paste0("#question_", form$num_questions - 1),
            ui = flex_form_question_ui(form$num_questions),
            where = "afterEnd"
        )

    })

    output$download_app <- shiny::downloadHandler(
        filename = "survey.zip",
        content = function(file) {

            # Create the app and sass templates and fill in the data parameters with the GUI inputs.
            app_template <- readLines("www/template.R")
            sass_template <- readLines("www/survey_template.scss")
            app_data <- list("survey_title" = paste0('"', input$survey_title, '"'))
            sass_data <- list("survey_color" = input$survey_color)

            # Create a temp directory and set it as the working directory
            tmp <- tempdir()
            setwd(tmp)
            dir.create(path = "survey/")
            dir.create(path = "survey/survey_app/")
            dir.create(path = "survey/survey_app/www/")

            # Create a project file for the survey
            shinysurveys:::create_project_manual(path = paste0("survey/", input$survey_title, ".Rproj"))

            # Write the app, sass file, and survey questions csv
            base::writeLines(whisker::whisker.render(app_template, app_data), "survey/survey_app/app.R")
            base::writeLines(whisker::whisker.render(sass_template, sass_data), "survey/survey_app/www/survey.scss")
            readr::write_csv(shinysurveys:::make_question_dataframe(input, form), "survey/survey_app/www/survey_questions.csv")

            # Zip the files and unlink tmp directory
            zip(zipfile = file,
                files = c(paste0("survey/", input$survey_title, ".Rproj"),
                          "survey/survey_app/app.R",
                          "survey/survey_app/www/survey.scss",
                          "survey/survey_app/www/survey_questions.csv"))

        },
        contentType = "application/zip"
    )

    shiny::observe({

        # purrr::walk(.x = 1:form$num_questions,
        #             ~ disable_text_type_questions(input, .x))


      shinyjs::onclick(id = "question_1")
      purrr::walk(.x = 1:form$num_questions,
                  ~ shinysurveys:::delete_questions(input, .x))

    })

}

# Run the application
shiny::shinyApp(ui = ui, server = server)

