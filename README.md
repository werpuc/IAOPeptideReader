# Master's thesis

This repository contains code which I have written for my master's thesis.
<ToDo: description>


## Repository structure
* **iaoreader** -- R package with standard structure.
    * **inst** -- folder containing files to be included with package. Notably:
        * **www** -- folder with JavaScript files and CSS theme.
* `README.md` -- this file.


## Task list
### R 
- [x] Create an application layout mock-up.
- [x] Add an integration and pass customization parameters from R to the JS plot.
- [x] "Append" newly uploaded files instead of substituting the whole list.
- [x] Read sequence length from input files. Keep the value somewhere to inform user what was read from the files.
- [x] Check input files whether there is more than one protein and state combination per file.
- [x] Gray out *Plot settings* tab before until input files are uploaded.
- [x] Add data preview with selectable files.
- [x] Keep values provided by user on UI layout changes.
- [ ] Add an option to reset plot settings. Keep the settings in reactive and defaults in dedicated function.
- [ ] Gray out `Update plot` button if the settings did not change.
- [ ] List uploaded files.
- [ ] Allow deletion of uploaded files -- select which ones should be deleted (interate with upload list).
- [ ] Limit maximum number of files possible to upload (accordingly to the selected mode). Reject an upload with files going over the limit and display appropriate message.
- [ ] Fix ambiguities selectionInputs -- either append new ones with new files or store values, create all input fields (old & new) and restore values.
- [ ] Add an example plot based on the uploaded data.
- [ ] Add summary table with coverage and other statistics (where to place it?).
- [ ] File names validation in multiple file mode.
- [ ] Column names' verification for received files. Sort uploaded data by (Start, End, Protein, State).
- [ ] Report generation (embed JS plot, add summary table, create a template).
- [ ] Fix *scrollable* CSS class to expand nicely when element goes out of bonds.
- [ ] Limit files number *before* the upload.

### JavaScript
- [ ] Create a simple mock-up plot with customizable elements like: colors, axes labels, title etc.
- [ ] Develop a final plot version and implement it.
- [ ] Saving plot to `.svg` file.

### Thesis
- [ ] Describe input files -- meaning of the columns, what values do they contain.
