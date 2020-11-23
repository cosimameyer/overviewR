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

