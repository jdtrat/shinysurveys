# shinysurveys 0.1.1

-   Removed `dplyr`, `tidyr`, `rlang`, and `magrittr` dependencies.

# shinysurveys 0.1.0

## New Features

-   Addition of survey titles and description as arguments for `surveyOutput()`.
-   Theme parameter in `renderSurvey()`

## Bug fixes

-   For surveys with no required questions, error message involving unexpected `NULL` in `vec_slice_impl()` appeared.

## Minor Changes

-   Changed order of arguments in `renderSurvey()` to `c(df, input, output, session, theme)`.

# shinysurveys 0.0.0.9000

-   Publish initial development version.
