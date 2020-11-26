library(shiny)
library(shinysurveys)
library(shinyjs)
library(shinyalert)
library(rdrop2)
library(glue)
library(whisker)

ui <- shiny::fillPage(
    shinyjs::useShinyjs(),
    uiOutput("sass"),
    div(class = "binder",
        shiny::tagList(
            colourpicker::colourInput("survey_color", "Survey Color", value = "#add8e6"),
            shiny::actionButton("add_option", "Add an option"),
            shiny::actionButton(
                "create_question",
                "Create a Question"
            ),
            shiny::actionButton("submit", "Submit"),
            shiny::downloadButton("download_app", "Download App")
        )
    ),
    div(class = "grid",
        div(class = "survey",
            shiny::textInput("survey_title",
                             "Survey Title",
                             "Untitled"),
            #default question
            flex_form_question_ui(question_number = 1),
        )
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
$little_light: lighten($color, 5%);
$middle_light: lighten($color, 10%);
$light: lighten($color, 15%);
$dark: darken($color, 15%);

.grid {
  display: grid;
  overflow: scroll;
  width: 100%;
  height: 100%;
  grid-template-columns: 1fr 1fr 1fr;
  background-color: $light;

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
  background-color: $little_light;
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
                                label = paste0("Option ", form$num_options),
                                value = "Placeholder"))
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
            usethis::create_project("survey", open = FALSE)

            # Write the app, sass file, and survey questions csv
            base::writeLines(whisker::whisker.render(app_template, app_data), "survey/survey_app/app.R")
            base::writeLines(whisker::whisker.render(sass_template, sass_data), "survey/survey_app/www/survey.scss")
            write.csv(shinysurveys:::make_question_dataframe(input, form), "survey/survey_app/www/survey_questions.csv")

            # Zip the files and unlink tmp directory
            zip(zipfile = file,
                files = c("survey",
                          "survey/survey_app/app.R",
                          "survey/survey_app/www/survey.scss",
                          "survey/survey_app/www/survey_questions.csv"))
            unlink(tmp)

        },
        contentType = "application/zip"
    )

    shiny::observe({

        # purrr::walk(.x = 1:form$num_questions,
        #             ~ disable_text_type_questions(input, .x))

        purrr::walk(.x = 1:form$num_questions,
                    ~ shinysurveys:::remove_questions(input, .x))

    })

}

# Run the application
shiny::shinyApp(ui = ui, server = server)

