test_that("add_class function works", {
    x1 <- c(1, 2, 3)
    x2 <- letters
    x3 <- data.table::data.table(x = 1:2, y = 3:4)

    r1 <- add_class(x1, "new_class1")
    r2 <- add_class(x2, "new_class2", FALSE)
    r3 <- add_class(x3, "new_class3")

    expect_equal(class(r1), c("new_class1", "numeric"))
    expect_equal(class(r2), c("character", "new_class2"))
    expect_equal(class(r3), c("new_class3", "data.table", "data.frame"))
})


test_that("is_positive_integer function works", {
    x1 <- 1
    x2 <- 100
    x3 <- 1.3
    x4 <- NA
    x5 <- NULL
    x6 <- FALSE
    x7 <- 0

    r1 <- TRUE
    r2 <- TRUE
    r3 <- FALSE
    r4 <- FALSE
    r5 <- FALSE
    r6 <- FALSE
    r7 <- FALSE

    expect_equal(is_positive_integer(x1), r1)
    expect_equal(is_positive_integer(x2), r2)
    expect_equal(is_positive_integer(x3), r3)
    expect_equal(is_positive_integer(x4), r4)
    expect_equal(is_positive_integer(x5), r5)
    expect_equal(is_positive_integer(x6), r6)
    expect_equal(is_positive_integer(x7), r7)
})
