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
