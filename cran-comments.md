## Resubmission

This is a resubmission that incorporates the CRAN comments from our prior 
submission.

This is a submission for a new package.

We added:

- We used tempfile() and unlink() to store test outputs in a temporary environment instead of writing on the user's home filespace
- Replaced TeX with LaTeX as requested
- Wrote package names, software names and API names in single 
quotes as requested

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
