
#' Old ui generator
#' @param form
#'
#' @keywords internal
#' @return Old UI
#'
form_question_ui <- function(form) {
  shiny::div(
    class = "binder",
    id = form$input_id,
    shiny::div(
      class = "relative",
      surveyOutput_individual(form)
    ),
    shiny::div(
      class = "absolute",
      shiny::actionButton(
        inputId = paste0(form$input_id, "remove", sep = "_"),
        label = "Remove",
        icon = shiny::icon("trash")
      ),
      shinyWidgets::switchInput(
        inputId = paste0(form$input_id, "required", sep = "_"),
        label = "Required",
        labelWidth = "60px",
        size = "mini",
      )
    )
  )
}


#' Manual Creation of a .Rproj file
#'
#' @param path The file path to save .Rproj file
#'
#' @keywords internal
create_project_manual <- function(path) {

  if (!grepl(".Rproj", path)) {
    path <- paste0(path, ".Rproj")
  }

  project <- "

Version: 1.0

RestoreWorkspace: Default
SaveWorkspace: Default
AlwaysSaveHistory: Default

EnableCodeIndexing: Yes
UseSpacesForTab: Yes
NumSpacesForTab: 2
Encoding: UTF-8

RnwWeave: Sweave
LaTeX: pdfLaTeX

AutoAppendNewline: Yes
StripTrailingWhitespace: Yes

  "

  writeLines(project, path)
}


#' Sanitize filenames
#'
#' Convert to all lowercase and replace spaces with underscores
#'
#' @param string
#' @noRd
sanitize_file_name <- function(string) {
  out <- gsub(" ", "_", string)
  out <- tolower(out)
  return(out)
}
