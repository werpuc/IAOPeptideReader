# TODO: test_that("add_class argument validation works", {
#
# })


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
