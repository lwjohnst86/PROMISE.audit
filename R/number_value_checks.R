#' Audits column values within a certain numeric range.
#'
#' Uses the [`assertr::within_bounds`].
#'
#' @param .data Data to audit.
#' @param .low Low value in the range.
#' @param .high High value in the range.
#' @param .variables Column variables to check.
#'
#' @return Adds attribute that contains the audit errors, if any, to the data.
#' @export
#'
#' @examples
#' library(magrittr)
#' flaws <- data.frame(a = rnorm(10)) %>%
#' chk_in_range(-1, 1, "a")
#' attributes(flaws)$assertr_errors
chk_in_range <- function(.data, .low, .high, .variables) {
    chk_assert_func(
        .data = .data,
        .function = assertr::within_bounds(.low, .high),
        .variables = .variables
    )
}

