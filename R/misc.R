
# Internal function copied from {shiny} source code.
#
# GitHub Link:
# \url{https://github.com/rstudio/shiny/blob/dcca77c9362ad45992777a97b32726e6f373e059/R/shiny.R#L51}
# If the input to jsonlite::fromJSON is not valid JSON, it will try to fetch a
# # URL or read a file from disk. We don't want to allow that.
#
safeFromJSON <- function(txt, ...) {
  if (!jsonlite::validate(txt)) {
    stop("Argument 'txt' is not a valid JSON string.")
  }
  jsonlite::fromJSON(txt, ...)
}
