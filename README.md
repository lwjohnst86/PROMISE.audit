
<!-- README.md is generated from README.Rmd. Please edit that file -->
PROMISE.audit
=============

[![Travis-CI Build Status](https://travis-ci.org/lwjohnst86/PROMISE.audit.svg?branch=master)](https://travis-ci.org/lwjohnst86/PROMISE.audit) [![Coverage Status](https://img.shields.io/codecov/c/github/lwjohnst86/PROMISE.audit/master.svg)](https://codecov.io/github/lwjohnst86/PROMISE.audit?branch=master)

The aim of this package is to run audits on datasets to check for errors or typos in values. For instance, with a column called MonthsPerYear, the values should be integers that go from 1 to 12. If there are violations to this pattern, the values need to be investigated at the raw data source. This is a companion package to the main PROMISE package (see [website](https://promise-cohort.gitlab.io/PROMISE)).

In general, this audit package is a thin wrapper around [assertr](https://cran.r-project.org/web/packages/assertr/vignettes/assertr.html). It simplifies some common uses of assertr as well as creating an easy interface to viewing the errors from multiple audit checks.

Installation
============

Only on GitHub right now, and is in development.

``` r
# install.packages("devtools")
devtools::install_github("lwjohnst86/PROMISE.audit")
```

Usage
=====

``` r
library(PROMISE.audit)
library(magrittr)
audit <- swiss %>% 
    chk_in_range(3, 20, "Examination") %>% 
    chk_in_set(1:10, "Education") %>% 
    chk_outliers(3, "Fertility")
aud_report(audit) %>% 
    knitr::kable()
```

| Column      |  Fails| Values                                 | RowNum                                                           |
|:------------|------:|:---------------------------------------|:-----------------------------------------------------------------|
| Examination |     14| 21, 22, 26, 31, 25, 29, 35, 37         | 12, 15, 18, 19, 21, 23, 29, 39, 40, 41, 42, 44, 45, 47           |
| Education   |     17| 12, 15, 13, 28, 20, 19, 11, 32, 53, 29 | 1, 5, 10, 12, 14, 18, 19, 23, 29, 38, 39, 40, 41, 42, 45, 46, 47 |
