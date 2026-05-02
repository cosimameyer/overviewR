# overview_tab_df

Internal function that calculates the \`overview_tab\` for data.frame
objects

## Usage

``` r
overview_tab_df(dat2 = NULL, dat = NULL, id = NULL, time = NULL)
```

## Arguments

- dat2:

  Your data set

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

## Value

A data.frame
