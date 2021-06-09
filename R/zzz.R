.onLoad <- function(...) {

  shiny::registerInputHandler("radioMatrixInput.dataframe", function(value, ...) {
    if (is.null(value)) {
      return(value)
    } else {
      df <- safeFromJSON(value)
      return(df)
    }
  }, force = TRUE)
}
