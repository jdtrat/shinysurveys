.onLoad <- function(...) {
  shiny::registerInputHandler("surveyInput.questionDataFrame", function(value, ...) {
      if (is.null(value)) {
        return(value)
      } else {
        df <- shiny:::safeFromJSON(value)
        return(df)
      }
    }, force = TRUE)
}
