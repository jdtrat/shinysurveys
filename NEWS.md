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
