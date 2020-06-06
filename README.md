
<!-- README.md is generated from README.Rmd. Please edit that file -->

# overviewR <img src='man/figures/logo.png' align="right" height="139" />

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/cosimameyer/overviewR.svg?branch=master)](https://travis-ci.com/cosimameyer/overviewR)
<!-- badges: end -->

The goal of overviewR makes it easy to get an overview of your data by
displaying your sample information. At the moment, you have two
functions (`overview_tab` and `overview_crosstab`) that allow you to
generate a tabular overview of your general sample and conditional
sample. `overview_print` then converts this output to nicely usable tex
code.

## Installation

You can install the released version of overviewR from
[github](https://github.com/cosimameyer/overviewR) with:

``` r
library(devtools)
devtools::install_github("cosimameyer/overviewR")
```

<!--[CRAN](https://CRAN.R-project.org) with:
``` r
install.packages("overviewR")
```
-->

## Example

This is a basic example which shows you how to solve a common problem:

``` r
# Generate some data
set.seed(68163)

countries <-
  c(rep("RWA", 4), rep("AGO", 8), rep("BEN", 2), rep("UK", 5)) # This vector is consists of characters
years <-
  c(seq(1990, 1995),
    seq(1990, 1992),
    seq(1995, 1999),
    seq(1991, 1999, by = 2)) # This vector is numeric
gdp <-
  runif(19, 10000, 40000) # Add a numeric vector for additional data (randomly generated)
population <-
  runif(19, 100, 50000)# Add another numeric vector for additional data (randomly generated)
# Combine vectors to a data frame
df_combined <-
  data.frame(countries, years, gdp, population, stringsAsFactors = FALSE)
```

Let’s have a first look at the data:

``` r
head(df_combined)
```

Load the package

``` r
library(overviewR)
```

### `overview_tab`

Generate some general overview using `overview_tab`.

``` r
overview_tab(dat = df_combined, id = countries, time = years)
```

This function automatically generates an object and stores it in your
environment so that you can access it later.

### `overview_crosstab`

If you want to generate a cross table that divides our data
conditionally on two factors, this can be done with `overview_crosstab`.

``` r
overview_crosstab(
    dat = df_combined,
    cond1 = gdp,
    cond2 = population,
    threshold1 = 30000,
    threshold2 = 15000,
    id = countries,
    time = years
  )
```

The resulting data frame is again stored as an object in your
environment so that you can access it later.

### `overview_print`

To generate an easily usable output, `overviewR` offers the function
`overview_print`.

<!--
What is special about using `README.Rmd` instead of just `README.md`? You can include R chunks like so:


```r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don't forget to commit and push the resulting figure files, so they display on GitHub!
-->
