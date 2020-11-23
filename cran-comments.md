## Resubmission

This is a resubmission for an updated version of this package (overviewR 0.0.6 is already available on CRAN).

We fixed the following bugs:
- Fixed bug in vignette
   - Loaded package dplyr to follow CRAN policies: "Packages which use Internet resources should fail gracefully with an informative message if the resource is not available or has changed (and not give a check warning nor error). CRAN versions of packages should work with the current CRAN and Bioconductor releases of packages they depend on and not anticipate nor recommend development versions of such packages (or themselves) on other repositories."
- Fixed bug in overview_plot function
   - Time line was not correctly displayed when a consecutive time variable was present for two different id variables

And added the following new features:
- Added function for overview_plot function
   - Y axis is now automatically ordered in ascending order
- Extended the overview_heat function
   - Y axis is now automatically ordered in ascending order
   - Introduced "label" argument to overview_heat that allows the user to select whether the percentage/total number of observations should be displayed or not

## Test environments

* Debian Linux, R-release, GCC (on rhub)
* Windows Server 2008 R2 SP1, R-devel, 32/64 bit (on rhub)
* macOS Big Sur 11.0.1, R 4.0.2 (local machine)
* Fedora Linux, R-devel, clang, gfortran (on rhub)

## R CMD check results
There were no ERRORs, WARNINGs, or NOTES

## Downstream dependencies
There are currently no downstream dependencies for this package.
