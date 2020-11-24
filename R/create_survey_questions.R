#' Create Survey Questions
#'
#' This function runs a Shiny app that allows the user to create survey
#' questions for use with the shinysurveys package.
#'
#' @export
#'
create_survey_questions <- function() {

  # Define UI for application that draws a histogram
  ui <- shiny::fluidPage(
    tags$head(
      tags$style(HTML("

div.binder_flex {
  display: flex;
}



div.binder {
  position: relative;
}
div.relative {
  position: relative;
  width: 400px;
  height: 200px;
}

div.absolute {
  position: absolute;
  top: 100px;
  left: 150px;
  width: 200px;
  height: 100px;
}

    ")
    ),
    shinyjs::useShinyjs(),
    shiny::sidebarPanel(
      shiny::selectInput("question_type",
        "What type of Question would you like to add?",
        choices = c(
          "Select",
          "Numeric",
          "Multiple Choice",
          "Text",
          "Yes/No"
        )
      ),
        # tags$div(id = "option_placeholder"),
        shiny::actionButton("add_option", "Add an option"),
        helpText("This is the default value shown for numeric or text questions.",
                 "For Select, Multiple Choice, or Yes/No questions, these are the possible response options."),
      shiny::textInput(
        "question_title",
        "What is the question's title?"
      ),
      shiny::checkboxInput(
        "dependency",
        "This question has a dependency"
      ),
      shinyjs::hidden(shiny::selectInput("question_dependence",
        "Which question does this depend on?",
        choices = "FILL THIS IN WITH THE QUESTIONS ADDED"
      )),
      shinyjs::hidden(shiny::selectInput("question_dependence_value",
        label = "For what value of tha question should this one be shown?",
        choices = "FILL THIS IN WITH THE QUESTIONS ADDED"
      )),
      shiny::checkboxInput(
        "question_required",
        "This question will be required."
      ),
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
)
  server <- function(input, output, session) {
    # Have a question already present
    # Have options as 0 by default
    form <- reactiveValues(num_questions = 1,
                           num_options = 0)


    # IF DEPENDENCE IS NOT NA IT WILL BE HIDDEN SO IT WILL "WORK" BUT NOT
    shiny::observe({

      if (input$dependency == TRUE) {
        shinyjs::show(id = "question_dependence")
        shiny::updateSelectInput(session, "question_dependence", choices = "question")
        shinyjs::show(id = "question_dependence_value")
        shiny::updateSelectInput(session, "question_dependence_value",
          label = paste0("For what value of ", input$question_dependence, " should this question appear?")
        )
      } else {
        shinyjs::hide(id = "question_dependence")
        shinyjs::hide(id = "question_dependence_value")
      }
    })

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
      print(make_question_dataframe(input, form))
    })



  }

  # Run the application
  shiny::shinyApp(ui = ui, server = server)
}


