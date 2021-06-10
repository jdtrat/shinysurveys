
test_that("surveyOutput() works - teaching_r_questions", {
  local_edition(3)
  expect_snapshot_output(surveyOutput(df = teaching_r_questions,
                                      survey_title = "Testing Title",
                                      survey_description = "Testing Description"))
})
