
#' General data audit function to create other specific audit functions.
#'
#' Thin wrapper around the [assertr::assert()] and [assertr::insist()] functions.
#'
#' @name assert_base
#' @param .data Data to check for errors.
#' @param .function `assertr` function to apply to the [assertr::assert()] command.
#' @param .variables The columns to run the audit checks on.
#'
#' @return Adds `assertr_errors` to data.frame.
#' @seealso See documentation on either [assertr::assert()] or [assertr::insist()]
#'
#' @examples
#' library(magrittr)
#' library(assertr)
#'
#' flaws <- iris %>%
#' chk_assert_func(within_bounds(5, 7), "Sepal.Length")
#' aud_report(flaws)
#'
#' flaws <- iris %>%
#' chk_insist_func(within_n_mads(1), "Sepal.Length")
#' aud_report(flaws)
#'
NULL

#' @rdname assert_base
#' @export
chk_assert_func <- function(.data, .function, .variables) {
    assertr::assert(
        data = .data,
        predicate = .function,
        .variables,
        success_fun = assertr::success_continue,
        error_fun = assertr::error_append
    )
}

#' @rdname assert_base
#' @export
chk_insist_func <- function(.data, .function, .variables) {
    assertr::insist(
        data = .data,
        predicate_generator = .function,
        .variables,
        success_fun = assertr::success_continue,
        error_fun = assertr::error_append
    )
}
