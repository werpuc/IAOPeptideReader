###### v0.3.1 (2020-05-29):
 * Fixed the overextending Y axis.

###### v0.3.0 (2020-05-29):
 * Now the plot data is filtered solely by the JS. This marks an end of rewriting old code into proper JS classes.
 * Removed the updater of plot settings as they should be handler properly now.

###### v0.2.37 (2020-05-29):
 * Rewritten y_scale to be created by IAOReader class.
 * Removed redundant variables and attributes.
 * Updated the checks for whether the data has been already passed to the IAOReader class object.

###### v0.2.36 (2020-05-29):
 * Moved IAOReader.plot_data to plot_data_raw and added filtered data as IAOReader.plot_data getter.

###### v0.2.35 (2020-05-29):
 * Moved plot data transformation to endpoint reponsible for updating it in IAOReader class object.

###### v0.2.34 (2020-05-29):
 * The plot data is now stored in the IAOReader object.

###### v0.2.33 (2020-05-29):
 * Split handler which sent data and seq length into two.

###### v0.2.32 (2020-05-29):
 * Moved Shiny handlers to a single file.

###### v0.2.31 (2020-05-29):
 * Rewritten x_scale to be created by IAOReader class.

###### v0.2.30 (2020-05-29):
 * Moved creation of g tags for X and Y axes and lines to IAOReader constructor.

###### v0.2.29 (2020-05-29):
 * Moved plot data drawing to IAOReader class.

###### v0.2.28 (2020-05-29):
 * Created `www/js/classes` directory and adjusted sourcing in `ui.R`.

###### v0.2.27 (2020-05-29):
 * Added PlotSettings class for managing configurable plot elements.
 * Rewritten the plot title to utilize this class.
 * Moved plot title handler file to `plot_settings.js` due to rather brief nature of the handlers.

###### v0.2.26 (2020-05-27):
 * Moved the creation of IAOReader class object to a Shiny handler. This way the svg can be created in class' constructor which in turn allows to reduce amount of workarounds.
 * Removed the plot title fix as it is no longer necessary.

###### v0.2.25 (2020-05-27):
 * Implemented IAOReader JS class for better handling of the application.
 * Rewritten svg canvas creation to use the IAOReader class.
 * Added temporary fix for plot title which is created too early.

###### v0.2.24 (2020-05-27):
 * Centered the plot title.

###### v0.2.23 (2020-05-27):
 * Reorganized scripts in the `www` subdirectory.
 * Updated **Plot Settings** mapping to include `input_id` provided by hand.
 * Changed the way scripts and CSS are attached.

###### v0.2.22 (2020-05-23):
 * Fixed plot by adding y offset to data transformation.

###### v0.2.21 (2020-05-23):
 * Changing the sequence length is now tied to data redrawing.
 * Moved X axis creation to plot updating.

###### v0.2.20 (2020-05-23):
 * Added wonky data plotting.

###### v0.2.19 (2020-05-23):
 * Added drawing of Y axis to plot data updater.
 * Increased margin.
 * Moved plot title.
 * Added early stops to the plot handlers if the plot does not exist yet.

###### v0.2.18 (2020-05-23):
 * Added handler for drawing X axis of the plot.

###### v0.2.17 (2020-05-23):
 * Added `_x`, `_y`, and `_margin` attributes to the svg to parametrize those values throughout the plot.

###### v0.2.16 (2020-05-23):
 * Split `utils.R` into separate files.

###### v0.2.15 (2020-05-23):
 * Updated JS files style.
 * Changed svg removal to a check before creation.

###### v0.2.14 (2020-05-23):
 * The JS plot is now deleted on data upload before appending a new one.
 * Reduced the amount of data sent to JS to only unique records.

###### v0.2.13 (2020-03-20):
 * Implemented plot title updater handler.
 * Added forced update for all **Plot Settings** after the new filtered data is plotted.
 * Set `suspendWhenHidden` to `FALSE` for the **Plot Settings** `uiOutput`. This allows the UI and server generator create it before the user visits the **Plot Settings** tab which is crucial for proper application of the settings.
 * Fixed typo in `plot.js`.

###### v0.2.12 (2020-03-20):
 * Hidden **Plot Settings** until a correct file is uploaded.

###### v0.2.11 (2020-03-20):
 * Changed `splitLayout` in **Sequence Length** to a manual split layout to improve formatting.
 * Added text wrapping to the maximum sequence length output.

###### v0.2.10 (2020-03-20):
 * Added handler for creating an empty canvas for the plot.
 * Created mock handler for updating the data on the plot.

###### v0.2.9 (2020-03-19):
 * Added `d3.min.js` script.
 * Changed the mock plot to an empty div for the real plot.

