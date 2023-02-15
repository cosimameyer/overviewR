## Submission

This is a submission for an updated version of this package. It includes a fix for `overview_overlap` that caused testing failures.
      
## Test environments

* Windows Server 2022, R-devel, 64 bit (on win-devel)
* macOS Ventura 13.1, R 4.1.3 (local machine)
* Ubuntu Linux 20.04.1 LTS, R-release, GCC
* Fedora Linux, R-devel, clang, gfortran

## R CMD check results
There were no ERRORs or WARNINGs. 

There is one NOTE that is only found on Windows (Server 2022, R-devel 64-bit): 

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```

As mentioned in the [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this warning could occur due to a bug in MiKTeX and can likely be ignored.

There is one NOTE that is only found on (Fedora Linux, R-devel, clang, gfortran)

```
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found
```

As described [here](https://groups.google.com/g/r-sig-mac/c/7u_ivEj4zhM), our understanding is that this is an old bug/issue which is located at the testing environment.

## Downstream dependencies
There are currently no downstream dependencies for this package.
