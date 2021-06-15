instructions_added <-
  rbind(data.frame(question = "In the following thing, please do this thing.",
           option = NA,
           input_type = "instructions",
           # Note the input IDs are specific for the language option
           input_id = "age",
           dependence = NA,
           dependence_value = NA,
           required = TRUE),
  rbind(teaching_r_questions))


test_that("surveyOutput() works - instructions added", {
  local_edition(3)
  expect_snapshot_output(shiny::fluidPage(
    shinysurveys::surveyOutput(df = instructions_added,
                               survey_title = "Testing Instructions")
  ))
})


matrix_instructions <- data.frame(question = c("Please indicate how much you agree or disagree with the following statements:",
                              rep("My team members can depend upon me as a 'safe space' when they are experiencing stressful workplace experiences.", 5),
                              rep("I feel competent in my role as a leader",5), rep("I have a different identity as a leader than I do when I am with family or friends.", 5),
                              rep("The best way to get my team members to work independently is to keep them at a distance", 5), rep("In the past 3 months, I have used breathing exercises", 5),
                              rep("In the past 3 months, I have practiced silencing my mind.", 5), rep("I communicate the emotions I am feeling to my team members.", 5),
                              rep("To check the words I use to express emotions with my body to see if the words are right for the feelings.", 5)),
                 # Repeat all possible options for each of the eight questions
                 option = c(NA, rep(c("Strongly Disagree", "Disagree", "Neither Agree or Disagree", "Agree", "Strongly Agree"), 8)),
                 # use {shinysurveys} now-native "matrix" input type
                 #we repeat it 40 times since there are 5 options per question and there are 8 questions
                 input_type = c("instructions", rep("matrix", 40)),
                 # repeat the input ID for all 8 questions that are part of the matrix
                 # we repeat it 40 times since there are 5 options per question and there are 8 questions
                 input_id = "matId_1",
                 dependence = NA,
                 dependence_value = NA,
                 required = F)

test_that("surveyOutput() works - instructions with matrix", {
  local_edition(3)
  expect_snapshot_output(shiny::fluidPage(
    shinysurveys::surveyOutput(df = matrix_instructions,
                               survey_title = "Testing Instructions - Matrix")
  ))
})

multiple_instructions <- rbind(instructions_added, matrix_instructions)


test_that("surveyOutput() works - instructions with matrix and teaching-r-questions", {
  local_edition(3)
  expect_snapshot_output(shiny::fluidPage(
    shinysurveys::surveyOutput(df = multiple_instructions,
                               survey_title = "Testing Instructions - Matrix & Teaching R Questions")
  ))
})
