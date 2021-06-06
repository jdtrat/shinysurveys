#' Add correct ID for custom input types
#'
#' `surveyID()` is a helper function for \code{\link{extendInputType}}. When
#' defining custom input types, the `inputId` argument for shiny UI components
#' should equal `surveyID()`. See examples for more details.
#'
#' @seealso \code{\link{extendInputType}}
#' @seealso \code{\link{surveyLabel}}
#' @return NA; used for side effects with \code{\link{extendInputType}}.
#' @export
#'
#' @examples
#'
#' extendInputType("slider", {
#' shiny::sliderInput(
#'   inputId = surveyID(),
#'   label = surveyLabel(),
#'   min = 1,
#'   max = 10,
#'   value = 5
#' )
#' })
#'
surveyID <- function() {
  unique(survey_env$current_question$input_id)
}

#' Add correct label for custom input types
#'
#' `surveyLabel()` is a helper function for \code{\link{extendInputType}}. When
#' defining custom input types, the `label` argument for shiny UI components
#' should equal `surveyLabel()`. See examples for more details.
#'
#' @seealso \code{\link{extendInputType}}
#' @seealso \code{\link{surveyID}}
#' @return NA; used for side effects with \code{\link{extendInputType}}.
#' @export
#'
#' @examples
#'
#' extendInputType("slider", {
#' shiny::sliderInput(
#'   inputId = surveyID(),
#'   label = surveyLabel(),
#'   min = 1,
#'   max = 10,
#'   value = 5
#' )
#' })
#'
surveyLabel <- function() {
  addRequiredUI_internal(survey_env$current_question)
}


#' Add Custom Input Types for a Survey
#'
#' @param input_type A string of the input type supplied in the data frame of questions.
#' @param extension A shiny input type not natively supported by {shinysurveys}. See the examples section for more information.
#'
#' @return NA; used to register custom input types for use with a shiny survey.
#' @export
#'
#' @seealso \code{\link{surveyID}}
#' @seealso \code{\link{surveyLabel}}
#' @examples
#'
#' # Register a slider input to {shinysurveys} with a custom minimum and maximum value.
#'
#' extendInputType("slider", {
#'   shiny::sliderInput(
#'     inputId = surveyID(),
#'     label = surveyLabel(),
#'     min = 1,
#'     max = 10,
#'     value = 5
#'     )
#'   })
#'
#' # Define a question as normal with the `input_type` set to the custom slider type defined above.
#' slider_question <- data.frame(question = "On a scale from 1-10,
#' how much do you love sushi?",
#' option = NA,
#' input_type = "slider",
#' input_id = "sushi_scale",
#' dependence = NA,
#' dependence_value = NA,
#' required = TRUE)
#'
#' # Watch it in action
#' if (interactive()) {
#' ui <- fluidPage(
#'   surveyOutput(df = slider_question, "Sushi Scale Example")
#' )
#'
#' server <- function(input, output, session) {
#'   renderSurvey()
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#'
#'
#' # Register a date input to {shinysurveys}, limiting possible dates to a twenty-day period.
#'
#' extendInputType("date", {
#'   shiny::dateInput(
#'     inputId = surveyID(),
#'     value = Sys.Date(),
#'     label = surveyLabel(),
#'     min = Sys.Date()-10,
#'     max = Sys.Date()+10
#'   )
#' })
#'
#' # Define a question as normal with the `input_type` set to the custom date type defined above.
#'
#' date_question <- data.frame(question = "When do you graduate?",
#' option = NA,
#' input_type = "date",
#' input_id = "grad_date",
#' dependence = NA,
#' dependence_value = NA,
#' required = FALSE)
#'
#' # Watch it in action
#' if (interactive()) {
#' ui <- fluidPage(
#'   surveyOutput(df = date_question, "Date Input Extension Example")
#' )
#'
#' server <- function(input, output, session) {
#'   renderSurvey()
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#'
#' # Combine both custom input types:
#'
#' if (interactive()) {
#' ui <- fluidPage(
#'   surveyOutput(df = rbind(slider_question, date_question), "Date & Slider Input Extension Example")
#' )
#'
#' server <- function(input, output, session) {
#'   renderSurvey()
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#'

extendInputType <- function(input_type, extension) {
  survey_env$input_type <- c(survey_env$input_type, input_type)
  survey_env$input_extension <- c(survey_env$input_extension, list(ext = substitute(extension)))
  names(survey_env$input_extension)[which(names(survey_env$input_extension) == "ext")] <- input_type
  message(paste0("Input Type \"", input_type,"\" registered with {shinysurveys}. If the session restarts, you will need to re-register it.\n",
                 "To see all registered input extensions, please call `shinysurveys::listInputExtensions()`."))
}

#' List all registered survey extensions
#'
#' @return A named list containing the registered input type and their associated functions.
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#'
#'   # Register a date input to {shinysurveys},
#'   # limiting possible dates to a twenty-day period.
#'
#'   extendInputType("slider", {
#'     shiny::sliderInput(
#'       inputId = surveyID(),
#'       label = surveyLabel(),
#'       min = 1,
#'       max = 10,
#'       value = 5
#'       )
#'     })
#'
#'   # Register a slider input to {shinysurveys}
#'   # with a custom minimum and maximum value.
#'
#'   extendInputType("date", {
#'     shiny::dateInput(
#'       inputId = surveyID(),
#'       value = Sys.Date(),
#'       label = surveyLabel(),
#'       min = Sys.Date()-10,
#'       max = Sys.Date()+10
#'     )
#'   })
#'
#'   listInputExtensions()
#'
#' }
#'
listInputExtensions <- function() {
  survey_env$input_extension
}

