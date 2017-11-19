context("Asserting functions")

n <- 5
testdata <- data.frame(
    Hours = c(sample(1:24, n), 25),
    Days = c(sample(1:7, n), 8),
    Months = c(sample(1:12, n), 13)
)

test_that("General assert function works", {
    audit <- chk_assert_func(testdata, assertr::in_set(1:7), "Days")
    flaws <- attributes(audit)$assertr_errors[[1]]

    expect_equal(flaws$num.violations, 1)
    expect_equal(flaws$error_df$value, 8)
    expect_match(flaws$message, "Days")
})

