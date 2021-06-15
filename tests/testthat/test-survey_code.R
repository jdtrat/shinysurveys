# Setup test questions ----------------------------------------------------

ds_questions <- data.frame(question = c("What is your name?",
                                        "Who's your advisor?",
                                        "What are your research interests?",
                                        "What are your long term career goals?",
                                        "What other courses are you taking / other big commitments?",
                                        "How would you rate your current understanding of the topics in this course (data science, exploratory data analysis, graphical data analysis)?",
                                        "How much experience have you already had with R?",
                                        "In general, how much programming experience have you had?"),
                           option = "Your Answer",
                           input_type = "text",
                           input_id = c("name", "advisor", "interests", "goals", "other_courses", "current_understanding", "experience_with_r", "programming_experience"),
                           dependence = c(NA, "name", NA, NA, NA, NA, NA, NA),
                           dependence_value = c(NA, "bas", NA, NA, NA, NA, NA, NA),
                           required = c(T, F, F, F, T, F, F, T))

ds_all_required <- transform(ds_questions, required = T)

ds_no_required <- transform(ds_questions, required = F)

# Test internal data processing -------------------------------------------

test_that("listUniqueQuestions() works", {
  listed <- listUniqueQuestions(teaching_r_questions)
  expect_equal(length(listed), 14)

  listed_ds <- listUniqueQuestions(ds_questions)
  expect_equal(length(listed_ds), 8)

})

test_that("addRequiredUI_internal() correctly adds asterisks to required questions", {

  required <- listUniqueQuestions(ds_all_required)[[1]]
  not_required <- listUniqueQuestions(ds_no_required)[[1]]

  span_regex <- '<span class="required">\\*</span>'

  # must convert this to character for checking as it has class shiny.tag.list
  expect_match(as.character(addRequiredUI_internal(required)), span_regex)

  no_match <- function() {
    expect_match(addRequiredUI_internal(not_required), span_regex)
  }

  expect_error(no_match())

})

# Test Server Functionality --------------------------------------------------------

## Test Required Questions

test_that("server works when some questions are required and others are not", {

  server <- function(input, output, session) {

    required_vec <- getRequired_internal(
      listUniqueQuestions(
        ds_questions
      )
    )

    toggle_button <- reactive({checkRequired_internal(input = input, required_inputs_vector = required_vec)})

  }

  shiny::testServer(server, {
    session$setInputs(name = "answer",
                      advisor = "answer",
                      interests = "answer",
                      goals = "answer",
                      current_understanding = "answer",
                      experience_with_r = "answer",
                      )

    # expect false because not all required questions have been answered
    expect_false(toggle_button())

    session$setInputs(other_courses = "answer",
                      programming_experience = "answer")

    # expect true because all required questions have been answered
    expect_true(toggle_button())
  })

})


test_that("server works when all questions are required", {

  server <- function(input, output, session) {

    required_vec <- getRequired_internal(
      listUniqueQuestions(
        ds_all_required
      )
    )

    toggle_button <- reactive({checkRequired_internal(input = input, required_inputs_vector = required_vec)})

  }

  shiny::testServer(server, {
    session$setInputs(name = "answer",
                      advisor = "answer",
                      interests = "answer",
                      goals = "answer",
                      other_courses = "answer",
                      current_understanding = "answer",
                      experience_with_r = "answer",
                      programming_experience = "answer")
    expect_true(toggle_button())
  })

})

test_that("server works when no questions are required", {

  server <- function(input, output, session) {

    required_vec <- getRequired_internal(
      listUniqueQuestions(
        ds_no_required
      )
    )

    toggle_button <- reactive({checkRequired_internal(input = input, required_inputs_vector = required_vec)})

  }

  shiny::testServer(server, {
    expect_true(toggle_button())
  })

})

## Test Dependency Questions -- just a sample

test_that("server works with dependency questions - text based", {
  server <- function(input, output, session) {

    listed <- listUniqueQuestions(ds_questions)

    show_dependency <- reactive({showDependence(input = input, df = listed[[2]])})

  }

  shiny::testServer(server, {
    session$setInputs(name = "ba")
    expect_false(show_dependency())
    session$setInputs(name = "ba s")
    expect_false(show_dependency())
    session$setInputs(name = "bas")
    expect_true(show_dependency())
  })

})


test_that("server works with dependency questions - multiple choice", {
  server <- function(input, output, session) {

    listed <- listUniqueQuestions(teaching_r_questions)

    show_dependency <- reactive({showDependence(input = input, df = listed[[3]])})

  }

  shiny::testServer(server, {
    session$setInputs(gender = "")
    expect_false(show_dependency())
    session$setInputs(gender = "prefer to self describe")
    expect_false(show_dependency())
    session$setInputs(gender = "Prefer to self describe")
    expect_true(show_dependency())
  })

})


test_that("input type error catch works", {

  no_error <- data.frame(question = "Question about input types",
                   option = NA,
                   input_type = "select",
                   # Note the input IDs are specific for the language option
                   input_id = "testing-input-error",
                   dependence = NA,
                   dependence_value = NA,
                   required = TRUE)

  error <- no_error
  error$input_type <- "unknown-input-type"

  expect_silent(
    ui <- shiny::fluidPage(
      surveyOutput(no_error)
    )
  )

  expect_error(
    ui <- shiny::fluidPage(
      surveyOutput(error)
    )
  )

})
