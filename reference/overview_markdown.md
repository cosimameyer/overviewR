# overview_markdown

Produces a Markdown table output for objects obtained via `overview_tab`
and `overview_crosstab`

## Usage

``` r
overview_markdown(
  obj,
  title = "Time and scope of the sample",
  id = "Sample",
  time = "Time frame",
  crosstab = FALSE,
  cond1 = "Condition 1",
  cond2 = "Condition 2",
  save_out = FALSE,
  file_path = ""
)
```

## Arguments

- obj:

  Overview object produced by `overview_tab` or `overview_crosstab`

- title:

  Optional title printed as a Markdown heading above the table. Defaults
  to `"Time and scope of the sample"`.

- id:

  The header of the left column (default is `"Sample"`). Ignored when
  `crosstab = TRUE`.

- time:

  The header of the right column (default is `"Time frame"`). Ignored
  when `crosstab = TRUE`.

- crosstab:

  Logical. If `TRUE` produces a cross-table output. Default is `FALSE`.

- cond1:

  Label for the first condition. Ignored when `crosstab = FALSE`.

- cond2:

  Label for the second condition. Ignored when `crosstab = FALSE`.

- save_out:

  Logical. If `TRUE` writes the output to a file. Default is `FALSE`.

- file_path:

  Path (including file name with `.md` extension) where the output is
  stored when `save_out = TRUE`.

## Value

Invisibly returns a character string with the Markdown table. The table
is also printed to the console (unless `save_out = TRUE`).

## Examples

``` r
data(toydata)

overview_object <- overview_tab(dat = toydata, id = ccode, time = year)
overview_markdown(obj = overview_object)
#> ## Time and scope of the sample
#> | Sample | Time frame |
#> |--------|------------|
#> | AGO | 1990 - 1992 |
#> | BEN | 1995 - 1999 |
#> | FRA | 1993, 1996, 1999 |
#> | GBR | 1991, 1993, 1995, 1997, 1999 |
#> | RWA | 1990 - 1995 | 

overview_ct_object <- overview_crosstab(
  dat = toydata,
  cond1 = gdp,
  cond2 = population,
  threshold1 = 25000,
  threshold2 = 27000,
  id = ccode,
  time = year
)
overview_markdown(
  obj = overview_ct_object,
  crosstab = TRUE,
  cond1 = "GDP",
  cond2 = "Population"
)
#> ## Time and scope of the sample
#> | | **GDP**: Fulfilled | **GDP**: Not fulfilled |
#> |---|---|---|
#> | **Population**: Fulfilled | AGO (1990, 1992), FRA (1993), GBR (1997) | BEN (1996, 1999), FRA (1999), GBR (1993), RWA (1992, 1994) |
#> | **Population**: Not fulfilled | BEN (1997), RWA (1990) | AGO (1991), BEN (1995, 1998), FRA (1996), GBR (1991, 1995, 1999), RWA (1991, 1993, 1995) | 
```
