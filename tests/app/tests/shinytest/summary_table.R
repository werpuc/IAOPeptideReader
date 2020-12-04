app <- ShinyDriver$new("../../")
app$snapshotInit("summary_table")


# Preparation ------------------------------------------------------------------
output_list <- list(output = "summary_table")
k_parameters <- 1:10


# Testing ----------------------------------------------------------------------
app$setInputs(sample_upload = "click")
app$snapshot(output_list)

for (k in k_parameters) {
    app$setInputs(plot_settings_k_parameter = k)
    app$snapshot(output_list)
}
