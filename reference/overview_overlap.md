# overview_overlap

Provides an overview of the overlap of two data sets. Cautionary note:
This function is currently only preliminary workable and can only
capture 2 data sets. We are working on an extension that allows to
compare multiple data sets.

## Usage

``` r
overview_overlap(
  dat1,
  dat2,
  dat1_id,
  dat2_id,
  dat1_name = "Data set 1",
  dat2_name = "Data set 2",
  plot_type = "bar",
  proportional = FALSE
)
```

## Arguments

- dat1:

  A first data set object

- dat2:

  A second data set object

- dat1_id:

  Scope (e.g., country codes or individual IDs) of dat1. It is important
  that both ID variables are exactly the same to generate the perfect
  match.

- dat2_id:

  Scope (e.g., country codes or individual IDs) of dat2. It is important
  that both ID variables are exactly the same to generate the perfect
  match.

- dat1_name:

  Name of dat1 ("Data set 1" is the default)

- dat2_name:

  Name of dat2 ("Data set 2" is the default)

- plot_type:

  Type of plot ("bar" and "venn" are the two options) "venn" relies on
  the ggvenn function

- proportional:

  Logical. If `TRUE` and `plot_type = "venn"`, draws a proportional
  Euler diagram using the eulerr package (must be installed separately).
  The returned object is an `eulergram` (base-R graphics), not a ggplot2
  object. Default is `FALSE`.

## Value

A ggplot2 object (bar chart or standard Venn diagram), or an `eulergram`
object when `proportional = TRUE`.

## Examples

``` r
if (FALSE) { # \dontrun{
data(toydata)
toydata2 <- toydata[which(toydata$year > 1992), ]
overview_overlap(
  dat1 = toydata, dat2 = toydata2, dat1_id = ccode,
  dat2_id = ccode
)
} # }
```
