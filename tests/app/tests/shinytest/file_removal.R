app <- ShinyDriver$new("../../")
app$snapshotInit("file_removal", screenshot = FALSE)


# File paths preparation -------------------------------------------------------
data_dir <- "data/"
correct_files <- paste0(data_dir, sprintf("example_data%d.csv", 1:2))
incorrect_files <- paste0(data_dir, sprintf("incorrect_data%d.csv", 1:3))


# Testing ----------------------------------------------------------------------
app$uploadFile(files_upload = c(correct_files, incorrect_files))
app$snapshot()

app$setInputs(`IS_row_example_data1.csv_remove` = "click")
app$snapshot()

app$setInputs(`IS_row_example_data2.csv_remove` = "click")
app$snapshot()

app$uploadFile(files_upload = c(correct_files, incorrect_files))
app$snapshot()

app$setInputs(`IS_row_incorrect_data1.csv_remove` = "click")
app$snapshot()

app$setInputs(`IS_row_incorrect_data2.csv_remove` = "click")
app$snapshot()

app$setInputs(`IS_row_incorrect_data3.csv_remove` = "click")
app$snapshot()

app$uploadFile(files_upload = correct_files)
app$snapshot()

app$setInputs(`IS_row_example_data1.csv_remove` = "click")
app$snapshot()

app$setInputs(`IS_row_example_data2.csv_remove` = "click")
app$snapshot()
