test_that("base parse query string for user ID works", {

  query <- shiny::parseQueryString("?user_id=hadley&other_parameter=other/")

  base_val <- base_extract_user_id(query)

  expect_equal(base_val, "hadley")

})
