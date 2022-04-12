## Resubmission

This is a (re)submission for an updated version of this package (overviewR 0.0.7 is already available on CRAN).

- This version adds the following extensions
   - `overview_plot`
      - Adjustable `dot_size` (default is 2)
   - `overview_na`
      - Option to generate `row_wise` NA values
      - Possibility to use data.table
   - `overview_overlap`
      - New function to compare (at the moment) two data sets using bar graphs (`plot_type = "bar"`) or Venn diagrams (`plot_type = "venn"`)
   - `overview_print`
      - Fixed a small issue that can cause problems with large (and complex) TeX documents 
   - `overview_tab`
      - Possibility to use data.table
      - Multiple time argument 
   - Excetended `toydata` data.frame (including variables for day)
   
- This version adds bugs fixes and extensions for 
   - `overview_plot`
      - some consecutive years were not correctly connected before)
      - `color` argument to color parts of the time lines
   - `overview_print`
      - `label` to add a cross-reference label
      - `fontsize` to change the font size
   - `overview_crossplot`
      - a new function that visualizes basically the same output as `overview_crosstab`
   - `overview_tab`
      - if there is a `NA` in the `id` variable this observation will be automatically deleted. The user gets a warning.
   - `overview_crosstab`
      - if there is a `NA` in the `id` variable this observation will be automatically deleted. The user gets a warning.
      
## Test environments

* Windows Server 2022, R-devel, 64 bit  (on win-devel)
* Ubuntu Linux 20.04.1 LTS, R-release, GCC  (on rhub)
* macOS Monterey 12.1, R 4.1.3 (local machine)
* Fedora Linux, R-devel, clang, gfortran (on rhub)

## R CMD check results
There were no ERRORs, WARNINGs or NOTEs.

## Downstream dependencies
There are currently no downstream dependencies for this package.
