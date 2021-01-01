library(shiny)
library(shinysurveys)
library(shinyjs)
library(shinyalert)
library(whisker)

ui <- shiny::fillPage(
    shinyjs::useShinyjs(),
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

  num_tag <- reactiveVal(0)

  observeEvent(input$survey_color, {
    num_tag(num_tag() + 1)
    shiny::insertUI(
      selector = "head",
      where = "beforeEnd",
      ui = tags$style(id = paste0("survey_color_", num_tag()),
                      css()))
    shiny::removeUI(selector = paste0("#survey_color_", (num_tag() - 1)))
    })

     css <- reactive({
        sass::sass(list(
            list(color = input$survey_color),
            readLines("www/app.scss")
        ))
    })

    # Have a question already present
    # Have options as 0 by default
    form <- reactiveValues(num_questions = 1,
                           num_options = 1)

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
            app_data <- list("survey_title" = paste0('"', input$survey_title, '"'),
                             "survey_description" = paste0('"', input$survey_description, '"'),
                             "theme_color" = paste0('"', input$survey_color, '"'))

            # Create a temp directory and set it as the working directory
            tmp <- tempdir()
            setwd(tmp)
            dir.create(path = "survey/")
            dir.create(path = "survey/survey_app/")
            dir.create(path = "survey/survey_app/www/")

            # Create a project file for the survey
            shinysurveys:::create_project_manual(path = paste0("survey/", sanitize_file_name(input$survey_title), ".Rproj"))

            # Write the app, sass file, and survey questions csv
            base::writeLines(whisker::whisker.render(app_template, app_data), "survey/survey_app/app.R")
            readr::write_csv(shinysurveys:::make_question_dataframe(input, form), "survey/survey_app/www/survey_questions.csv")

            # Zip the files and unlink tmp directory
            zip(zipfile = file,
                files = c(paste0("survey/", sanitize_file_name(input$survey_title), ".Rproj"),
                          "survey/survey_app/app.R",
                          "survey/survey_app/www/survey_questions.csv"))

        },
        contentType = "application/zip"
    )

    shiny::observe({

        # purrr::walk(.x = 1:form$num_questions,
        #             ~ disable_text_type_questions(input, .x))


      shinyjs::onclick(id = "question_1",
                       shinyjs::show(id = "options_binding"))

      purrr::walk(.x = 1:form$num_questions,
                  ~ shinysurveys:::delete_questions(input, .x))

    })

}

# Run the application
shiny::shinyApp(ui = ui, server = server)

