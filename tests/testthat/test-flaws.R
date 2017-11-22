context("Asserting functions")

n <- 5
testdata <- data.frame(
    Hours = c(sample(1:24, n), 25),
    Days = c(sample(1:7, n), 8),
    Months = c(sample(1:12, n), 13),
    Temp = c(runif(n, -30, 30), 2000),
    Latitude = c(runif(n, 0, 90), 100),
    Longitude = c(runif(n, 0, 180), 190)
)

test_that("General assert function works", {
    audit <- chk_assert_func(testdata, assertr::in_set(1:7), "Days")
    flaws <- attributes(audit)$assertr_errors[[1]]

    expect_equal(flaws$num.violations, 1)
    expect_equal(flaws$error_df$value, 8)
    expect_match(flaws$message, "Days")
})

test_that("Auditing values in range", {
    audit <- chk_in_range(testdata, -30, 30, "Temp")
    audit <- chk_in_range(audit, 0, 90, "Latitude")
    audit <- chk_in_range(audit, 0, 180, "Longitude")
    flaws <- attributes(audit)$assertr_errors

    id <- sample(3, 1)
    expect_equal(length(flaws), 3)
    expect_equal(flaws[[id]]$num.violations, 1)
    expect_equal(length(flaws[[id]]$error_df$value), 1)
    expect_match(flaws[[id]]$message, "Temp|Latitude|Longitude")
})

test_that("Auditing values in a set (specific integers)", {
    audit <- chk_in_set(testdata, 0:7, "Days")
    audit <- chk_in_set(audit, 0:24, "Hours")
    flaws <- attributes(audit)$assertr_errors

    id <- sample(2, 1)
    expect_equal(length(flaws), 2)
    expect_equal(flaws[[id]]$num.violations, 1)
    expect_equal(length(flaws[[id]]$error_df$value), 1)
    expect_match(flaws[[id]]$message, "Days|Hours")
})
