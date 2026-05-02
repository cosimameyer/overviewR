## Submission

This is a resubmission for v0.0.14. Changes since the last CRAN release (v0.0.13):

- New function `overview_markdown()` to render `overview_tab`/`overview_crosstab`
  output as Markdown tables- `overview_overlap()` gains `proportional = TRUE` for area-proportional Euler
  diagrams via the suggested package `eulerr`- `overview_plot()` now accepts a literal color string (e.g. `color = "steelblue"`)
  in addition to column-variable mapping- `overview_na()` warns when `month`/`day` columns contain NAs
## Test environments

* macOS Sequoia 15.7.4 (aarch64), R 4.6.0 (2026-04-24)
* Ubuntu 24.04.4 LTS (x86_64), R 4.6.0 (2026-04-24)
* Windows Server 2022 x64 (build 26100), R 4.6.0 (2026-04-24 ucrt)

## R CMD check results

There were no ERRORs, WARNINGs, or NOTEs.

## Downstream dependencies

There are currently no downstream dependencies for this package.
