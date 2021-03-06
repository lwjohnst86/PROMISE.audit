#' Audits column values within a certain numeric range.
#'
#' Uses the [assertr::within_bounds()] function.
#'
#' @param .data Data to audit.
#' @param .low Low value in the range.
#' @param .high High value in the range.
#' @param .variables Column variables to check.
#'
#' @return Adds attribute that contains the audit errors, if any, to the data.
#'   Use [aud_report()] to view the audit fails.
#' @export
#'
#' @examples
#' library(magrittr)
#' ds <- data.frame(a = rnorm(10), b = rnorm(10))
#'
#' flaws <- ds %>%
#' chk_in_range(-1, 1, "a")
#' aud_report(flaws)
#'
chk_in_range <- function(.data, .low, .high, .variables) {
    chk_assert_func(
        .data = .data,
        .function = assertr::within_bounds(.low, .high),
        .variables = .variables
    )
}

#' Audits column values of specific integers.
#'
#' Uses the [assertr::in_set()] function.
#'
#' @inherit chk_in_range return params
#' @param .values The integer values.
#'
#' @export
#'
#' @examples
#' library(magrittr)
#' ds <- data.frame(a = 1:3)
#'
#' flaws <- ds %>%
#' chk_in_set(1:2, "a")
#' aud_report(flaws)
chk_in_set <- function(.data, .values, .variables) {
    chk_assert_func(
        .data = .data,
        .function = assertr::in_set(.values),
        .variables = .variables
    )
}

#' Audits for potential erroneous values ("outliers").
#'
#' Uses the [assertr::within_n_mads()].
#'
#' @inherit chk_in_range return params
#' @param .n_mads Number of mean absolute deviations (see [assertr::within_n_mads]).
#'
#' @export
#'
#' @examples
#' library(magrittr)
#' ds <- data.frame(a = c(rnorm(100), 10))
#'
#' flaws <- ds %>%
#' chk_outliers(2, "a")
#' aud_report(flaws)
chk_outliers <- function(.data, .n_mads, .variables) {
    chk_insist_func(
        .data = .data,
        .function = assertr::within_n_sds(.n_mads),
        .variables = .variables
    )
}

#' Audit for any missingness in columns.
#'
#' Uses [assertr::not_na()].
#'
#' @inherit chk_in_range params return
#'
#' @export
#'
#' @examples
#'
#' library(magrittr)
#' ds <- data.frame(a = c(1:4, NA, 6:10))
#' flaws <- ds %>%
#' chk_missingness("a")
#' aud_report(flaws)
#'
chk_missingness <- function(.data, .variables) {
    chk_assert_func(
        .data = .data,
        .function = assertr::not_na,
        .variables = .variables
    )
}
