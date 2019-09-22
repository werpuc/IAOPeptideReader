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
- [x] List uploaded files.
- [x] Add an example plot based on the uploaded data.
- [x] Fix ambiguities selectionInputs -- either append new ones with new files or store values, create all input fields (old & new) and restore values.
- [ ] Update package description.
- [ ] File names validation in multiple file mode.
- [ ] Columns' names verification for the received files (should contain: `Protein`, `State`, `Start`, `End`).
- [ ] Make loading elements smoother.
- [ ] Fiddle with fileInput settings to make it prettier.
- [ ] Limit maximum number of files possible to upload (accordingly to the selected mode). Reject an upload with files going over the limit and display appropriate message (gray out background and show it in a middle of a screen).
- [ ] Add an option to reset plot settings. Ask for confirmation before proceeding.
- [ ] Allow deletion of uploaded files -- select which ones should be deleted (integrate with upload list?).
- [ ] Add summary table with coverage and other statistics (detachable, hideable?).
- [ ] Report generation (embed JS plot, add summary table, create a template).
- [ ] Fix `scrollable` CSS class to expand nicely when element goes out of bonds.
- [ ] Fix file preview selectInput width to fit the choices.
- [ ] Fix glitch where whole (unfiltered by protein/state) data appears on the plot after upload.
- [ ] Limit files number *before* the upload.

### JavaScript
- [x] Create a simple mock-up plot with customizable elements like: colors, axes labels, title etc.
- [ ] Develop a final plot version and implement it.
- [ ] Saving plot to `.svg` file.

### Thesis
- [ ] Describe input files -- meaning of the columns, what values do they contain.
