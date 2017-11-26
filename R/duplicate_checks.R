#' Audits values in columns for duplicate values.
#'
#' Among other things, uses [assertr::is_uniq].
#'
#' @inherit chk_in_range return params
#'
#' @export
#'
#' @examples
#' library(magrittr)
#'
#' # dataset with one duplicate value between id and time
#' ds <- data.frame(
#' id = c(rep(1:3, each = 2), 3),
#' time = c(rep(1:2, times = 3), 1)
#' )
#' ds
#'
#' flaws <- chk_duplicate(ds, c("id", "time"))
#' aud_report(flaws) # Should be one
#'
#' flaws <- chk_duplicate(ds, c("id"))
#' aud_report(flaws) # Should be all of them
#'
chk_duplicate <- function(.data, .variables) {
    stopifnot(all(.variables %in% names(.data)))

    if (length(.variables) > 1) {
        column <- paste0(.variables, collapse = "--")
        .data[column] <- apply(.data[, .variables], 1, paste0, collapse = "-")
    } else {
        column <- .variables
    }

    flaws_chk <- chk_assert_func(
        .data = .data,
        .function = assertr::is_uniq,
        .variables = column
    )

    if (length(.variables) > 1) {
        flaws_chk[column] <- NULL
    }

    return(flaws_chk)
}
