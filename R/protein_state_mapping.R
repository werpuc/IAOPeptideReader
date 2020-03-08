read_protein_state_mapping <- function(df) {
    pairs_df <- unique(df[, c("Protein", "State")])

    res <- list()
    for (protein in pairs_df[["Protein"]]) {
        res[[protein]] <- pairs_df[pairs_df[["Protein"]] == protein, "State"]
    }

    res
}