###### v0.2.8 (2020-03-18):
 * Updated **Sequence Length** section CSS and alignment.

###### v0.2.7 (2020-03-17):
 * Updated **Input Summary Table** CSS:
    * Added alternating colors to the table rows.
    * Removed unnecessary margins from the selectInputs.
    * Shrunk the buttons.
    * Moved the header row width settings to the CSS file.
    * Updated header padding.
    * Shortened `Sequence Length` to `Seq. Length`.
    * Replaced button's error hover tooltip with a proper one.

###### v0.2.6 (2020-03-17):
 * Updated **Input Summary Table** CSS:
    * Changed colour of error rows.
    * Improved coloring of header row.
    * Added padding to the cells.
    * Aligned text cells.
    * Handled text overflow in text cells.
    * Added mouseover hints for file names (to show full name when truncated).
    * Removed empty header cell from over the buttons.

###### v0.2.5 (2020-03-17):
 * Disabled selectInput creation for the wrong files.

###### v0.2.4 (2020-03-14):
 * Added sequence length verification and mouseover information.

###### v0.2.3 (2020-03-14):
 * Moved `data_preview.R` sourcing to the file which calls `data_preview` module.
 * Added file sourcing summary for the application.

###### v0.2.2 (2020-03-14):
 * Renamed buttons in **Input Summary Table** to not suggest that user's file will be deleted from their system.

###### v0.2.1 (2020-03-11):
 * Added resetting of the observers list within `input_settings_rv` on a new file upload.
 * Updated `TODO.md`.

###### v0.2.0 (2020-03-11):
 * The data is now saved only for correct files.
 * The saved data now includes only the columns used by the app.
 * Connected **Data Preview** to the uploaded files.
 * Added placeholders for when there is no file uploaded.
 * This update marks the end of file management and settings development as well as **Data Preview** tab implementation. However, the CSS for the **Input Summary Table** and styling of **Data Preview** table are yet to be improved.

###### v0.1.28 (2020-03-10):
 * Improved the way the maximum sequence length is handled.

###### v0.1.27 (2020-03-10):
 * Deletion handler now properly deletes data associated with the file.
 * Added data preparation for passing it over to the JS.

###### v0.1.26 (2020-03-10):
 * Improved saving the files meta information to `input_settings_rv` and added saving of the data to that structure.
 * Minor other improvements.

###### v0.1.25 (2020-03-10):
 * Handled case when all files are deleted through the **Input Files Summary** table.
 * Improved setting the protein and state during **Input Files Summary** table UI creation.

###### v0.1.24 (2020-03-10):
 * Fixed the bug of observers not being deleted mentioned in previous change log entry.
 * Removed redundant `codecov.yml` configuration file.

###### v0.1.23 (2020-03-10):
 * Changed `files_meta` to a `reactiveVal` to support deleting objects from it.
 * Implemented delete button handler in the server function generator.
 * Added preserving of the selected values through the deletions.
 * **Note:** current version contains a bug where the observers aren't deleted properly on new files upload. 

###### v0.1.22 (2020-03-09):
 * Updated the data for the **Input Files Summary** testing.
 * Implemented server function generation with select input updaters for the **Input Files Summary**.

###### v0.1.21 (2020-03-09):
 * Fixed the `read_protein_state_mapping` function for `data.table` arguments added tests for the this case.

###### v0.1.20 (2020-03-09):
 * Added automatic updating of the sequence length input when the files are uploaded.
 * Added `req` to in the maximum sequence length reactive to avoid calculation when there is no correct file uploaded.

###### v0.1.19 (2020-03-09):
 * Improved handling of the wrong files in the sidebars. Now the UI is more informative about the issues.

###### v0.1.18 (2020-03-09):
 * Added wrapper for attaching scripts.
 * Restructured the `run_shiny_app` function to source the files in `inst` folder. This fixes the bug (or rather namespace issue) where package's imported functions are not found by the Shiny application.
 * Reordered CSS file a little.

###### v0.1.17 (2020-03-08):
 * Added a function for reading the `(protein, state)` mapping.
 * Updated badges in `README.md` after renaming the repository.

###### v0.1.16 (2020-03-08):
 * Fixed handling `NA` values in the `verify_column_types` function.

###### v0.1.15 (2020-03-02):
 * Added sequence length calculation for each file.
 * Updated the mock information about maximum sequence length to be a value read from input files.

###### v0.1.14 (2020-03-02):
 * Hidden everything but the file upload input until a file is uploaded.

###### v0.1.13 (2020-03-02):
 * Added data (including few incorrect files) for testing the application during the development.
 * Minor update in `README.md`.

###### v0.1.12 (2020-03-02):
 * Added mouseover hint with error messages on rows with incorrect inputs in the Input Summary table.

