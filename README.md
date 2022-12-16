
# overviewR <img src='man/figures/logo.png' align="right" height="139" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/cosimameyer/overviewR/workflows/R-CMD-check/badge.svg)](https://github.com/cosimameyer/overviewR/actions)
[![Codecov test
coverage](https://codecov.io/gh/cosimameyer/overviewR/branch/master/graph/badge.svg)](https://app.codecov.io/gh/cosimameyer/overviewR?branch=master)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/overviewR)](https://cran.r-project.org/package=overviewR)
[![license](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![metacran downloads](https://cranlogs.r-pkg.org/badges/overviewR)](https://cran.r-project.org/package=overviewR)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![overviewR badge](https://img.shields.io/badge/overviewR-ready%20to%20use-brightgreen)](https://github.com/cosimameyer/overviewR)
[![R badge](https://img.shields.io/badge/Build%20with-♥%20and%20R-blue)](https://github.com/cosimameyer/overviewR)
[![DOI](https://joss.theoj.org/papers/10.21105/joss.04740/status.svg)](https://doi.org/10.21105/joss.04740)

<!--<a href="https://diffify.com/R/overviewR" target="_blank"><img src="https://img.shields.io/static/v1?label=&amp;message=Diffify&amp;labelColor=black&amp;color=black&amp;style=flat-square&amp;logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDI3LjAuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzkiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IgoJIHZpZXdCb3g9IjAgMCAxMDI1LjUgNjA0LjIiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDEwMjUuNSA2MDQuMjsiIHhtbDpzcGFjZT0icHJlc2VydmUiPgo8c3R5bGUgdHlwZT0idGV4dC9jc3MiPgoJLnN0MHtvcGFjaXR5OjAuNDkwMjtmaWxsOiNGQzcyN0E7ZW5hYmxlLWJhY2tncm91bmQ6bmV3ICAgIDt9Cgkuc3Qxe2ZpbGw6bm9uZTtzdHJva2U6I0ZDNzI3QTtzdHJva2Utd2lkdGg6MzA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS1taXRlcmxpbWl0OjEwO30KCS5zdDJ7ZmlsbDpub25lO3N0cm9rZTojRkM3MjdBO3N0cm9rZS13aWR0aDo0NztzdHJva2UtbWl0ZXJsaW1pdDoxMDt9Cgkuc3Qze29wYWNpdHk6MC40MzE0O2ZpbGw6I0ExRTgyQztlbmFibGUtYmFja2dyb3VuZDpuZXcgICAgO30KCS5zdDR7ZmlsbDpub25lO3N0cm9rZTojQTFFODJDO3N0cm9rZS13aWR0aDozMDtzdHJva2UtbGluZWNhcDpyb3VuZDtzdHJva2UtbGluZWpvaW46cm91bmQ7c3Ryb2tlLW1pdGVybGltaXQ6MTA7fQoJLnN0NXtmaWxsOm5vbmU7c3Ryb2tlOiNBMUU4MkM7c3Ryb2tlLXdpZHRoOjQ3O3N0cm9rZS1taXRlcmxpbWl0OjEwO30KPC9zdHlsZT4KPGcgaWQ9IkxheWVyXzlfY29weSI+Cgk8ZyBpZD0iTGF5ZXJfNyI+CgkJPHBhdGggY2xhc3M9InN0MCIgZD0iTTUxMS4zLDM3OS43Yy0wLjYtMTMuNi0xLjItMjcuMywwLjItNDFjLTIuMS0zLjMtNS01LjctOC4xLThjLTEuOS02LjQtMi4zLTEyLjUsMC0xOC44CgkJCWMxLjgtOC40LDIuOC0xNy4xLDMuNC0yNS43YzEuMi0yMiwxLjYtNDQuNC0zLjgtNjUuOWM2LjMtNS4zLDkuNi0xNC4xLDkuNi0yMi4xYy0xOS43LTkuMi0zOC42LTIwLjgtNTMuNC0zNi45CgkJCWMtOS4zLTMuOS0xOC4yLTguOC0yNy4yLTEzLjRjLTEsMC4yLTIsMC40LTMsMC41Yy00LjMtMi40LTguOS0zLjYtMTMuNy00Yy0xLjgtMS40LTMuNS0yLjktNS40LTQuMmMtMC42LTEuNi0xLjMtMy4xLTIuMS00LjYKCQkJYy05LjYtNi41LTIwLjQtMTAuMi0zMC4yLTE2LjRjLTAuNywyLjMtMy4zLDIuOS01LjUsMS41djBjLTguOS00LjEtMTYuOS0xMC4xLTI1LjYtMTQuN2MtMC4xLDAtMC4yLDAtMC4zLDAKCQkJYy0xLjktMS41LTQuMi0yLjYtNi40LTMuN2MwLTAuMS0wLjEtMC4xLTAuMS0wLjJjLTcuMi00LjgtMTUuMi04LjUtMjIuMi0xMy43Yy0yMi4yLDAuNi00MS43LDE0LjMtNjAuNywyNC40YzAsMCwwLjEtMC4xLDAuMS0wLjEKCQkJYy0xMS41LDYuNy0yMy41LDEyLjgtMzUuOCwxNy45Yy0xNS41LDguMi0zNi4xLDExLTQ1LjQsMjcuNGMtNS4zLDEuOC0xMC4yLDQuNi0xNC45LDcuNGMtMi4zLTEuNC01LTIuMy03LjctMi42CgkJCWMtMTguNywxMC45LTM3LjMsMjItNTUuOSwzMy4xYy0xLjksMTUuNC00LjcsMzAuNy01LjYsNDYuMmMtMC45LDYuNSwyLjIsMTcuMy0xLjcsMjIuNGMwLjMsMTAuMywzLjgsMjAuMyw3LjMsMjkuOQoJCQljLTEuOCwxMC45LTIuMywyMi4xLTEuNCwzMy4xYy0xLjEsMTAuNC0wLjYsMjEsMi41LDMxYy0yLjMsMi40LTQuMiw1LjItNi4xLDhjMC45LDE0LjQsMSwyOC44LTAuNCw0My4yCgkJCWM0LjYsNy40LDEwLjMsMTQuNywxOC45LDE3LjVjNS43LDUuMiwxMi42LDguNSwxOS43LDExLjNjMC4xLDAuMSwwLjEsMC4yLDAuMiwwLjNjNDUuMywyMi4xLDg4LjMsNDcuNCwxMzQuNyw2Ny4xCgkJCWMwLjktMC40LDEuOC0wLjgsMi43LTEuMmMwLjgsMS4yLDEuOCwyLjMsMi41LDMuNmMxMS4yLDUuOSwyMy41LDkuNCwzNC40LDE1LjljMTcuNi03LjMsMzQuNy0xNS42LDUxLjgtMjQKCQkJYzEuMy0yLjMsMi4yLTQuNywyLjctNy4yYzcuMy0wLjQsMTMuNy0zLjcsMjAuMS03YzE3LjQtMS42LDMxLjEtMTUuMyw0Ni4xLTIzLjRjMTUuOC05LjgsMzIuMS0xOC44LDQ4LjEtMjguMwoJCQljMTguMSwwLjQsMzMuNy0xMy4yLDM3LjktMzAuNkM1MTEuMywzOTYuMSw1MTEuNCwzODcuNiw1MTEuMywzNzkuN3oiLz4KCQk8ZyBpZD0iTGF5ZXJfMl9jb3B5Ij4KCQkJPHBvbHlnb24gY2xhc3M9InN0MSIgcG9pbnRzPSI5MS41LDQxNC44IDkwLjksMTk0LjYgMzAwLjEsODUuNSAzOTguNiwxMzcuNCA1MDguMywxOTQgNTA4LjEsNDE1LjEgMzAwLjEsNTIxLjkgCQkJIi8+CgkJCTxwb2x5Z29uIGNsYXNzPSJzdDEiIHBvaW50cz0iMzAwLjEsMzA0LjYgMTkxLjEsMjQ2LjggOTEuNSwxOTQgCQkJIi8+CgkJCTxwb2x5bGluZSBjbGFzcz0ic3QxIiBwb2ludHM9IjQ5Ny4xLDIwMi4xIDMwMC4xLDMwNC42IDMwMC4xLDUwMy4zIAkJCSIvPgoJCQk8ZyBpZD0iTGF5ZXJfM19jb3B5Ij4KCQkJCTxwYXRoIGNsYXNzPSJzdDIiIGQ9Ik0xOTUuOCwyNDkuM2wyMDIuOC0xMTEuOUwxOTUuOCwyNDkuM3oiLz4KCQkJPC9nPgoJCTwvZz4KCQk8ZyBpZD0iTGF5ZXJfOCI+CgkJCTxwYXRoIGNsYXNzPSJzdDMiIGQ9Ik05NTkuMywzODEuNGMtMS4yLTguNy0wLjctMTguNS02LjEtMjUuOWMtMS4yLTIxLjQsMC44LTQzLTItNjQuM2MtMS4xLTIyLDIuMy00NC4zLTEtNjYKCQkJCWM5LjctMjQuNy0yLjQtNTMuNS0zMS4yLTU0Yy0xNC43LTguMS0zMC45LTE0LjEtNDcuNy0xNmMtNi44LTQuNC0xNC4zLTguNS0yMi42LTguMmMtMC44LTAuNy0xLjUtMS4zLTIuMy0yCgkJCQljLTMtMjQuOS00My43LTQ0LjYtNjYuNC00NC4yYy0xMy4xLTExLjctMzEtMTYtNDguMi0xMi4yYy0xMi4xLDMuMi0yMC44LDEyLjUtMzAuNCwxOS44Yy0zMi4yLDEyLjYtNjEuNiwzMS04OC43LDUyLjgKCQkJCWMtMTcuMi0zLjYtMzEuOCw4LjctNDMuNywxOS42Yy0zNi4zLTEuOC00MC42LDQzLjgtMzYuNSw3MC44YzAuOCwxMS4zLTEuNCwyMy42LDQuNywzMy44Yy0wLjEsMTIuOS0zLjQsMjYuNiwxLjcsMzguOQoJCQkJYy0zLjMsMTMtMC40LDI2LjYtMi4zLDM5LjZjLTUuNCwyMy00LjksNDcuNCwxNi45LDYxLjhjNy45LDcuMSwxOS40LDUuNywyNi44LDEzLjFjOS42LDkuNSwyMi45LDguMiwzNC45LDEwLjkKCQkJCWM3LjUsMTEuNCwxNywyMi4zLDI5LjksMjcuM2M4LjksMywxNy40LTEuNSwyNi4yLTIuM2M5LjUsMTcsMjUuMSwyOC4yLDQyLjUsMzUuOGMxMywxMi44LDM1LjMsMTYsNDYuOS0wLjIKCQkJCWMyMS44LDUuOSwzNy44LTExLjksNTMuNC0yNGMxNC42LDUsMjYuNy02LjgsMzcuOS0xNC41YzE3LjItMTIuMiwzNi4yLTIxLjQsNTIuOS0zNC4zYzE5LjYsMTAuMSwzMi44LTguMiw0NS44LTE5LjkKCQkJCUM5NjAuMSw0MDguMiw5NTkuNSwzOTMuOSw5NTkuMywzODEuNHoiLz4KCQkJPGcgaWQ9IkxheWVyXzJfMDAwMDAxNjU5Mjk1NDE0Mzk0NTU0Njk3OTAwMDAwMTU0NjA5MDQwNjEwMzY2MTczNTVfIj4KCQkJCTxwb2x5Z29uIGNsYXNzPSJzdDQiIHBvaW50cz0iNTM4LDQxNC44IDUzNy41LDE5NC42IDc0Ni42LDg1LjUgODQ1LjIsMTM3LjQgOTU0LjksMTk0IDk1NC42LDQxNS4xIDc0Ni42LDUyMS45IAkJCQkiLz4KCQkJCTxwb2x5Z29uIGNsYXNzPSJzdDQiIHBvaW50cz0iNzQ2LjYsMzA0LjYgNjM3LjYsMjQ2LjggNTM4LDE5NCAJCQkJIi8+CgkJCQk8cG9seWxpbmUgY2xhc3M9InN0NCIgcG9pbnRzPSI5NDMuNywyMDIuMSA3NDYuNiwzMDQuNiA3NDYuNiw1MDMuMyAJCQkJIi8+CgkJCQk8ZyBpZD0iTGF5ZXJfMyI+CgkJCQkJPHBhdGggY2xhc3M9InN0NSIgZD0iTTY0Mi4zLDI0OS4zbDIwMi44LTExMS45TDY0Mi4zLDI0OS4zeiIvPgoJCQkJPC9nPgoJCQk8L2c+CgkJPC9nPgoJPC9nPgo8L2c+Cjwvc3ZnPgo=" alt="The Diffify page for the R package overviewR" style="width: 100px; max-width: 100%;"></a>-->
<!-- [![Rdoc](https://www.rdocumentation.org/badges/version/overviewR)](https://www.rdocumentation.org/packages/overviewR) -->
<!-- [![cran checks](https://cranchecks.info/badges/summary/overviewR)](https://cran.r-project.org/web/checks/check_results_overviewR.html) -->
<!-- [![](https://cranlogs.r-pkg.org/badges/version/overviewR)](https://www.r-pkg.org/badges/version/overviewR) -->
<!-- [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) -->
<!-- [![Last-changedate](https://img.shields.io/badge/last%20change-2022--09--12-green.svg)](/commits/master) -->
<!-- badges: end -->

[**You can access the CheatSheet for overviewR
here**](https://github.com/cosimameyer/overviewR/blob/master/man/figures/CheatSheet_overviewR.pdf)

The goal of overviewR is to make it easy to get an overview of a data
set by displaying relevant sample information. At the moment, there are
the following functions:

-   `overview_tab` generates a tabular overview of the sample. The
    general sample plots a two-column table that provides information on
    an id in the left column and a the time frame on the right column.
-   `overview_crosstab` generates a cross table. The conditional column
    allows to disaggregate the overview table by specifying two
    conditions, hence resulting a 2x2 table. This way, it is easy to
    visualize the time and scope conditions as well as theoretical
    assumptions with examples from the data set.
-   `overview_latex` converts the output of both `overview_tab` and
    `overview_crosstab` into LaTeX code and/or directly into a .tex
    file.
-   `overview_plot` is an alternative to visualize the sample (a way to
    present results from `overview_tab`)
-   `overview_crossplot` is an alternative to visualize a cross table (a
    way to present results from `overview_crosstab`)
-   `overview_heat` plots a heat map of your time line
-   `overview_na` plots an overview of missing values by variable (both
    by row and by column)
-   `overview_overlap` plots comparison plots (bar graph and Venn
    diagram) to compare to data frames

The plots can be saved using the `ggsave()` command. The output of
`overview_tab` and `overview_crosstab` are also compatible with other
packages such as [`xtable`](https://CRAN.R-project.org/package=xtable),
[`flextable`](https://CRAN.R-project.org/package=flextable), or
[`knitr`](https://bookdown.org/yihui/rmarkdown-cookbook/kable.html).

We present a short step-by-step guide as well as the functions in more
detail below.

## Installation

A stable version of `overviewR` can be directly accessed on CRAN:

``` r
install.packages("overviewR", force = TRUE)
```

To install the latest development version of `overviewR` directly from
[GitHub](https://github.com/cosimameyer/overviewR) use:

``` r
library(devtools) # Tools to Make Developing R Packages Easier # Tools to Make Developing R Packages Easier
devtools::install_github("cosimameyer/overviewR")
```

## Example

First, load the package.

``` r
library(overviewR) # Easily Extracting Information About Your Data # Easily Extracting Information About Your Data
```

The following examples use a toy data set (`toydata`) that comes with
the package. This data contains artificially generated information in a
cross-sectional format on 5 countries, covering the period 1990-1999.

``` r
data(toydata)
head(toydata)
#>   ccode year month      gdp population day
#> 1   RWA 1990   Jan 24180.77  14969.988   1
#> 2   RWA 1990   Jan 23650.53  11791.464   2
#> 3   RWA 1990   Jan 21860.14  30047.979   3
#> 4   RWA 1990   Jan 20801.06  19853.556   4
#> 5   RWA 1990   Jan 18702.84   5148.118   5
#> 6   RWA 1990   Jan 30272.37  48625.140   6
```

<!-- ``` -->
<!--     ccode   year   month  gdp       population -->
<!--     RWA     1990   Jan    24180.77  14969.988 -->
<!--     RWA     1990   Feb    23650.53  11791.464 -->
<!--     RWA     1990   Mar    21860.14  30047.979 -->
<!--     RWA     1990   Apr    20801.06  19853.556 -->
<!--     RWA     1990   May    18702.84   5148.118 -->
<!--     RWA     1990   Jun    30272.37  48625.140 -->
<!-- ``` -->

There are 264 observations for 5 countries (Angola, Benin, France,
Rwanda, and UK) stored in the `ccode` variable, over a time period
between 1990 to 1999 (`year`) with additional information for the month
(`month`). Additionally, two artificially generated fake variables for
GDP (`gdp`) and population size (`population`) are included to
illustrate of conditions.

The following functions work best on data sets that have an
id-time-structure, in the case of `toydata` this corresponds to
country-year with `ccode` and `year`. If the data set does not have this
format yet, consider using [`pivot_wider()` or
`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html)
to get to the format.

### `overview_tab`

Generate some general overview of the data set using the time and scope
conditions with `overview_tab`.

``` r
output_table <- overview_tab(dat = toydata, id = ccode, time = year)
```

The resulting data frame collapses the time condition for each id by
taking into account potential gaps in the time frame. Note that the
column name for the time frame is set by default to `time_frame` and
internally generated when using `overview_tab`.

``` r
output_table
```

    # ccode   time_frame
    # RWA       1990 - 1995
    # AGO       1990 - 1992
    # BEN       1995 - 1999
    # GBR       1991, 1993, 1995, 1997, 1999
    # FRA       1993, 1996, 1999

### Multiple time arguments

As of overviewR version 0.0.7 you can also use multiple time objects in
`overview_tab`. You can now pass a list containing multiple time
variables with the following format:
`time = list(year = NULL, month = NULL, day = NULL)`.

``` r
output_table_complex <- overview_tab(dat = toydata, id = ccode, time = list(year = toydata$year,
             month = toydata$month, day = toydata$day), complex_date = TRUE)
```

The resulting data frame collapses again the time condition for each id
by taking into account potential gaps in the time frame. Note that the
column name for the time frame is set by default to `time_frame` and
internally generated when using `overview_tab`. The output resembles
something like this:

``` r
output_table_complex
```

     ccode time_frame                                                                                                      # AGO   1990-01-01, 1990-02-02, 1990-03-03, 1990-04-04, 1990-05-05, 1990-06-06, ...
    # BEN   1995-01-01, 1995-02-02, 1995-03-03, 1995-04-04, 1995-05-05, 1995-06-06, ...
    # FRA   1993-01-01, 1993-02-02, 1993-03-03, 1993-04-04, 1993-05-05, 1993-06-06, ...
    # GBR   1991-01-01, 1991-02-02, 1991-03-03, 1991-04-04, 1991-05-05, 1991-06-06, ...
    # RWA   1990-01-01 - 1990-01-12, 1991-01-01 - 1991-01-12, 1992-01-01 - 1992-01-12, 1993-01-01 - 1993-01-12, 1994-01-01 

### `overview_crosstab`

To generate a cross table that divides the data based on two conditions,
for instance GDP and population size, `overview_crosstab` can be used.
`threshold1` and `threshold2` thereby indicate the cut point for the two
conditions (`cond1` and `cond2`), respectively.

``` r
output_crosstab <- overview_crosstab(
  dat = toydata,
  cond1 = gdp,
  cond2 = population,
  threshold1 = 25000,
  threshold2 = 27000,
  id = ccode,
  time = year
)
```

The data frame output looks as follows:

    #   part1                                      part2
    # 1 AGO (1990, 1992), FRA (1993), GBR (1997)   BEN (1996, 1999), FRA (1999), GBR (1993), RWA (1992, 1994)
    # 2 BEN (1997), RWA (1990)                     AGO (1991), BEN (1995, 1998), FRA (1996), GBR (1991, 1995, 1999), RWA (1991, 1993, 1995)

Note, if a data set is used that has multiple observations on the
id-time unit, the function automatically aggregates the data set using
the mean of condition 1 (`cond1`) and condition 2 (`cond2`).

### `overview_latex`

> With overviewR v 0.0.11.999 we introduced `overview_latex` instead of
> `overview_print`

To generate an easily usable LaTeX output for the generated
`overview_tab` and `overview_crosstab` objects, `overviewR` offers the
function `overview_latex`. The following illustrate this using the
`output_table` object from `overview_tab`.

``` r
overview_latex(obj = output_table)
```

<details>
<summary>
LaTeX output
</summary>

    % Overview table generated in R version 4.0.0 (2020-04-24) using overviewR 
    % Table created on 2020-06-21
    \begin{table}[ht] 
     \centering 
     \caption{Time and scope of the sample} 
     \begin{tabular}{ll} 
     \hline 
    Sample & Time frame \\ 
    \hline 
     RWA & 1990 - 1995 \\ 
     AGO & 1990 - 1992 \\ 
     BEN & 1995 - 1999 \\ 
     GBR & 1991, 1993, 1995, 1997, 1999 \\ 
     FRA & 1993, 1996, 1999 \\ 
     \hline 
     \end{tabular} 
     \end{table}

</details>
<p align="center">
<img src='man/figures/ex1.png' height="150"/>
</p>

The default already provides a title (“Time and scope of the sample”)
that can be modified in the argument `title`. The same holds for the
column names (“Sample” and “Time frame” are set by default but can be
modified as shown below).

``` r
overview_latex(
  obj = output_table,
  id = "Countries",
  time = "Years",
  title = "Cool new title for our awesome table"
)
```

<details>
<summary>
LaTeX output
</summary>

    % Overview table generated in R version 4.0.0 (2020-04-24) using overviewR 
    % Table created on 2020-06-21
    \begin{table}[ht] 
     \centering 
     \caption{Cool new title for our awesome table} 
     \begin{tabular}{ll} 
     \hline 
    Countries & Years \\ 
    \hline 
     RWA & 1990 - 1995 \\ 
     AGO & 1990 - 1992 \\ 
     BEN & 1995 - 1999 \\ 
     GBR & 1991, 1993, 1995, 1997, 1999 \\ 
     FRA & 1993, 1996, 1999 \\ 
     \hline 
     \end{tabular} 
     \end{table} 

</details>
<p align="center">
<img src='man/figures/ex2.png' height="150"/>
</p>

The same function can also be used for outputs from the
`overview_crosstab` function by using the argument `crosstab = TRUE`.
There are also options to label the respective conditions (`cond1` and
`cond2`). Note that this should correspond to the conditions (`cond1`
and `cond2`) specified in the `overview_crosstab` function.

``` r
overview_latex(
  obj = output_crosstab,
  title = "Cross table of the sample",
  crosstab = TRUE,
  cond1 = "GDP",
  cond2 = "Population"
)
```

<details>
<summary>
LaTeX output
</summary>

    % Overview table generated in R version 4.0.0 (2020-04-24) using overviewR 
    % Table created on 2020-06-21
    % Please add the following packages to your document preamble: 
    % \usepackage{multirow} 
    % \usepackage{tabularx} 
    % \newcolumntype{b}{X} 
    % \newcolumntype{s}{>{\hsize=.5\hsize}X} 
    \begin{table}[ht] 
    \caption{Cross table of the sample} 
     \begin{tabularx}{\textwidth}{ssbb} 
    \hline & & \multicolumn{2}{c}{\textbf{GDP}} \\ 
     & & \textbf{Fulfilled} & \textbf{Not fulfilled} \\ 
     \hline \\ 
     \multirow{2}{*}{\textbf{Population}} & \textbf{Fulfilled} & 
     AGO (1990, 1992), FRA (1993), GBR (1997) & BEN (1996, 1999), FRA (1999), GBR (1993), RWA (1992, 1994)\\  
     \\ \hline \\ 
     & \textbf{Not fulfilled} &  BEN (1997), RWA (1990) & AGO (1991), BEN (1995, 1998), FRA (1996), GBR (1991, 1995, 1999), RWA (1991, 1993, 1995)\\  \hline \\ 
     \end{tabularx} 
     \end{table} 

</details>
<p align="center">
<img src='man/figures/ex3.png' height="200"/>
</p>

`overview_latex` further allows more specifications such as the font
size or a a label. *These functions are currently supported only in the
development version of the package.*

``` r
overview_latex(obj = output_table,
               fontsize = "scriptsize",
               label = "tab:overview")
```

With `save_out = TRUE` the function exports the output as a `.tex` file
and stores it on the device.

``` r
overview_latex(
  obj = output_table,
  save_out = TRUE,
  file_path = "SET-YOUR-PATH/output.tex"
)
```

### `overview_plot`

In addition to tables, `overviewR` also provides plots to illustrate the
structure of your data. `overview_plot` illustrates the information that
is generated in `overview_table` in a ggplot graphic. All scope objects
(e.g., countries) are listed on the y-axis where horizontal lines
indicate the coverage across the entire time frame of the data (x-axis).
This helps to spot gaps in the data for specific scope objects and
outlines at what time point they occur.

``` r
data(toydata)
overview_plot(dat = toydata, id = ccode, time = year)
```

<img src="man/figures/unnamed-chunk-22-1.png" width="50%" style="display: block; margin: auto;" />

The results are sorted alphabetically by default. The order can also be
reversed by setting `asc` to `FALSE`.

``` r
library(magrittr) # A Forward-Pipe Operator for R

overview_plot(
  dat = toydata,
  id = ccode,
  time = year,
  asc = FALSE
)
```

<img src="man/figures/unnamed-chunk-23-1.png" width="50%" style="display: block; margin: auto;" />

There is also an option to color the time lines conditionally. Here, we
introduce a dummy variable that indicates whether the year was before
1995 or not. We use this dummy to color the time lines using the `color`
argument.

``` r
# Code whether a year was before 1995
toydata <- toydata %>%
  dplyr::mutate(before = ifelse(year < 1995, 1, 0))

# Plot using the `color` argument
overview_plot(
  dat = toydata,
  id = ccode,
  time = year,
  color = before
)
```

<img src="man/figures/unnamed-chunk-24-1.png" width="50%" style="display: block; margin: auto;" />

The development version also allows to change the dot size using the
`dot_size` argument. The default is “2”.

``` r
# Plot using the `color` argument
overview_plot(
  dat = toydata,
  id = ccode,
  time = year,
  dot_size = 5
)
```

<p align="center">
<img src='man/figures/dot.png' height="400"/>
</p>

### `overview_crossplot`

To visualize also the cross table, `overview_crossplot` does the job.

``` r
overview_crossplot(
  toydata,
  id = ccode,
  time = year,
  cond1 = gdp,
  cond2 = population,
  threshold1 = 25000,
  threshold2 = 27000,
  color = TRUE,
  label = TRUE
)
```

<img src="man/figures/unnamed-chunk-26-1.png" width="50%" style="display: block; margin: auto;" />

### `overview_heat`

`overview_heat` takes a closer look at the time and scope conditions by
visualizing the data coverage for each time and scope combination in a
ggplot heat map. This function is best explained using an example.
Suppose you have a dataset with monthly data for different countries and
want to know if data is available for each country in every month.
`overview_heat` intuitively does this by plotting a heat map where each
cell indicates the coverage for that specific combination of time and
scope (e,g., country-year). As illustrated below, the darker the cell
is, the more coverage it has. The plot also indicates the relative or
absolute coverage of each cell. For instance, Angola (“AGO”) in 1991
shows the coverage of 75%. This means that of all potential 12 months of
coverage (12 months for one year), only 9 are covered.

For this purpose, we first artificially reduced the `toydata`.

``` r
toydata_red <- toydata[-sample(seq_len(nrow(toydata)), 64),]
```

``` r
overview_heat(toydata_red,
              ccode,
              year,
              perc = TRUE,
              exp_total = 12)
```

<img src="man/figures/unnamed-chunk-28-1.png" width="50%" style="display: block; margin: auto;" />

### `overview_na`

`overview_na` is a simple function that provides information about the
content of all variables in your data, not only the time and scope
conditions. It returns a horizontal ggplot bar plot that indicates the
amount of missing data (NAs) for each variable (on the y-axis). You can
choose whether to display the relative amount of NAs for each variable
in percentage (the default) or the total number of NAs.

For this purpose, we first artificially reduced our `toydata`.

``` r
toydata_with_na <- toydata %>%
  dplyr::mutate(
    year = ifelse(year < 1992, NA, year),
    month = ifelse(month %in% c("Jan", "Jun", "Aug"), NA, month),
    gdp = ifelse(gdp < 20000, NA, gdp)
  )
```

``` r
overview_na(toydata_with_na)
```

<img src="man/figures/unnamed-chunk-30-1.png" width="50%" style="display: block; margin: auto;" />

``` r
overview_na(toydata_with_na, perc = FALSE)
```

<img src="man/figures/unnamed-chunk-31-1.png" width="50%" style="display: block; margin: auto;" />

### `overview_overlap`

This function allows to compare two data sets. We are currently working
on an extended version that allows comparing \>2 data sets.

At the current development stage, the function works as follows:

``` r
library(dplyr)

# Subset one data set for comparison
toydata2 <- toydata %>% dplyr::filter(year > 1992)

overview_overlap(
  dat1 = toydata,
  dat2 = toydata2,
  dat1_id = ccode,
  dat2_id = ccode,
  plot_type = "bar" # This is the default
)
#> Joining, by = "ccode"
#> Warning: Removed 1 rows containing missing values (geom_bar).
```

<img src="man/figures/unnamed-chunk-32-1.png" width="50%" style="display: block; margin: auto;" />

<!--<p align="center">
<img src='man/figures/bar.png' height="400"/>
</p>-->

Or a Venn diagram

``` r
overview_overlap(
  dat1 = toydata,
  dat2 = toydata2,
  dat1_id = ccode,
  dat2_id = ccode,
  plot_type = "venn"
)
```

<img src="man/figures/unnamed-chunk-33-1.png" width="50%" style="display: block; margin: auto;" />

<!--<p align="center">
<img src='man/figures/venn.png' height="400"/>
</p>
-->

## Compatibilities with other packages

### Presenting tables: `flextable`, `xtable`, and `kable`

The outputs of `overview_tab` and `overview_crosstab` are also
compatible with other functions such as
[`xtable`](https://CRAN.R-project.org/package=xtable),
[`flextable`](https://CRAN.R-project.org/package=flextable), or
[`kable`](https://bookdown.org/yihui/rmarkdown-cookbook/kable.html) from
[`knitr`](https://yihui.org/knitr/).

Two examples are shown below:

``` r
library(flextable) # not installed on this machine
table_output <- qflextable(output_table)
table_output <-
  set_header_labels(table_output,
                    ccode = "Countries",
                    time_frame = "Time frame")
set_table_properties(table_output,
                     width = .4,
                     layout = "autofit")
```

``` r
library(knitr) # A General-Purpose Package for Dynamic Report Generation in R
knitr::kable(output_table)
```

| ccode | time_frame                   |
|:------|:-----------------------------|
| RWA   | 1990-1995                    |
| AGO   | 1990-1992                    |
| BEN   | 1995-1999                    |
| GBR   | 1991, 1993, 1995, 1997, 1999 |
| FRA   | 1993, 1996, 1999             |

### Customizing plots: `ggplot2` and other packages

The plot functions are fully `ggplot2` based. While a theme is
pre-defined, this can easily be overwritten.

A classical `ggplot2` theme alternative

``` r
library(ggplot2) # Create Elegant Data Visualisations Using the Grammar of Graphics

overview_na(toydata_with_na) +
  ggplot2::theme_minimal() 
```

<img src="man/figures/unnamed-chunk-37-1.png" width="50%" style="display: block; margin: auto;" />

### Workflow: `tidyverse`

All functions are further easily accessible using a common `tidyverse`
workflow. Here are just three examples – the possibilities are endless.

Using a filter function

``` r
library(dplyr) # A Grammar of Data Manipulation # A Grammar of Data Manipulation

toydata_with_na %>%
  dplyr::filter(year > 1993) %>%
  overview_na()
```

<img src="man/figures/unnamed-chunk-38-1.png" width="50%" style="display: block; margin: auto;" />

Using mutate to generate meaningful country names

``` r
library(countrycode) # Convert Country Names and Country Codes
library(dplyr) # A Grammar of Data Manipulation # A Grammar of Data Manipulation

toydata %>%
  # Transform the country code (ISO3 character code) into a country name using the `countrycode` package
  dplyr::mutate(country = countrycode::countrycode(ccode, "iso3c", "country.name")) %>%
  overview_plot(id = country, time = year)
```

<img src="man/figures/unnamed-chunk-39-1.png" width="50%" style="display: block; margin: auto;" />

Using different `overviewR` functions after each other to generate a
workflow

``` r
# Produces a printable LaTeX output
toydata %>%
  overview_tab(id = ccode, time = year) %>%
  overview_latex()
```

    % Overview table generated in R version 4.0.2 (2020-06-22) using overviewR 
    % Table created on 2020-12-30
    \begin{table}[ht] 
     \centering 
     \caption{Time and scope of the sample} 
    \label{tab:tab1} 

    \begin{tabular}{ll} 
     \hline 
    Sample & Time frame \\ 
    \hline 
     AGO & 1990 - 1992 \\ 
     BEN & 1995 - 1999 \\ 
     FRA & 1993, 1996, 1999 \\ 
     GBR & 1991, 1993, 1995, 1997, 1999 \\ 
     RWA & 1990 - 1995 \\ 
     \hline 
     \end{tabular} 
     \end{table} 

## Overview of functional add-ons

|                      | Works with `data.frame` objects | Works with `data.table` | Can take multiple time arguments (year, month, day) |
|----------------------|---------------------------------|-------------------------|-----------------------------------------------------|
| `overview_tab`       | ✓                               | ✓                       | ✓                                                   |
| `overview_na`        | ✓                               | ✓                       |                                                     |
| `overview_plot`      | ✓                               |                         |                                                     |
| `overview_crossplot` | ✓                               |                         |                                                     |
| `overview_crosstab`  | ✓                               |                         |                                                     |
| `overview_heat`      | ✓                               |                         |                                                     |
| `overview_overlap`   | ✓                               |                         |                                                     |

## Extensions

If you wish to compare two data sets using `overview_tab`, this is not
(yet) implemented in `overviewR` but there is currently a workaround.

``` r
library(overviewR)
library(dplyr)
library(xtable)

# Load data
data(toydata)

# Restrict the data so that we have something to compare :-)
toydata_res <- toydata %>%
  dplyr::filter(year > 1992)

# Generate two overview_tab objects
dat1 <- overview_tab(toydata, id = ccode, time = year)
dat2 <- overview_tab(toydata_res, id = ccode, time = year)

# And now we use full_join to combine both
dat_full <- dat1 %>%
  dplyr::full_join(dat2, by = "ccode") %>%
  dplyr::rename(time_dat1 = time_frame.x,
                time_dat2 = time_frame.y)
```

Having a look at the output, we see that this is exactly what we wanted
to have:

``` r
head(dat_full)
```

    #> # A tibble: 5 x 3
    #> # Groups:   ccode [5]
    #>   ccode time_dat1                    time_dat2             
    #>   <chr> <chr>                        <chr>                 
    #> 1 AGO   1990 - 1992                  <NA>                  
    #> 2 BEN   1995 - 1999                  1995 - 1999           
    #> 3 FRA   1993, 1996, 1999             1993, 1996, 1999      
    #> 4 GBR   1991, 1993, 1995, 1997, 1999 1993, 1995, 1997, 1999
    #> 5 RWA   1990 - 1995                  1993 - 1995

`overview_latex` cannot handle this object (yet), so we use `xtable`
instead which gives us the LaTeX output.

``` r
print(xtable(dat_full), include.rownames = FALSE)
```

    % latex table generated in R 4.0.2 by xtable 1.8-4 package
    % Tue Feb 16 18:20:51 2021
    \begin{table}[ht]
    \centering
    \begin{tabular}{lll}
      \hline
    ccode & time\_dat1 & time\_dat2 \\ 
      \hline
    AGO & 1990 - 1992 &  \\ 
      BEN & 1995 - 1999 & 1995 - 1999 \\ 
      FRA & 1993, 1996, 1999 & 1993, 1996, 1999 \\ 
      GBR & 1991, 1993, 1995, 1997, 1999 & 1993, 1995, 1997, 1999 \\ 
      RWA & 1990 - 1995 & 1993 - 1995 \\ 
       \hline
    \end{tabular}
    \end{table}

</details>
<p align="center">
<img src='man/figures/extension1.png' height="150"/>
</p>

# What’s unique about overviewR?

With a specific focus on time-series cross-sectional data, it is unique
in its coverage. The details are outlined in the table below:

| Key functionalities                                                               | overviewR (0.0.11) | DataExplorer (0.8.2) | dlookR (0.6.0) | gtsummary (1.6.1) | Hmisc (4.7-1) | naniar (0.6.1) | skimr (2.1.4) | smartEDA (0.3.8) | summarytools (1.0.1) |
|-----------------------------------------------------------------------------------|--------------------|----------------------|----------------|-------------------|---------------|----------------|---------------|------------------|----------------------|
| Shows time-series cross-sectional data coverage                                   | ✓                  |                      |                |                   |               |                |               |                  |                      |
| Allows to quickly report time-series cross-sectional data coverage (figure/table) | ✓                  |                      |                |                   |               |                |               |                  |                      |
| Shows NAs                                                                         | ✓                  | ✓                    | ✓              | ✓                 | ✓             | ✓              | ✓             | ✓                | ✓                    |
| Shows NAs (in a figure)                                                           | ✓                  | ✓                    | ✓              |                   |               | ✓              |               |                  |                      |
| Shows overlap between two data frames (based on time and id)                      | ✓                  |                      |                |                   |               |                |               |                  |                      |
| Shows cross-table                                                                 | ✓                  |                      |                | ✓                 |               |                |               | ✓                | ✓                    |
| Shows cross-table based on country-year units                                     | ✓                  |                      |                |                   |               |                |               |                  |                      |
| Shows cross-tables (in a figure)                                                  | ✓                  |                      |                |                   |               |                |               |                  |                      |
| Reports descriptive statistics                                                    |                    | ✓                    | ✓              | ✓                 | ✓             | ✓              | ✓             | ✓                | ✓                    |
| Shows value type                                                                  |                    | ✓                    | ✓              | ✓                 |               | ✓              | ✓             | ✓                | ✓                    |

# How to reach out?

### Where do I report bugs?

Simply [open an
issue](https://github.com/cosimameyer/overviewR/issues/new) on GitHub.

### How do I contribute to the package?

If you have an idea (but no code yet), [open an
issue](https://github.com/cosimameyer/overviewR/issues/new) on GitHub.
If you want to contribute with a specific feature and have the code
ready, fork the repository, add your code, and create a pull request.

### Do you need support?

The easiest way is to [open an
issue](https://github.com/cosimameyer/overviewR/issues/new) - this way,
your question is also visible to others who may face similar problems.

# Credits

The hex sticker is generated by ourselves using the
[`hexSticker`](https://github.com/GuangchuangYu/hexSticker) package.
