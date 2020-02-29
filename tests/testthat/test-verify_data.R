test_that("verify_colnames function works", {
    df1 <- data.frame("Protein" = "X", "State" = "Y", "Start" = 1, "End" = 2)
    df2 <- data.frame("Protein" = "X", "Start" = 1, "End" = 2)
    df3 <- data.frame()

    r1 <- list("is_ok" = TRUE, "error_messages" = NULL)
    r2 <- list("is_ok" = FALSE, "error_messages" = "State column is missing.")
    r3 <- list(
        "is_ok" = FALSE,
        "error_messages" = c(
            "Protein column is missing.", "State column is missing.",
            "Start column is missing.", "End column is missing."
        )
    )

    expect_equal(verify_colnames(df1), r1)
    expect_equal(verify_colnames(df2), r2)
    expect_equal(verify_colnames(df3), r3)
})


test_that("verify_column_types function works", {
    df1 <- data.frame("Start" = 1, "End" = 2)
    df2 <- data.frame("Start" = 1, "End" = letters)
    df3 <- data.frame("Start" = c(1, "a"), "End" = LETTERS)
    df4 <- data.frame()
    
    r1 <- list("is_ok" = TRUE, "error_messages" = NULL)
    r2 <- list("is_ok" = FALSE, "error_messages" = "Column End is not numeric.")
    r3 <- list(
        "is_ok" = FALSE,
        "error_messages" = c(
            "Column Start is not numeric.",
            "Column End is not numeric."
        )
    )
    r4 <- list("is_ok" = TRUE, "error_messages" = NULL)

    expect_equal(verify_column_types(df1), r1)
    expect_equal(verify_column_types(df2), r2)
    expect_equal(verify_column_types(df3), r3)
    expect_equal(verify_column_types(df4), r4)
})
