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
