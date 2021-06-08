.onLoad <- function(...) {
  shiny::registerInputHandler("radioMatrixInput.dataframe", function(value, ...) {
    if (is.null(value)) {
      return(value)
    } else {
      df <- shiny:::safeFromJSON(value)
      return(df)
    }
  }, force = TRUE)
}
