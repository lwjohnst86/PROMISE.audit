#' Generate report of auditing results.
#'
#' Extracts relevant information from the `assertr_errors` attributes, after one
#' or more audits (`chk_*`) have been done.
#'
#' @param .data Dataset after being 'audited'.
#'
#' @return Returns a data frame of all failed audits.
#' @export
#'
#' @examples
#'
#' library(magrittr)
#' ds <- data.frame(a = rnorm(10), b = 1:10)
#' flaws <- ds %>%
#' chk_in_range(-1.1, 1.1, "a") %>%
#' chk_in_set(1:9, "b")
#' aud_report(flaws)
#'
aud_report <- function(.data) {

    flaws <- attr(.data, "assertr_errors")
    if (is.null(flaws)) {
        message("Auditing found no flaws based on the specified checks.")
        return(invisible())
    }

    flaw_report <- function(x) {
        uniq_flaw_values <- paste(unique(x$error_df$value))
        num_flaws <- x$num.violations
        flaw_locations <- x$error_df$index
        column_name <- sub("^.*\\'(.*)\\'.*\\'.*\\'.*$", "\\1", x$message)
        data.frame(
            Column = column_name,
            Fails = num_flaws,
            Values = as.character(paste(uniq_flaw_values, collapse = ", ")),
            RowNum = as.character(paste(flaw_locations, collapse = ", ")),
            stringsAsFactors = FALSE
        )
    }

    purrr::map_dfr(flaws, flaw_report)
}
