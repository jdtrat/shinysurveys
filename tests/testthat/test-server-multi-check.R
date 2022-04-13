

# This example requires custom input extension, e.g.:
# extendInputType("check", {
  # shiny::checkboxGroupInput(
    # inputId = surveyID(),
    # label = surveyLabel(),
    # choices = surveyOptions()
  # )
# })

ice_cream_questions <- data.frame(
  stringsAsFactors = FALSE,
  question = c("Please indicate your top three favorite ice cream flavors.",
               "Please indicate your top three favorite ice cream flavors.",
               "Please indicate your top three favorite ice cream flavors.",
               "Please indicate your top three favorite ice cream flavors.",
               "Please indicate your top three favorite ice cream flavors.",
               "Please indicate your top three favorite ice cream flavors.",
               "Please indicate your top three favorite ice cream flavors.",
               "Please indicate your top three favorite ice cream flavors.",
               "Please indicate your top three favorite ice cream flavors.",
               "Please indicate your top three favorite ice cream flavors.","Specify:"),
  option = c("Chocolate","Vanilla",
             "Strawberry","Mint Chocolate Chip","Rocky Road",
             "Cookie Batter","Hazelnut","Cookies N' Cream","Pistachio","Other",
             NA),
  input_type = c("check","check","check",
                 "check","check","check","check","check","check","check",
                 "text"),
  input_id = c("favorite_ice_cream",
               "favorite_ice_cream","favorite_ice_cream","favorite_ice_cream",
               "favorite_ice_cream","favorite_ice_cream",
               "favorite_ice_cream","favorite_ice_cream","favorite_ice_cream",
               "favorite_ice_cream","favorite_ice_cream_other"),
  dependence = c(NA,NA,NA,NA,NA,NA,NA,NA,
                 NA,NA,"favorite_ice_cream"),
  dependence_value = c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "Other"),
  required = c(FALSE,FALSE,FALSE,FALSE,
               FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE),
  page = c("1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1")
)

test_that("server works with dependency questions - multiple values for an input", {
  server <- function(input, output, session) {

    listed <- listUniqueQuestions(ice_cream_questions)

    show_dependency <- reactive({showDependence(input = input, df = listed[[2]])})

  }

  shiny::testServer(server, {
    session$setInputs(favorite_ice_cream = c("Chocolate"))
    expect_false(show_dependency())
    session$setInputs(favorite_ice_cream = c("Chocolate", "Cookies N' Cream"))
    expect_false(show_dependency())
    session$setInputs(favorite_ice_cream = c("Chocolate", "Cookies N' Cream", "Other"))
    expect_true(show_dependency())
  })

})
