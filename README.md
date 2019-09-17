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
- [ ] Gray out *Plot settings* tab before until input files are uploaded.
- [ ] Limit maximum number of files possible to upload (accordingly to the selected mode).
- [ ] File validation in multiple file mode.
- [ ] List uploaded files.
- [ ] Add summary table with coverage and other statistics (where to place it?).
- [ ] Report generation (embed JS plot, add summary table, create a template).
- [ ] Fix *scrollable* CSS class to expand nicely when element goes out of bonds.
- [ ] Keep values provided by user on UI layout changes.
- [ ] Add data preview with selectable files.
- [ ] Add column names' verification for received files.

### JavaScript
- [ ] Create a simple mock-up plot with customizable elements like: colors, axes labels, title etc.
- [ ] Develop a final plot version and implement it.
- [ ] Saving plot to `.svg` file.

### Thesis
- [ ] Describe input files -- meaning of the columns, what values do they contain.
