# overview_tab

Provides an overview table for the time and scope conditions of a data
set. If a data.table object is provided, the function uses data.table's
syntax to perform the evaluation

## Usage

``` r
overview_tab(
  dat,
  id,
  time = list(year = NULL, month = NULL, day = NULL),
  complex_date = FALSE
)
```

## Arguments

- dat:

  A data frame or data table object

- id:

  Scope (e.g., country codes or individual IDs)

- time:

  Time (e.g., time periods given by years, months, ...). There are three
  options to add a date variable: 1) Time can be a character vector
  containing \*\*one\*\* time variable, 2) a time variable following the
  YYYY-MM-DD format, or 3) or a list containing multiple time variables
  (\`time = list(year = NULL, month = NULL, day = NULL)\`).

- complex_date:

  Boolean argument identifying if there is a more complex (list-wise)
  date_time parameter (FALSE is the default)

## Value

A data frame object that contains a summary of a sample that can later
be converted to a 'LaTeX' output using `overview_latex`

## Examples

``` r
# With version 1 (and also 2):

data(toydata)
output_table <- overview_tab(dat = toydata, id = ccode, time = year)

# With version 3:
overview_tab(dat = toydata, id = ccode, time = list(
  year = toydata$year,
  month = toydata$month, day = toydata$day
), complex_date = TRUE)
#> # A tibble: 5 × 2
#> # Groups:   ccode [5]
#>   ccode time_frame                                                              
#>   <chr> <chr>                                                                   
#> 1 AGO   1990-01-01, 1990-02-02, 1990-03-03, 1990-04-04, 1990-05-05, 1990-06-06,…
#> 2 BEN   1995-01-01, 1995-02-02, 1995-03-03, 1995-04-04, 1995-05-05, 1995-06-06,…
#> 3 FRA   1993-01-01, 1993-02-02, 1993-03-03, 1993-04-04, 1993-05-05, 1993-06-06,…
#> 4 GBR   1991-01-01, 1991-02-02, 1991-03-03, 1991-04-04, 1991-05-05, 1991-06-06,…
#> 5 RWA   1990-01-01 - 1990-01-12, 1991-01-01 - 1991-01-12, 1992-01-01 - 1992-01-…
```
