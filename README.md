<h1 align="center">

shinysurveys

</h1>

<h4 align="center">

Easily create and deploy surveys in Shiny

</h4>

<p align="center">

<!-- badges: start -->

[![R-CMD-check](https://github.com/jdtrat/shinysurveys/workflows/R-CMD-check/badge.svg)](https://github.com/jdtrat/shinysurveys/actions) [![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

<!-- badges: end -->

</p>

------------------------------------------------------------------------

<img src="https://jdtrat.com/packages/shinysurveys/hex/shinysurveys_hex-final.png" width="328" height="378" align="right"/>

{shinyscreenshot} provides easy-to-use, minimalistic code for creating and deploying surveys in Shiny. Originally inspired by Dean Attali's [shinyforms](https://github.com/daattali/shinyforms), our package provides a framework for robust surveys, similar to Google Forms, in R with [Shiny](http://github.com/rstudio/shiny/).

## Table of contents

-   [Installation](#installation)
-   [Demos](#demos)
-   [Getting Started](#getting-started)
-   [Advanced Surveys](#advanced-surveys)
-   [Further Reading](#further-reading)
-   [Feedback](#feedback)

------------------------------------------------------------------------

<h2 id="installation">

Installation

</h2>

You can install the development version of shinysurveys on from Github as follows:

``` {.r}
# Install/update shinysurveys with the development version from GitHub. 
# If devtools is not installed, uncomment the line below.
# install.packages("devtools")
devtools::install_github("jdtrat/shinysurveys")

# Load package
library(shinysurveys)
```

<h2 id="demos">

Demos

</h2>

A survey made with our package might look like this:

![](https://www.jdtrat.com/packages/shinysurveys/resources/shinysurveys-final-demo.gif)

You can run a demo survey with the function `shinysurveys::demo_survey()`.

<h2 id="getting-started">

Getting started

</h2>

Aside from `demo_survey()`, {shinysurveys} exports two functions: `surveyOutput()` and `renderSurvey()`. The former goes in the UI portion of a Shiny app, and the latter goes in the server portion. To create a survey, you can build a data frame with your questions. The following columns are required.

-   *question*: The question to be asked.
-   *option*: A possible response to the question. In multiple choice questions, for example, this would be the possible answers. For questions without discrete answers, such as a numeric input, this would be the default option shown on the input.
-   *input\_type*: What type of response is expected? Currently supported types include `numeric`, `mc` for multiple choice, `text`, `select`, and `y/n` for yes/no questions.
-   *input\_id*: The id for Shiny inputs.
-   *dependence*: Does this question (row) depend on another? That is, should it only appear if a different question has a specific value? This column contains the input\_id of whatever question this one depends upon.
-   *dependence\_value*: This column contains the specific value that the dependence question must take for this question (row) to be shown.
-   *required*: logical TRUE/FALSE signifying if a question is required. Surveys can only be submitted when all required questions are answered.

Our demo survey can be created as follows:

``` {.r}
library(shiny)
library(shinysurveys)

df <- data.frame(question = "What is your favorite food?",
                 option = "Your Answer",
                 input_type = "text",
                 input_id = "preferred_name",
                 dependence = NA,
                 dependence_value = NA,
                 required = F)

ui <- fluidPage(
  surveyOutput(df = df,
               survey_title = "Hello, World!",
               survey_description = "Welcome! This is a demo survey showing off the {shinysurveys} package.")
)

server <- function(input, output, session) {
  renderSurvey(input = input,
               output = output,
               session = session,
               df = df)
  
  observeEvent(input$submit, {
    
    showModal(modalDialog(
      title = "Congrats, you completed your first shinysurvey!",
      "You can customize what actions happen when a user finishes a survey using input$submit."
    ))
    
  })
  
}

shinyApp(ui, server)
```

<h2 id="advanced-surveys">

Advanced surveys

</h2>

{Documentation coming soon...}

<h2 id="further-reading">

Further reading

</h2>

For a more thorough explanation of shinysurveys functions, please see the vignette on the [official package website](https://jdtrat.com/packages/shinysurveys/)

<h2 id="feedback">

Feedback

</h2>

If you want to see a feature, or report a bug, please [file an issue](https://github.com/jdtrat/shinysurveys/issues) or open a [pull-request](https://github.com/jdtrat/shinysurveys/pulls)! As this package is just getting off the ground, we welcome all feedback and contributions.
