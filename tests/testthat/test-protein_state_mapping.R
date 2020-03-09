test_that("read_protein_state_mapping function works", {
    df1 <- data.frame(stringsAsFactors = FALSE, "Protein" = "P", "State" = "S")
    df2 <- data.frame(
        stringsAsFactors = FALSE,
        "Protein" = c("X", "Y", "Y", "Z"),
        "State" = c("A", "a", "a", "C")
    )
    df3 <- data.frame(
        stringsAsFactors = FALSE,
        "Protein" = c("X", "Y", "Y", "Z"),
        "State" = c("A", "a", "b", "C")
    )
    df4 <- data.table::as.data.table(df3)

    r1 <- list("P" = "S")
    r2 <- list("X" = "A", "Y" = "a", "Z" = "C")
    r3 <- list("X" = "A", "Y" = c("a", "b"), "Z" = "C")

    expect_equal(read_protein_state_mapping(df1), r1)
    expect_equal(read_protein_state_mapping(df2), r2)
    expect_equal(read_protein_state_mapping(df3), r3)
    expect_equal(read_protein_state_mapping(df4), r3)
})
