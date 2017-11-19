
#' General data audit function to create other specific audit functions.
#'
#' Thin wrapper around the [`assertr::assert_`] function.
#'
#' @param .data Data to check for errors.
#' @param .function `assertr` function to apply to the `assertr::assert` command.
#' @param .variables The columns to run the audit checks on.
#'
#' @return Adds `assertr_errors` to data.frame.
#' @seealso [`assertr::assert`]
#' @export
#'
#' @examples
#' library(magrittr)
#' library(assertr)
#' flaws <- iris %>%
#' chk_assert_func(within_bounds(5, 7), "Sepal.Length")
#' attributes(flaws)$assertr_errors
#'
chk_assert_func <- function(.data, .function, .variables) {
    assertr::assert_(
        data = .data,
        predicate = .function,
        .dots = .variables,
        success_fun = assertr::success_continue,
        error_fun = assertr::error_append
    )
}
