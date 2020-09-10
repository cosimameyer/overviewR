
# overviewR <img src='man/figures/logo.png' align="right" height="139" />

<!-- badges: start -->

[![Travis build
status](https://img.shields.io/travis/com/cosimameyer/overviewR.svg?logo=travis)](https://travis-ci.com/cosimameyer/overviewR)
[![Codecov test
coverage](https://codecov.io/gh/cosimameyer/overviewR/branch/master/graph/badge.svg)](https://codecov.io/gh/cosimameyer/overviewR?branch=master)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![overviewR
badge](https://img.shields.io/badge/overviewR-ready%20to%20use-brightgreen)](https://github.com/cosimameyer/overviewR)
[![R
badge](https://img.shields.io/badge/Build%20with-♥%20and%20R-blue)](https://github.com/cosimameyer/overviewR)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/overviewR)](https://cran.r-project.org/package=overviewR)
[![downloads](https://cranlogs.r-pkg.org/badges/overviewR)](https://github.com/cosimameyer/overviewR)
[![license](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
<!-- [![Rdoc](https://www.rdocumentation.org/badges/version/overviewR)](https://www.rdocumentation.org/packages/overviewR) -->
<!-- [![metacran downloads](https://cranlogs.r-pkg.org/badges/overviewR)](https://cran.r-project.org/package=overviewR) -->
<!-- [![cran checks](https://cranchecks.info/badges/summary/overviewR)](https://cran.r-project.org/web/checks/check_results_overviewR.html) -->
<!-- [![](https://cranlogs.r-pkg.org/badges/version/overviewR)](https://www.r-pkg.org/badges/version/overviewR) -->
<!-- [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) -->
<!-- [![Last-changedate](https://img.shields.io/badge/last%20change-2020--08--29-green.svg)](/commits/master) -->
<!-- badges: end -->

[**You can access the CheatSheet for overviewR
here**](https://github.com/cosimameyer/overviewR/blob/master/man/figures/CheatSheet_overviewR.pdf)

The goal of overviewR is to make it easy to get an overview of a data
set by displaying relevant sample information. At the moment, there are
two functions (`overview_tab` and `overview_crosstab`) that generate a
tabular overview of the general sample as well as a conditional sample.
The general sample plots a two-column table that provides information on
an id in the left column and a the time frame on the right column. The
conditional column allows to disaggregate the overview table by
specifying two conditions, hence resulting a 2x2 table. This way, it is
easy to visualize the time and scope conditions as well as theoretical
assumptions with examples from the data set. The function
`overview_print` converts this output of both `overview_tab` and
`overview_crosstab` into LaTeX code and/or directly into a .tex file.

The output of `overview_tab` and `overview_crosstab` are also compatible
with other packages such as
[`xtable`](https://CRAN.R-project.org/package=xtable),
[`flextable`](https://CRAN.R-project.org/package=flextable), or
[`knitr`](https://bookdown.org/yihui/rmarkdown-cookbook/kable.html).

## Installation

A stable version of `overviewR` can be directly accessed on CRAN:

``` r
install.packages("overviewR", force = TRUE)
```

To install the latest development version of `overviewR` directly from
[GitHub](https://github.com/cosimameyer/overviewR) use:

``` r
library(devtools)
devtools::install_github("cosimameyer/overviewR")
```

## Example

First, load the package.

``` r
library(overviewR)
```

The following examples use a toy data set (`toydata`) that comes with
the package. This data contains artificially generated information in a
cross-sectional format on 5 countries, covering the period 1990-1999.

``` r
data(toydata)
head(toydata)
#>   ccode year month      gdp population
#> 1   RWA 1990   Jan 24180.77  14969.988
#> 2   RWA 1990   Feb 23650.53  11791.464
#> 3   RWA 1990   Mar 21860.14  30047.979
#> 4   RWA 1990   Apr 20801.06  19853.556
#> 5   RWA 1990   May 18702.84   5148.118
#> 6   RWA 1990   Jun 30272.37  48625.140
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

### `overview_print`

To generate an easily usable LaTeX output for the generated
`overview_tab` and `overview_crosstab` objects, `overviewR` offers the
function `overview_print`. The following illustrate this using the
`output_table` object from `overview_tab`.

``` r
overview_print(obj = output_table)
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
overview_print(obj = output_table, id = "Countries", time = "Years",
               title = "Cool new title for our awesome table")
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
overview_print(
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

With `save_out = TRUE` the function exports the output as a `.tex` file
and stores it on the device.

``` r
overview_print(obj = output_table, save_out = TRUE, path = "SET-YOUR-PATH",
               file = "output.tex")
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

<img src="man/figures/unnamed-chunk-19-1.png" width="50%" style="display: block; margin: auto;" />

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

``` r
overview_heat(toydata_red,
                ccode,
                year,
                perc = TRUE,
                exp_total = 12)
```

<img src="man/figures/unnamed-chunk-21-1.png" width="50%" style="display: block; margin: auto;" />

### `overview_na`

`overview_na` is a simple function that provides information about the
content of all variables in your data, not only the time and scope
conditions. It returns a horizontal ggplot bar plot that indicates the
amount of missing data (NAs) for each variable (on the y-axis). You can
choose whether to display the relative amount of NAs for each variable
in percentage (the default) or the total number of NAs.

``` r
overview_na(toydata_with_na)
```

<img src="man/figures/unnamed-chunk-23-1.png" width="50%" style="display: block; margin: auto;" />

``` r
overview_na(toydata_with_na, perc = FALSE)
```

<img src="man/figures/unnamed-chunk-24-1.png" width="50%" style="display: block; margin: auto;" />

## Compatibilities with other packages

The outputs of `overview_tab` and `overview_crosstab` are also
compatible with other functions such as
[`xtable`](https://CRAN.R-project.org/package=xtable),
[`flextable`](https://CRAN.R-project.org/package=flextable), or
[`kable`](https://bookdown.org/yihui/rmarkdown-cookbook/kable.html) from
[`knitr`](https://yihui.org/knitr/).

Two examples are shown below:

``` r
library(flextable)
table_output <- qflextable(output_table)
table_output <-
  set_header_labels(table_output,
                    ccode = "Countries",
                    time_frame = "Time frame")
set_table_properties(
  table_output,
  width = .4,
  layout = "autofit"
)
```

``` r
library(knitr)
knitr::kable(output_table)
```

| ccode | time\_frame                  |
| :---- | :--------------------------- |
| RWA   | 1990-1995                    |
| AGO   | 1990-1992                    |
| BEN   | 1995-1999                    |
| GBR   | 1991, 1993, 1995, 1997, 1999 |
| FRA   | 1993, 1996, 1999             |

# Credits

The hex sticker is generated by ourselves using the
[`hexSticker`](https://github.com/GuangchuangYu/hexSticker) package.
