# .overview_tab

Internal function that calculates the \`overview_tab\` for data.table
objects

## Usage

``` r
.overview_heat(
  dat = NULL,
  id = NULL,
  time = NULL,
  label = FALSE,
  perc = FALSE,
  col_low = NULL,
  col_high = NULL,
  xaxis = NULL,
  yaxis = NULL,
  theme_plot = NULL,
  exp_total = NULL,
  col_names = NULL
)
```

## Arguments

- dat:

  The data set

- id:

  The scope (e.g., country codes or individual IDs). The axis is ordered
  in ascending order by default.

- time:

  The time (e.g., time periods given by years, months, ...)

- label:

  If TRUE (default), the total number of observations/percentages of
  observations are displayed. If FALSE, it returns no labels.

- perc:

  If FALSE (default) plot returns the total number of observations per
  time-scope-unit. If TRUE, it returns the number of observations per
  time-scope-unit in percentage

- col_low:

  Hex color code for the lowest value (default is "#dceaf2")

- col_high:

  Hex color code for the lowest value (default is "#2A5773")

- xaxis:

  Label of your x axis ("Time frame" is default)

- yaxis:

  Label of your y axis ("Sample" is default)

- theme_plot:

  Previously generated theme

- exp_total:

  Expected total number of observations (i.e. maximum) for time unit.

- col_names:

  The column names (containing id and time)

## Value

A ggplot
