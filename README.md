
# shinysurveys

<!-- badges: start -->
[![GitHub version](https://badge.fury.io/gh/jdtrat%2Fshinysurveys.svg)](https://badge.fury.io/gh/jdtrat%2Fshinysurveys)
[![R-CMD-check](https://github.com/jdtrat/shinysurveys/workflows/R-CMD-check/badge.svg)](https://github.com/jdtrat/shinysurveys/actions)
<!-- badges: end -->

The goal of shinysurveys is to provide an easy to use framework for developing and deploying surveys in R. 

## Installation

You can install the development version of shinysurveys on from Github as follows:

``` r
# Install/update shinysurveys with the development version from GitHub. 
# If devtools is not installed, uncomment the line below.
# install.packages("devtools")
devtools::install_github("jdtrat/shinysurveys")

# Load package
library(shinysurveys)
```

## Example

To see a sample survey made using our package, run the following code:

``` r
library(shinysurveys)
shinysurveys::demo_survey()
```

