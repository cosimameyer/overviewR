---
# overviewR 0.0.8.999
- This development version adds the possibility to use a data.table object with `overview_tab` and `overview_na`

# overviewR 0.0.7.999.1

- This development version adds the following extensions
   - `overview_plot`
      - Adjustable `dot_size` (default is 2)
   - `overview_na`
      - Option to generate `row_wise` NA values
   - `overview_overlap`
      - New function to compare (at the moment) two data sets using bar graphs (`plot_type = "bar"`) or Venn diagrams (`plot_type = "venn"`)
   - `overview_print`
      - Fixed a small issue that can cause problems with large (and complex) TeX documents 


---
# overviewR 0.0.7.999

- This development version adds bugs fixes and extensions for 
   - `overview_plot`
      - some consecutive years were not correctly connected before)
      - `color` argument to color parts of the time lines
   - `overview_print`
      - `label` to add a cross-reference label
      - `fontsize` to change the font size
   - `overview_crossplot`
      - a new function that visualizes basically the same output as `overview_crosstab`
   - `overview_tab`
      - if there is a `NA` in the `id` variable this observation will be automatically deleted. The user receives a warning.
   - `overview_crosstab`
      - if there is a `NA` in the `id` variable this observation will be automatically deleted. The user receives a warning.
   

---
# overviewR 0.0.7
- CRAN resubmission
We fixed the following bugs:
- Fixed bug in overview_plot function
   - Time line was not correctly displayed when a consecutive time variable was present for two different id variables
- Fixed bug in vignette
   - Loaded package dplyr to follow CRAN policies: "Packages which use Internet resources should fail gracefully with an informative message if the resource is not available or has changed (and not give a check warning nor error). CRAN versions of packages should work with the current CRAN and Bioconductor releases of packages they depend on and not anticipate nor recommend development versions of such packages (or themselves) on other repositories."

And added the following new features:
- Added function for overview_plot function
   - Y axis is now automatically ordered in ascending order
- Extended the overview_heat function
   - Y axis is now automatically ordered in ascending order
   - Introduced "label" argument to overview_heat that allows the user to select whether the percentage/total number of observations should be displayed or not

---
# overviewR 0.0.6
- CRAN resubmission
- Added new functions:
  - overview_plot
  - overview_na
  - overview_heat
- Fixed two bugs in overview_plot and overview_tab that returned erroneous results on non-sorted data

---

# overviewR 0.0.5.900

- This development version adds the following functions:
   - overview_plot
   - overview_na
   - overview_heat

---

# overviewR 0.0.4

- CRAN release
- Further adjustments to new CRAN comments to avoid writing on the user's home file space

---

# overviewR 0.0.3

- Adjusted examples and tests based on CRAN's standards

---

# overviewR 0.0.2

- Bug fixes in overview_tab that affected overview_crosstab

---

# overviewR 0.0.1

