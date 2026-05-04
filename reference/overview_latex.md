# overview_latex

Produces a 'LaTeX' output for output obtained via `overview_tab` and
`overview_crosstab`

## Usage

``` r
overview_latex(
  obj,
  title = "Time and scope of the sample",
  id = "Sample",
  time = "Time frame",
  crosstab = FALSE,
  cond1 = "Condition 1",
  cond2 = "Condition 2",
  save_out = FALSE,
  file_path,
  label = "tab:tab1",
  fontsize,
  file,
  path
)
```

## Arguments

- obj:

  Overview object produced by overview_tab or overview_crosstab

- title:

  Caption of the table (default is "Time and scope of the sample")

- id:

  The name of the left column (default is "Sample"), will be ignored if
  crosstab is TRUE

- time:

  The name of the right column (default is ("Time frame")), will be
  ignored if `crosstab` is TRUE

- crosstab:

  Logical argument, if TRUE produces a `crosstab` output, default is
  FALSE

- cond1:

  Description for the first condition (character), will be ignored if
  `crosstab` is FALSE. This should correspond to the input for `cond1`
  in `overview_crosstab`

- cond2:

  Description for the second condition (character), will be ignored if
  `crosstab` is FALSE. This should correspond to the input for `cond2`
  in `overview_crosstab`

- save_out:

  Optional argument, exports the output table as a .tex file, default is
  FALSE

- file_path:

  Specifies the path and file name (.tex) where you store your output

- label:

  Specifies the label (default is "tab:tab1")

- fontsize:

  Specifies the font size (all 'LaTeX' font sizes such as "scriptsize"
  or "small" work)

- file:

  This argument is deprecated. Please use "file_path" instead and add
  the full path.

- path:

  This argument is deprecated. Please use "file_path" instead and add
  the full path.

## Value

A 'LaTeX' output that can either be copy-pasted in a text document or
exported directed as a .tex file

## Examples

``` r
data(toydata)

overview_object <- overview_tab(dat = toydata, id = ccode, time = year)
overview_latex(
  obj = overview_object,
  title = "Some nice title",
  crosstab = FALSE
)
#> % Overview table generated in R version 4.6.0 (2026-04-24) using overviewR 
#> % Table created on 2026-05-04
#> \begin{table}[ht] 
#>  \centering 
#>  \caption{Some nice title} 
#> \label{tab:tab1} 
#> 
#> \begin{tabular}{ll} 
#>  \hline 
#> Sample & Time frame \\ \hline 
#>  AGO & 1990 - 1992 \\ 
#>  BEN & 1995 - 1999 \\ 
#>  FRA & 1993, 1996, 1999 \\ 
#>  GBR & 1991, 1993, 1995, 1997, 1999 \\ 
#>  RWA & 1990 - 1995 \\ 
#>  \hline 
#>  \end{tabular} 
#>  \end{table} 

#' overview_object <- overview_tab(dat = toydata, id = ccode, time = year)
overview_latex(
  obj = overview_object,
  title = "Some nice title",
  file_path = "some/path_to/your_output_file.tex"
)
#> % Overview table generated in R version 4.6.0 (2026-04-24) using overviewR 
#> % Table created on 2026-05-04
#> \begin{table}[ht] 
#>  \centering 
#>  \caption{Some nice title} 
#> \label{tab:tab1} 
#> 
#> \begin{tabular}{ll} 
#>  \hline 
#> Sample & Time frame \\ \hline 
#>  AGO & 1990 - 1992 \\ 
#>  BEN & 1995 - 1999 \\ 
#>  FRA & 1993, 1996, 1999 \\ 
#>  GBR & 1991, 1993, 1995, 1997, 1999 \\ 
#>  RWA & 1990 - 1995 \\ 
#>  \hline 
#>  \end{tabular} 
#>  \end{table} 

overview_ct_object <- overview_crosstab(
  dat = toydata,
  cond1 = gdp,
  cond2 = population,
  threshold1 = 25000,
  threshold2 = 27000,
  id = ccode,
  time = year
)
overview_latex(
  obj = overview_ct_object,
  title = "Some nice title for a cross tab",
  crosstab = TRUE,
  cond1 = "Name of first condition",
  cond2 = "Name of second condition"
)
#> % Overview table generated in R version 4.6.0 (2026-04-24) using overviewR 
#> % Table created on 2026-05-04
#> % Please add the following packages to your document preamble: 
#> % \usepackage{multirow} 
#> % \usepackage{tabularx} 
#> % \newcolumntype{b}{X} 
#> % \newcolumntype{s}{>{\hsize=.5\hsize}X} 
#> \begin{table}[ht] 
#> \caption{Some nice title for a cross tab} 
#> \label{tab:tab1} 
#> 
#> \begin{tabularx}{\textwidth}{ssbb} 
#> \hline & & \multicolumn{2}{c}{\textbf{Name of first condition}} \\ 
#>  & & \textbf{Fulfilled} & \textbf{Not fulfilled} \\ 
#>  \hline \\ 
#>  \multirow{2}{*}{\textbf{Name of second condition}} & \textbf{Fulfilled} & 
#>  AGO (1990, 1992), FRA (1993), GBR (1997) & BEN (1996, 1999), FRA (1999), GBR (1993), RWA (1992, 1994)\\  
#>  \\ \hline \\ 
#>  & \textbf{Not fulfilled} &  BEN (1997), RWA (1990) & AGO (1991), BEN (1995, 1998), FRA (1996), GBR (1991, 1995, 1999), RWA (1991, 1993, 1995)\\  \hline \\ 
#>  \end{tabularx} 
#>  \end{table} 
```
