
matrix_questions <- data.frame(
  question = c(rep("I love sushi.", 3), rep("I love chocolate.",3),
               "What's your favorite food?", rep("Goat cheese is the GOAT.", 5),
               rep("Yogurt and berries are a great snack.",5),
               rep("SunButter® is a fantastic alternative to peanut butter.", 5)),
  option = c(rep(c("Disagree", "Neutral", "Agree"), 2), "text",
             rep(c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"), 3)),
  input_type = c(rep("matrix", 6), "text", rep("matrix", 15)),
  # For matrix questions, the IDs should be the same for each question
  # but different for each matrix input unit
  input_id = c(rep("matId", 6), "favorite_food", rep("matId2", 15)),
  dependence = NA,
  dependence_value = NA,
  required = FALSE
)

test_that("surveyOutput() works - matrix questions", {
  local_edition(3)
  expect_snapshot_output(shiny::fluidPage(
    shinysurveys::surveyOutput(df = matrix_questions,
                               survey_title = "Testing Matrix Questions")
  ))
})
