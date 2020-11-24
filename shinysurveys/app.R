library(shiny)
library(shinyjs)
library(shinyalert)
library(rdrop2)
library(glue)

#establish SASS file
sass::sass(
    sass::sass_file("www/survey.scss"),
    output = "www/survey.css"
)

ui <- shiny::fluidPage(
    shinyjs::useShinyjs(),
    shiny::sidebarPanel(
        shiny::actionButton("add_option", "Add an option"),
        shiny::actionButton(
            "create_question",
            "Create a Question"
        ),
        shiny::actionButton(
            "submit",
            "Submit"
        )
    ),
    shiny::mainPanel(
        #default question
        flex_form_question_ui(question_number = 1)
    )

)

server <- function(input, output, session) {
    # Have a question already present
    # Have options as 0 by default
    form <- reactiveValues(num_questions = 1,
                           num_options = 0)


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
        # add new question
        form$num_questions <-  form$num_questions + 1
        #reset option numbers
        form$num_options <- 0
        form$questions <- tagList(form$questions, flex_form_question_ui(form$num_questions))
        insertUI(
            selector = paste0("#question_", form$num_questions),
            ui = flex_form_question_ui(form$num_questions)
        )
    })

    observeEvent(input$submit, {
        # Right now, it won't print out a question if there are no options for it.
        print(make_question_dataframe(input, form))
    })



}

# Run the application
shiny::shinyApp(ui = ui, server = server)

