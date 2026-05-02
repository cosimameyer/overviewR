## Submission

This is a resubmission for v0.0.14. Changes since the last CRAN release (v0.0.13):

- New function `overview_markdown()` to render `overview_tab`/`overview_crosstab`
  output as Markdown tables (closes #41)
- `overview_overlap()` gains `proportional = TRUE` for area-proportional Euler
  diagrams via the suggested package `eulerr` (closes #35)
- `overview_plot()` now accepts a literal color string (e.g. `color = "steelblue"`)
  in addition to column-variable mapping (closes #11)
- `overview_na()` warns when `month`/`day` columns contain NAs (closes #14)

## Test environments

* <!-- fill in after devtools::check_win_devel() -->
* <!-- fill in after rhub::check_for_cran() -->
* <!-- local machine: OS, R version -->

## R CMD check results

<!-- paste results here -->

There were no ERRORs or WARNINGs.

<!-- list any NOTEs and explain them -->

## Downstream dependencies

There are currently no downstream dependencies for this package.
