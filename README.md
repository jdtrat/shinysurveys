# shinysurveys

<!-- badges: start -->

[![R-CMD-check](https://github.com/jdtrat/shinysurveys/workflows/R-CMD-check/badge.svg)](https://github.com/jdtrat/shinysurveys/actions) [![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

<!-- badges: end -->

The goal of shinysurveys is to provide an easy to use framework for developing and deploying surveys in R.

## Installation

You can install the development version of shinysurveys on from Github as follows:

``` {.r}
# Install/update shinysurveys with the development version from GitHub. 
# If devtools is not installed, uncomment the line below.
# install.packages("devtools")
devtools::install_github("jdtrat/shinysurveys")

# Load package
library(shinysurveys)
```

## Example

To see a sample survey made using our package, run the following code:

``` {.r}
library(shinysurveys)
shinysurveys::demo_survey()
```
