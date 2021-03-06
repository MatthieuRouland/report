if (require("testthat")) {
  data(iris)
  test_that("report.htest", {
    # Correlations
    r <- report(cor.test(iris$Sepal.Width, iris$Sepal.Length))
    expect_equal(as.report_table(r)$r, -0.117, tol = 0.01)
    r <- report(cor.test(iris$Sepal.Width, iris$Sepal.Length, method = "spearman"))
    expect_equal(as.report_table(r)$rho, -0.166, tol = 0.01)
    r <- report(cor.test(iris$Sepal.Width, iris$Sepal.Length, method = "kendall"))
    expect_equal(as.report_table(r)$tau, -0.077, tol = 0.01)

    # t-tests
    r <- report(t.test(iris$Sepal.Width, iris$Sepal.Length, var.equal = TRUE))
    expect_equal(as.report_table(r, summary = TRUE)$Difference, -2.786, tol = 0.01)
    r <- report(t.test(iris$Sepal.Width, iris$Sepal.Length))
    expect_equal(as.report_table(r, summary = TRUE)$Difference, -2.786, tol = 0.01)
    r <- report(t.test(mtcars$mpg ~ mtcars$vs))
    expect_equal(as.report_table(r, summary = TRUE)$Difference, 7.9404, tol = 0.01)
    r <- report(t.test(iris$Sepal.Width, mu = 1))
    expect_equal(as.report_table(r, summary = TRUE)$Difference, 2.057, tol = 0.01)
  })

  test_that("report.htest - manual inspection", {
    # Correlations
    r <- report(cor.test(iris$Sepal.Width, iris$Sepal.Length))
    expect_true(grepl("r = -0.12, 95% CI [-0.27, 0.04], t(148) = -1.44, p = 0.152", r, fixed = TRUE))
    r <- report(cor.test(iris$Sepal.Width, iris$Sepal.Length, method = "spearman"))
    expect_true(grepl("rho = -0.17, S = 6.56e+05, p < .05", r, fixed = TRUE))
    r <- report(cor.test(iris$Sepal.Width, iris$Sepal.Length, method = "kendall"))
    expect_true(grepl("tau = -0.08, z = -1.33, p = 0.183", r, fixed = TRUE))

    # t-tests
    # r <- report(t.test(iris$Sepal.Width, iris$Sepal.Length, var.equal = TRUE))
    # expect_true(grepl("r = -0.12, 95% CI [-0.27, 0.04], t(148) = -1.44, p = 0.152", r, fixed=TRUE))
    # r <- report(t.test(iris$Sepal.Width, iris$Sepal.Length))
    # expect_true(grepl("r = -0.12, 95% CI [-0.27, 0.04], t(148) = -1.44, p = 0.152", r, fixed=TRUE))
    # r <- report(t.test(mtcars$mpg ~ mtcars$vs))
    # expect_true(grepl("r = -0.12, 95% CI [-0.27, 0.04], t(148) = -1.44, p = 0.152", r, fixed=TRUE))
    # r <- report(t.test(iris$Sepal.Width, mu = 1))
    # expect_true(grepl("r = -0.12, 95% CI [-0.27, 0.04], t(148) = -1.44, p = 0.152", r, fixed=TRUE))
  })
}
