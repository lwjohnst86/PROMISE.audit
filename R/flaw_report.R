#' Generate report of auditing results.
#'
#' Extracts relevant information from the `assertr_errors` attributes, after one
#' or more audits (`chk_*`) have been done.
#'
#' @param .data Dataset after being 'audited'.
#' @param location Logical. Whether to show the specific location (row number)
#'   of the data value flaw/error.
#'
#' @return Returns the data invisibly, but prints messages detailing the
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
#' aud_report(flaws, location = TRUE)
#'
aud_report <- function(.data, location = FALSE) {

    flaws <- attr(.data, "assertr_errors")
    if (is.null(flaws)) {
        message("Auditing found no flaws based on the specified checks.")
        return(.data)
    }

    flaw_report <- function(x, location = location) {
        uniq_flaw_values <- unique(x$error_df$value)
        uniq_flaw_values <-
            ifelse(is.numeric(uniq_flaw_values),
                   uniq_flaw_values,
                   as.character(uniq_flaw_values))
        num_flaws <- x$num.violations
        flaw_locations <- x$error_df$index
        column_name <- sub("^.*\\'(.*)\\'.*\\'.*\\'.*$", "\\1", x$message)

        flaw_rownum <- "\n"
        if (location) {
            flaw_rownum <-
                paste(
                "\n- Violation row numbers: ",
                paste(flaw_locations, collapse = ", "),
                "\n"
                )
        }

        message(
            "\n",
            "Auditing for column ", column_name, ":\n",
            "- Total violations: ", num_flaws, "\n",
            "- Violation values: ", paste(uniq_flaw_values, collapse = ", "),
            flaw_rownum
            )
    }

    purrr::map(flaws, flaw_report, location = location)
    return(invisible(.data))
}
