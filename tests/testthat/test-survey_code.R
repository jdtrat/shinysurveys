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


rank_questions <- data.frame(question = "Please rank your favorite sushi rolls.",
                             option = c("Rainbow", "Florida", "Double Salmon", "Volcano", "California"),
                             input_type = "rank_{{5}}", # change the 5 to change the ranking scale 1 - X
                             input_id = c("rainbow", "florida", "double_salmon", "volcano", "california"),
                             dependence = NA,
                             dependence_value = NA,
                             required = F)

paged_teaching_r_questions <- data.frame(
  stringsAsFactors = FALSE,
  question = c("What's your age?",
               "Which best describes your gender?",
               "Which best describes your gender?","Which best describes your gender?",
               "Which best describes your gender?",
               "Which best describes your gender?",
               "What is the highest level of education you have attained?",
               "What is the highest level of education you have attained?",
               "What is the highest level of education you have attained?",
               "What is the highest level of education you have attained?",
               "What is the highest level of education you have attained?",
               "What is the highest level of education you have attained?",
               "What was your first language?","What was your first language?",
               "What was your first language?","What was your first language?",
               "What was your first language?","What was your first language?",
               "What was your first language?",
               "What was your first language?","What was your first language?",
               "What was your first language?","What was your first language?",
               "What was your first language?","What was your first language?",
               "What was your first language?",
               "What was your first language?","In what language do you read most often?",
               "In what language do you read most often?",
               "In what language do you read most often?",
               "In what language do you read most often?","In what language do you read most often?",
               "In what language do you read most often?",
               "In what language do you read most often?",
               "In what language do you read most often?",
               "In what language do you read most often?","In what language do you read most often?",
               "In what language do you read most often?",
               "In what language do you read most often?",
               "In what language do you read most often?","In what language do you read most often?",
               "In what language do you read most often?",
               "Have you ever learned to program in R?",
               "Have you ever learned to program in R?",
               "If yes, how many years have you been using R?",
               "Have you ever learned a programming language (other than R)?",
               "Have you ever learned a programming language (other than R)?",
               "If yes, which language(s) and how many years have you been using each language?",
               "Have you ever completed a data analysis?",
               "Have you ever completed a data analysis?",
               "If yes, approximately how many data analyses have you completed?",
               "If yes, approximately how many data analyses have you completed?",
               "If yes, approximately how many data analyses have you completed?",
               "If yes, approximately how many data analyses have you completed?"),
  option = c("25","Female","Male",
             "Prefer not to say","Prefer to self describe",NA,
             "Did not attend high school","Some high school",
             "High school graduate","Some college","College","Graduate Work","Arabic",
             "Armenian","Chinese","English","French","Creole",
             "German","Greek","Gujarati","Hebrew","Hindi",
             "Italian","Japanese","Other",NA,"Arabic","Armenian",
             "Chinese","English","French","Creole","German","Greek",
             "Gujarati","Hebrew","Hindi","Italian","Japanese",
             "Other",NA,"Yes","No","5","Yes","No",NA,"Yes","No",
             "0 to 5","5 to 10","10 to 15","15+"),
  input_type = c("numeric","mc","mc","mc",
                 "mc","text","select","select","select","select",
                 "select","select","select","select","select","select",
                 "select","select","select","select","select","select",
                 "select","select","select","select","text","select",
                 "select","select","select","select","select",
                 "select","select","select","select","select","select",
                 "select","select","text","y/n","y/n","numeric","y/n",
                 "y/n","text","y/n","y/n","mc","mc","mc","mc"),
  input_id = c("age","gender","gender",
               "gender","gender","self_describe_gender",
               "education_attained","education_attained","education_attained",
               "education_attained","education_attained","education_attained",
               "first_language","first_language","first_language",
               "first_language","first_language","first_language",
               "first_language","first_language","first_language",
               "first_language","first_language","first_language",
               "first_language","first_language","first_language_other",
               "read_language","read_language","read_language",
               "read_language","read_language","read_language","read_language",
               "read_language","read_language","read_language",
               "read_language","read_language","read_language","read_language",
               "read_language_other","learned_r","learned_r",
               "years_using_r","learned_programming_not_r",
               "learned_programming_not_r","years_programming_not_r",
               "completed_data_analysis","completed_data_analysis",
               "number_completed_data_analysis","number_completed_data_analysis",
               "number_completed_data_analysis","number_completed_data_analysis"),
  dependence = c(NA,NA,NA,NA,NA,"gender",
                 NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                 NA,NA,NA,NA,NA,"first_language",NA,NA,NA,NA,
                 NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,"read_language",
                 NA,NA,"learned_r",NA,NA,"learned_programming_not_r",
                 NA,NA,"completed_data_analysis",
                 "completed_data_analysis","completed_data_analysis","completed_data_analysis"),
  dependence_value = c(NA,NA,NA,NA,NA,
                       "Prefer to self describe",NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                       NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,"Other",NA,NA,
                       NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,"Other",
                       NA,NA,"Yes",NA,NA,"Yes",NA,NA,"Yes","Yes","Yes",
                       "Yes"),
  required = c(TRUE,TRUE,TRUE,TRUE,TRUE,
               FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,
               FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,
               FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,
               FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,
               FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,FALSE,TRUE,
               TRUE,FALSE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE),
  page = c("intro","intro","intro",
           "intro","intro","intro","intro","intro","intro","intro",
           "intro","intro","mid","mid","mid","mid","mid",
           "mid","mid","mid","mid","mid","mid","mid","mid",
           "mid","mid","mid","mid","mid","mid","mid","mid",
           "mid","mid","mid","mid","mid","mid","mid","mid","mid",
           "finale","finale","finale","finale","finale",
           "finale","finale","finale","finale","finale","finale",
           "finale")
)


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


# Test UI Output ------------------------------------------------------------

test_that("surveyOutput() works - teaching_r_questions", {
  local_edition(3)
  expect_snapshot_output(surveyOutput(df = teaching_r_questions,
                                      survey_title = "Testing Title",
                                      survey_description = "Testing Description"))
})

test_that("surveyOutput() works - ds_questions", {
  local_edition(3)
  expect_snapshot_output(shiny::fluidPage(
    shinysurveys::surveyOutput(df = ds_questions,
                               survey_title = "Getting To Know You",
                               survey_description = "Welcome! This is a quick survey for us to become familiar with each other's backgrounds in this class.")
  ))
})

test_that("surveyOutput() works - ranking_questions", {
  local_edition(3)
  expect_snapshot_output(shiny::fluidPage(
    shinysurveys::surveyOutput(df = rank_questions,
                               survey_title = "Rank your favorite sushi rolls")
  ))
})

test_that("surveyOutput() works - paged_questions", {
  local_edition(3)
  expect_snapshot_output(shiny::fluidPage(
    shinysurveys::surveyOutput(df = paged_teaching_r_questions,
                               survey_title = "Test This MultiPaged Survey")
  ))
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