###### v0.1.11 (2020-03-02):
 * Moved Input Summary table generation to the server function.
 * Implemented function generating single Input Summary table's row UI.

###### v0.1.10 (2020-03-02):
 * Updated `README.md` and excluded option to run directly from GitHub (the imported packages would not be loaded).
 * Fixed misspells in the file upload handler.

###### v0.1.9 (2020-03-02):
 * Fixed few typos and variable names.
 * Changed Travis notifications frequency.
 * Added license badge.

###### v0.1.8 (2020-03-02):
 * Implemented the `vefify_iao_data` function and added tests.
 * Updated the error messages returned by the two subfunctions of the above function.
 * Updated the `.travis.yml` file with lines which should prevent the build from failing on OSX with R 3.4.

###### v0.1.7 (2020-02-29):
 * Implemented the `verify_column_types` function and added tests.

###### v0.1.6 (2020-02-29):
 * Implemented the `verify_colnames` function and added tests.

###### v0.1.5 (2020-02-29):
 * Added reactive for holding files meta information which have not been fully implemented yet.
 * Added functions signatures for verifying IAO file's correctness.

###### v0.1.4 (2020-02-28):
 * Added documentation.
 * Updated `NAMESPACE` to not override imports.

###### v0.1.3 (2020-02-28):
 * Added license.
 * Added Travis.
 * Added Appveyor.
 * Added code coverage.
 * Removed finished points from the `TODO.md`.

###### v0.1.2 (2020-02-28):
 * Created server file for **Input Settings** with mock fileInput handler and an outline of the handler which will be implemented.
 * Added `Remarks` section to the `README.md`.

###### v0.1.1 (2020-02-28):
 * Added function for extending an objects class by reference.
 * Added tests for the above function.
 * The above two changes resulted in adding a new import (`data.table`) and a new suggestion (`testthat`).

###### v0.1.0 (2020-02-27):
 * Merged `refactoring-from-scratch` branch into `master` and cleaned up after the merge.

###### v0.0.16 (2020-02-26):
 * Moved single element CSS to the element definition.
 * Added some sidebar global CSS.
 * Added full **Input Settings** tab mock UI.

###### v0.0.15 (2020-02-25):
 * Added default values to the input mapping.
 * Added button for resetting plot settings to default.

###### v0.0.14 (2020-02-24):
 * Moved inputs generation for the **Plot Settings** tab to the server function.
 * Moved the input mapping to a reactive inside the server function.
 * Created basic connection from R server function to JS.

###### v0.0.13 (2020-02-24):
 * Added wrapper for creating plot settings inputs.
 * Added `chdir` argument to `source` calls.
 * Finished variables, functions and files names refactoring.

###### v0.0.12 (2020-02-24):
 * Added tabs to the sidebar panel.

###### v0.0.11 (2020-02-23):
 * Added `DT` package as an import.
 * Created mock `DT` table in the **Data Preview** tab.

###### v0.0.10 (2020-02-23):
 * Renamed files names to match the function naming convention.
 * Split out a part of `server.R` in preparation for multiple file structure.

###### v0.0.9 (2020-02-23):
 * Added ids to main panel and sidebar panel for easy distinguishing main panel from sidebar panel in CSS.
 * Added side padding to main panel contents.

###### v0.0.8 (2020-02-13):
 * Added `selectInput` with mock choices for selecting file for preview.
 * Updated CSS of the main panel and the newly added `selectInput`.

###### v0.0.7 (2020-02-12):
 * Updated functions naming convention.
 * Added `tabsetPanel` and tabs to the main panel.
 * Added mock summary table to the **Peptide Coverage** tab.

###### v0.0.6 (2020-02-12):
 * Moved main panel and sidebar panel objects to function to allow top-bottom structure of the scripts.
 * Added `shinipsum` as a requirement for development.
 * Created a plot output for the application's main plot.

###### v0.0.5 (2020-02-12):
 * Fixed an issue with UI using function defined below the UI definition.

###### v0.0.4 (2020-02-12):
 * Created structure for sidebar page.
 * Extender folder structure in preparation for UI development.
 * Attached [HaDeX](https://github.com/hadexversum/HaDeX) theme.
 * Fixed typo in `README.md`.

###### v0.0.3 (2020-02-11):
 * Added a simple CSS theme.
 * Created `README.md` with installation instructions and updated `.Rbuildignore`.

###### v0.0.2 (2020-02-11):
 * Added a simple application with one output filled out in the server function.
 * Added exported function `run_shiny_app` to run the application located inside package's files.

###### v0.0.1 (2020-02-06):
 * Updated the `TODO.md` list with further plan for the development.

###### v0.0.0 (2020-02-06):
 * Created an empty package's structure from scratch.
