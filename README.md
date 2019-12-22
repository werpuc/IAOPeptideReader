## Master's thesis

This repository contains code which I have written for my master's thesis.
<ToDo: description>


### Repository structure
* **iaoreader** -- R package with standard structure.
    * **inst** -- folder containing files to be included with package. Notably:
        * **www** -- folder with JavaScript files and CSS theme.
* `README.md` -- this file.


### Task list
Updated: 2019-12-22

#### Implementation
- [ ] Describe app functionality with each version as the implementation progresses.
- [ ] Update `DESCRIPTION`:
    - [ ] title,
    - [ ] version (start versioning!),
    - [ ] description,
    - [ ] License (add `LICENSE` file!).
- [ ] Restructure repo:
    - [ ] update `.gitignore`,
    - [ ] update `.Rbuildignore`.
- [ ] App deployment step-by-step guide.
- [ ] Rewrite the UI and server with modules:
    - [ ] structure with main `ui.R` and `server.R` and rest of the files sourced with `source` (note: remember use `chdir` and `local` parameters!),
    - [ ] app file should be located in `inst` folder,
    - [ ] function in the package should start the server using files located in `inst` folder.
- [ ] Dependencies should contain `DT`, `data.table` and `shiny` for the time being.
- [ ] `Input settings` tab:
    - [ ] Handle file upload:
        - [ ] modify `fileInput` to allow only specified number of files when `multiple = TRUE`,
        - [ ] allow uploading files one by one (append to list of files instead of resetting it),
            - [ ] allow selecting only `<files upload limit> - <currently uploaded files>` in the `fileInput`;
        - [ ] allow multiple files with the same name,
            - [ ] differentiate them on the server side somehow,
            - [ ] ensure that when displaying the same names in UI they get something to distinguish them;
        - [ ] colum names verification (file should contain: `Protein`, `State`, `Start`, `End`),
        - [ ] separate "panel" for each upload:
            - [ ] allow deleting the files (delete from Shiny temp directory),
            - [ ] read sequence length from input files and save it in files meta information,
                - [ ] allow manual adjustment of the sequence length;
            - [ ] display current setting and originally read sequence length;
        - [ ] check input files whether there is more than one (protein, state) combination per file,
        - [ ] disable `Plot settings` until there are files uploaded (`shinyjs`).
- [ ] Functionalities:
    - [ ] uploaded files section with the panel for tuning settings (e.g. sequence length),
    - [ ] selecting protein for each file,
    - [ ] based on the protein: selecting state for each file,
    - [ ] data preview of selected file,
    - [ ] JS plot:
        - [ ] create canvas fitting the window,
        - [ ] update canvas when browser's window is resized,
        - [ ] add axes to the plot,
        - [ ] saving to `.svg`;
    - [ ] `Plot settings` tab:
        - [ ] separate handler for each setting:
            - change only the updated value and not redraw whole plot,
            - create multiple JS functions for handling this (one for updating each of the plot's attributes);
        - [ ] modify immideately after updating input (should be fast enough due to the separate handlers),
        - [ ] add options to modify:
            - [ ] title,
            - [ ] line color,
            - [ ] plot background,
            - [ ] ...
        - [ ] option to reset (confirmation?);
    - [ ] report generation:
        - [ ] create `.Rmd` template for it,
        - [ ] embbed JS plot,
        - [ ] add summary table;
    - [ ] summary table with statistics about each file:
        - [ ] good placement for it so that it can be viewed at the same time as the plot (detachable, lowered aplha?),
        - [ ] coverage statistic,
        - [ ] metric describing the steepness of the plot.
- [ ] Final touches and prettifying the app:
    - [ ] smoother elements' loading (`shinycssloaders`?),
    - [ ] fix the possible issues of `selectInputs` not extending over the edge of the box containing them (possible with CSS),
    - [ ] fix data preview `selectInput` to fit the file names,
    - [ ] delay plot display a little to avoid flashing all values of the files before they are filtered (even initially).
