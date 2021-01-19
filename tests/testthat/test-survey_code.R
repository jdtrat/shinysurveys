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
