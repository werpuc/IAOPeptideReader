app <- ShinyDriver$new("../../")
app$snapshotInit("input_summary_table", screenshot = FALSE)


# Testing ----------------------------------------------------------------------
app$setInputs(sample_upload = "click")
app$snapshot()

app$setInputs(`IS_row_example_data1.csv_state` = "state1")
app$snapshot()

app$setInputs(`IS_row_example_data1.csv_display` = FALSE)
app$snapshot()

app$setInputs(`IS_row_example_data2.csv_protein` = "protein2")
app$snapshot()

app$setInputs(`IS_row_example_data1.csv_remove` = "click")
app$snapshot()

app$setInputs(`IS_row_example_data2.csv_protein` = "protein1")
app$snapshot()

app$setInputs(`IS_row_incorrect_data1.csv_remove` = "click")
app$snapshot()
