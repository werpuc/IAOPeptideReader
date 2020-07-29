test_that("verify_iao_data function works", {
    options(stringsAsFactors = FALSE)

    df1 <- data.frame("Protein" = "X", "State" = "Y", "Start" = 1, "End" = 2)
    df2 <- data.frame("Protein" = "X", "State" = "Y", "Start" = 1, "End" = "b")
    df3 <- data.frame("Protein" = "X", "Start" = "a", "End" = 2)
    df4 <- data.frame("Start" = "a")
    df5 <- data.frame()
    df6 <- data.frame("Protein" = 1, "State" = "Y", "Start" = 1, "End" = 2)
    df7 <- data.frame("Protein" = NA, "State" = 2, "Start" = 1, "End" = 2)
    df8 <- data.frame("Protein" = 1, "State" = NA, "Start" = 1, "End" = NA)
    df9 <- data.frame("Protein" = "X", "State" = "Y", "Start" = 1, "End" = c(2, NA))

    r1 <- list("is_ok" = TRUE, "error_messages" = NULL)
    r2 <- list(
        "is_ok" = FALSE,
        "error_messages" = "'End' column is not numeric."
    )
    r3 <- list(
        "is_ok" = FALSE,
        "error_messages" = c(
            "'State' column is missing.",
            "'Start' column is not numeric."
        )
    )
    r4 <- list(
        "is_ok" = FALSE,
        "error_messages" = c(
            "'Protein' column is missing.", "'State' column is missing.",
            "'End' column is missing.", "'Start' column is not numeric."
        )
    )
    r5 <- list(
        "is_ok" = FALSE,
        "error_messages" = c(
            "'Protein' column is missing.", "'State' column is missing.",
            "'Start' column is missing.", "'End' column is missing."
        )
    )
    r6 <- list(
        "is_ok" = FALSE,
        "error_messages" = "'Protein' column is not character."
    )
    r7 <- list(
        "is_ok" = FALSE,
        "error_messages" = c(
            "'Protein' column is not character.",
            "'Protein' column contains missing (empty) values.",
            "'State' column is not character."
        )
    )
    r8 <- list(
        "is_ok" = FALSE,
        "error_messages" = c(
            "'Protein' column is not character.",
            "'State' column is not character.",
            "'State' column contains missing (empty) values.",
            "'End' column is not numeric.",
            "'End' column contains missing (empty) values."
        )
    )
    r9 <- list(
        "is_ok" = FALSE,
        "error_messages" = "'End' column contains missing (empty) values."
    )

    expect_equal(verify_iao_data(df1), r1)
    expect_equal(verify_iao_data(df2), r2)
    expect_equal(verify_iao_data(df3), r3)
    expect_equal(verify_iao_data(df4), r4)
    expect_equal(verify_iao_data(df5), r5)
    expect_equal(verify_iao_data(df6), r6)
    expect_equal(verify_iao_data(df7), r7)
    expect_equal(verify_iao_data(df8), r8)
    expect_equal(verify_iao_data(df9), r9)
})


test_that("verify_colnames function works", {
    df1 <- data.frame("Protein" = "X", "State" = "Y", "Start" = 1, "End" = 2)
    df2 <- data.frame("Protein" = "X", "Start" = 1, "End" = 2)
    df3 <- data.frame()

    r1 <- list("is_ok" = TRUE, "error_messages" = NULL)
    r2 <- list("is_ok" = FALSE, "error_messages" = "'State' column is missing.")
    r3 <- list(
        "is_ok" = FALSE,
        "error_messages" = c(
            "'Protein' column is missing.", "'State' column is missing.",
            "'Start' column is missing.", "'End' column is missing."
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
    df5 <- data.frame("Start" = 1:2, "End" = c(3, NA))
    
    r1 <- list("is_ok" = TRUE, "error_messages" = NULL)
    r2 <- list(
        "is_ok" = FALSE,
        "error_messages" = "'End' column is not numeric."
    )
    r3 <- list(
        "is_ok" = FALSE,
        "error_messages" = c(
            "'Start' column is not numeric.",
            "'End' column is not numeric."
        )
    )
    r4 <- list("is_ok" = TRUE, "error_messages" = NULL)
    r5 <- list(
        "is_ok" = FALSE,
        "error_messages" = "'End' column contains missing (empty) values."
    )

    expect_equal(verify_column_types(df1), r1)
    expect_equal(verify_column_types(df2), r2)
    expect_equal(verify_column_types(df3), r3)
    expect_equal(verify_column_types(df4), r4)
    expect_equal(verify_column_types(df5), r5)
})
