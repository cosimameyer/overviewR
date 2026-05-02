# overview_crosstab

Sorts a data set conditionally in a cross table. This can be helpful to
get a sense of the time and scope conditions of a data set. Note, if
used with a data set that has multiple observations on the id-time unit,
the function automatically aggregates this information using the mean.

## Usage

``` r
overview_crosstab(dat, cond1, cond2, threshold1, threshold2, id, time)
```

## Arguments

- dat:

  A data set object

- cond1:

  Variable that describes the first condition

- cond2:

  Variable that describes the second condition

- threshold1:

  A threshold for `cond1`

- threshold2:

  A threshold for `cond2`

- id:

  Scope (e.g., country codes or individual IDs)

- time:

  Time (e.g., time periods given by years, months, ...)

## Value

A data frame object that contains a summary of the data set that can
later be converted to a 'LaTeX' output using `overview_latex`

## Examples

``` r
data(toydata)
overview_crosstab(
  dat = toydata,
  cond1 = gdp,
  cond2 = population,
  threshold1 = 25000,
  threshold2 = 27000,
  id = ccode,
  time = year
)
#>                                      part1
#> 1 AGO (1990, 1992), FRA (1993), GBR (1997)
#> 2                   BEN (1997), RWA (1990)
#>                                                                                      part2
#> 1                               BEN (1996, 1999), FRA (1999), GBR (1993), RWA (1992, 1994)
#> 2 AGO (1991), BEN (1995, 1998), FRA (1996), GBR (1991, 1995, 1999), RWA (1991, 1993, 1995)
```
