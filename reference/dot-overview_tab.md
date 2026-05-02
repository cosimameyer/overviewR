# .overview_tab

Internal function that calculates the \`overview_tab\` for data.table
objects

## Usage

``` r
.overview_tab(dat = NULL, id = NULL, time = NULL, col_names = NULL)
```

## Arguments

- dat:

  Your data set

- id:

  Scope (e.g., country codes or individual IDs)

- time:

  Time (e.g., time periods given by years, months, ...). There are three
  options to add a date variable: 1) Time can be a character vector
  containing \*\*one\*\* time variable, 2) a time variable following the
  YYYY-MM-DD format, or 3) or a list containing multiple time variables
  (\`time = list(year = NULL, month = NULL, day = NULL)\`).

- col_names:

  The column names (containing id and time)

## Value

A data.table
