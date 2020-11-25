library(shiny)
library(shinyjs)
library(shinyalert)
library(rdrop2)
library(glue)
library(whisker)

#establish SASS file
sass::sass(
    sass::sass_file("www/survey.scss"),
    output = "www/survey.css"
)

ui <- shiny::fillPage(
    tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "survey.css")
    ),
    shinyjs::useShinyjs(),
    div(class = "NA",
        shiny::tagList(
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
        filename = "yes.csv",
        content = function(file) {

            # template <- readLines("www/template.R")
            # data <- list("survey_title" = input$survey_title)
            # fs::dir_create(path = path)
            write.csv(make_question_dataframe(input, form), file)
            # base::writeLines(whisker::whisker.render(template, data), paste0(file, "/app.R"))
            # fs::dir_create(path = paste0(path, "/www/"))
            #fs::file_copy(path = "www/survey.scss", new_path = paste0(file, "/www/survey.scss"))
        },
        contentType = "text/csv"
    )

    shiny::observe({

        # purrr::walk(.x = 1:form$num_questions,
        #             ~ disable_text_type_questions(input, .x))

        purrr::walk(.x = 1:form$num_questions,
                    ~ remove_questions(input, .x))

    })



}

# Run the application
shiny::shinyApp(ui = ui, server = server)

