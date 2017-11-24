context("Audit report")

n <- 5
testdata <- data.frame(
    Hours = c(sample(1:24, n), 25),
    Days = c(sample(1:7, n), 8),
    Months = c(sample(1:12, n), 13),
    Temp = c(runif(n, -30, 30), 2000),
    Latitude = c(runif(n, 0, 90), 100),
    Longitude = c(runif(n, 0, 180), 190)
)

test_that("Audit report generated", {
    audit <- chk_in_range(testdata, 0, Inf, "Latitude")
    expect_message(aud_report(audit), "found no flaws")

    audit <- chk_in_range(audit, 0, 24, "Hours")
    audit <- chk_in_set(audit, 0:7, "Days")
    report <- aud_report(audit)
    expect_identical(report$Column, c("Hours", "Days"))
    expect_equal(report$Fails, c(1, 1))
    expect_equal(report$Values, c("25", "8"))
    expect_equal(report$RowNum, c("6", "6"))
})

