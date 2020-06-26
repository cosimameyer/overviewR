## Resubmission

This is a resubmission that incorporates the CRAN comments from the first submission.

This is a submission for a new package.

We added:

- Unwrapped examples by removing `\dontrun{}`. All tests passed when using `\devtools::run_examples()`)
- We used tempdir() to save test outputs in a temporary environment instead of writing on the user's home filespace

## Test environments

* Ubuntu Linux 16.04 LTS, R-release, GCC (on rhub)
* Windows Server 2008 R2 SP1, R-devel, 32/64 bit (on rhub)
* macOS Catalina 10.15.5, R 4.0.0 (local machine)
* Fedora Linux, R-devel, clang, gfortran (on rhub)

## R CMD check results
There were no ERRORs or WARNINGs

There was one NOTE:
Maintainer: 'Cosima Meyer <cosima.meyer@gmail.com>'
New submission

This is a submission for a new package.

## Downstream dependencies
There are currently no downstream dependencies for this package.
