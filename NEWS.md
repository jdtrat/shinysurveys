# shinysurveys (development version)

## Minor improvements and fixes

- Made input checks more robust for required questions -- necessary for some custom input types (#32).

# shinysurveys 0.2.0

## Breaking changes

- Deprecated all arguments to `renderSurvey()`. Both the `df` and `theme` arguments should **only** be passed to `surveyOutput()`. A warning message appears if either argument is passed to `renderSurvey()`, though the code still works. This will truly be a breaking change in the next release of shinysurveys.

## New features

### Input Types

- Created `numerInput()`, which is identical to `shiny::numericInput()` but is more flexible in the sense that it **does not** require an initial value and it allows placeholders. This is now the default for "numeric" input questions.

- Created a shiny input, `radioMatrixInput()`, for matrix questions. It will return `NULL` until all possible response items have been answered, at which time a data frame with the 'question_id', 'question_type', and 'response' will be returned. 

- Added support for "matrix" input types using `radioMatrixInput()` for creating matrix blocks. [See the documentation for an example.](https://shinysurveys.jdtrat.com/articles/surveying-shinysurveys.html#matrix-input) 

- Added support for "instructions" 'input' types for use within other question types or standalone blocks.

- Added support for user-defined, custom input types. These can be registered with `extendInputType()`. For more details, see my [blog post](https://www.jdtrat.com/blog/extending-shinysurveys/) or [vignette](https://shinysurveys.jdtrat.com/articles/custom-input-extensions.html).

### Miscellaneous (but exciting!)

- Added support for multiple page surveys by adding a 'page' column to the data frame of questions supplied to `surveyOutput()`. The column can either have numeric `(e.g. c(1, 1, 2, 3))` or character values (`c("intro", "intro", "middle", "final")`). For more information, see my [blog post on multipaged shinysurveys](https://www.jdtrat.com/blog/multi-paged-shinysurvey/).

- Added support for aggregating response data with `getSurveyData()`. This feature allows you to automatically save responses for each individual. That is, this function accounts for dependencies; it will only aggregate data from questions a participant saw. It returns a data frame with a participant's ID, question (input) ID, the question type (e.g. numeric, text, etc.) and response. For more details, see ["Aggregate Responses with getSurveyData()"](https://shinysurveys.jdtrat.com/articles/get-survey-data.html).

## Minor improvements and fixes

- Fixed bug where required dependency questions prevented people from submitting the survey (since they could not "answer" hidden questions the submit button would not be enabled). 

- Added error messages to help with identifying common errors with creating surveys, specifically unrecognized input types.

- Removed "grid" CSS container surrounding the survey div. 

- Changed how SASS rendered the CSS internally to improve performance. CSS rules are placed within style tags in the DOM.

# shinysurveys 0.1.2

## Breaking Changes

-   The `renderSurvey()` function no longer takes shiny `input`, `output`, and `session`. Rather, it accesses them internally with the function `shiny::getDefaultReactiveDomain()`. Thanks to Dean Attali for the suggestion!

## Bug Fixes

-   Fixed survey appearance issues on smaller screens. Thanks to Paul Le Grand for the help!

## Minor Changes

-   Updated tests for server-side and internal functions

# shinysurveys 0.1.1

-   Removed `dplyr`, `tidyr`, `rlang`, and `magrittr` dependencies.

# shinysurveys 0.1.0

## New Features

-   Addition of survey titles and description as arguments for `surveyOutput()`.
-   Theme parameter in `renderSurvey()`

## Bug Fixes

-   For surveys with no required questions, error message involving unexpected `NULL` in `vec_slice_impl()` appeared.

## Minor Changes

-   Changed order of arguments in `renderSurvey()` to `c(df, input, output, session, theme)`.

# shinysurveys 0.0.0.9000

-   Publish initial development version.
