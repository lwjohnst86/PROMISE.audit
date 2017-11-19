
<!-- README.md is generated from README.Rmd. Please edit that file -->
PROMISE.audit
=============

[![Travis-CI Build Status](https://travis-ci.org/lwjohnst86/PROMISE.audit.svg?branch=master)](https://travis-ci.org/lwjohnst86/PROMISE.audit) [![Coverage Status](https://img.shields.io/codecov/c/github/lwjohnst86/PROMISE.audit/master.svg)](https://codecov.io/github/lwjohnst86/PROMISE.audit?branch=master)

The aim of this package is to run audits on datasets to check for errors or typos in values. For instance, with a column called MonthsPerYear, the values should be integers that go from 1 to 12. If there are violations to this pattern, the values need to be investigated at the raw data source.

For the most part, this audit package is a thin wrapper around [assertr](https://cran.r-project.org/web/packages/assertr/vignettes/assertr.html). For the most part, it simplifies some common uses of assertr as well as creating an easy interface to viewing the errors from multiple audit checks.

Installation
============

Only on GitHub right now, and is in development.

``` r
# install.packages("devtools")
devtools::install_github("lwjohnst86/PROMISE.audit")
```
