###### v0.10.4 (2020-09-14):
 * Added basic modal.
 * Updated modal CSS.

###### v0.10.3 (2020-09-14):
 * Added invisible `actionButton` underneath the `info-circle` icon to facilitate communication with Shiny server.

###### v0.10.2 (2020-09-14):
 * Added `info-circle` icon to file upload label for later addition of information modal.

###### v0.10.1 (2020-09-14):
 * Moved `d3.min.js` to a separate directory.

###### v0.10.0 (2020-09-03):
 * This marks end of implementation of measure values on the plot.
 * Measure values now properly update when changing plot settings.
 * Turned off measure value display if it is undefined.
 * Changed the way height for measure values display is calculated to account for lines starting or ending within the segment.

###### v0.9.17 (2020-09-03):
 * Added segment measure values to the plot. This took some adjustments in already existing interfaces.

###### v0.9.16 (2020-09-03):
 * Fixed SVG download.

###### v0.9.15 (2020-09-03):
 * Updated the `draw_lambda_values` function to account for segment measure.

###### v0.9.14 (2020-09-02):
 * Added drag guides color selection to the plot settings.
 * Opacity style now will be properly added to the downloaded SVG.

###### v0.9.13 (2020-09-02):
 * Added JS interface for updating drag guides and area color.

###### v0.9.12 (2020-09-02):
 * Improved drag colored area creation.

###### v0.9.11 (2020-09-02):
 * Added colored area between the two drag ends.

###### v0.9.10 (2020-09-02):
 * Parametrized the time minimum time difference after which dragging starts.
 * Added check to not move drag ends if both start and end would end up on the same X-axis value.
 * Renamed `drag_t0` and `drag_start_time` to `click_timestamp`.

###### v0.9.9 (2020-09-02):
 * Added checks for time since clicking to differentiate dragging and single click.

###### v0.9.8 (2020-09-02):
 * Moved mouseover guide to top and on click guide right below it.
 * Fixed names of variables

###### v0.9.7 (2020-09-02):
 * Added drag vertical guides.
 * Made drawing lambda values optional to facilitate addition of drag vertical guides.

###### v0.9.6 (2020-09-02):
 * Reordered color options in plot settings.
 * Increased sidebar bottom padding.

###### v0.9.5 (2020-09-01):
 * Changed the background display option behavior. Now it is handled via visibility rather than setting color to `""`.
 * Now all elements - not only containers - with `visibility: hidden` won't be added to the SVG.

###### v0.9.4 (2020-09-01):
 * Replaced `svg` tag `background` attribute with appending a background `rect` to the SVG.

###### v0.9.3 (2020-09-01):
 * Elements with `visibility: hidden` won't be added to the SVG anymore.
 * Added `tags` to `.gitignore` and `.Rbuildignore`.

###### v0.9.2 (2020-08-30):
 * Moved the upload sample data button to be less prominent.
 * Added percent symbol to the summary table.
 * Added alignment to the summary table.

###### v0.9.1 (2020-08-30):
 * Changed the development data upload to sample data upload.
 * Updated CSS for the upload button.

###### v0.9.0 (2020-08-30):
 * This version marks end of development of all application's main functionalities.
 * Fixed overflow behavior in the summary table display.
 * Added debounce to the summary table update trigger in order to fix the table not being updated quickly enough.
 * Added column with file names to summary table.

###### v0.8.9 (2020-08-30):
 * Added summary table display.
 * Updated parsing function to convert to percent.

###### v0.8.8 (2020-08-30):
 * Added function for calculating summary table data to the IAOReader class.
 * Added Shiny handler for updating the plot.

###### v0.8.7 (2020-08-30):
 * Added function for parsing lambda values to a data.frame from a JSON.

###### v0.8.6 (2020-08-28):
 * Implemented SVG download.

###### v0.8.5 (2020-08-28):
 * Reduced maximum title font size to 48px.
 * Moved font size check to Shiny handler.

###### v0.8.4 (2020-08-28):
 * Removed uses of `dx` and `dy` attributes from lambda values. This will help with SVG export.

###### v0.8.3 (2020-08-28):
 * Changed the way the Y-axis ticks are not displayed.

###### v0.8.2 (2020-08-28):
 * Added button for downloading plot as an SVG - for now it's just a prop.

###### v0.8.1 (2020-08-28):
 * Adjusted top margins of **Coverage Plot** and **Summary Table** headers.

###### v0.7.23 (2020-08-28):
 * Added option to include k parameter in plot title.
 * Changed plot title setter to an update function.

###### v0.7.22 (2020-08-28):
 * Changed plot title updating to setter.

###### v0.7.21 (2020-08-28):
 * Added `redraw_vert` calls to Shiny handlers for options to update properly.

###### v0.7.20 (2020-08-28):
 * Added vertical offset to the lambda values so that they don't obstruct lines.
 * Reordered function calls within `move_vert` due to `move_lambda_values` using parameters set by `draw_text_bbox` called for axis label.

###### v0.7.19 (2020-08-28):
 * Added redrawing mouseover vertical guide on font change.
 * Reduced maximum X-axis font size to 26.
 * Increased `dy` attribute of vertical guides axis label to not overlap with the plot.

###### v0.7.18 (2020-08-27):
 * Added background boxes for vertical guide axis labels.
 * Added `iaoreader.redraw_vert` call to the font size handler to update text box size.

###### v0.7.17 (2020-08-27):
 * Reduced maximum X-axis font size to 30.
 * Moved value verification to Shiny handler.

###### v0.7.16 (2020-08-24):
 * Fixed an issue where lambda values would not reappear after setting update.
 * Fixed an issue where lambda values would not update after adjusting k parameter.
 * Added spacing between vertical guides and the lambda values.

###### v0.7.15 (2020-08-24):
 * Fixed lambda values not being removed after disabling showing them.

###### v0.7.14 (2020-08-24):
 * Fixed lambda values background color not updating on the persistent guide.

###### v0.7.13 (2020-08-22):
 * Added checkbox for inverting lambda values background.

###### v0.7.12 (2020-08-22):
 * Added lambda values box's color customization.

###### v0.7.11 (2020-08-22):
 * Added an option to disable displaying the lambda values.

###### v0.7.10 (2020-08-22):
 * Added box behind the lambda values displayed on the plot.
 * Excluded lambda values text from the font size adjustment in plot settings.

###### v0.7.9 (2020-08-22):
 * Added horizontal offset to the lambda values on the vertical guides.

###### v0.7.8 (2020-08-22):
 * Moved lambda measure values to the lowers line for the persistent vertical guide.

###### v0.7.7 (2020-08-22):
 * Added lambda measure values to the persistent vertical guide.

###### v0.7.6 (2020-08-15):
 * The lambda measure values are now displayed on the plot on mouseover.
 * Restricted IAOReader lambda method to account only for currently displayed files.

###### v0.7.5 (2020-08-15):
 * Added K penalty parameter customization to plot settings.

###### v0.7.4 (2020-08-15):
 * Implemented lambda measure methods for IAOReader class.

###### v0.7.3 (2020-08-15):
 * Implemented `lambda` and `lambda_segment` functions for single files.

###### v0.7.2 (2020-08-15):
 * Replaced `Remove` label with trash bin icon in the input summary table.

###### v0.7.1 (2020-08-15):
 * Adjusted plot title vertical placement.
 * Updated global CSS overflow and scrolling properties.

###### v0.7.0 (2020-08-15):
 * This version marks an end of implementation of plot settings regarding color and text properties of plot elements.
 * Added numericInput for customizing axes labels font size.
 * Added axes settings section to the plot settings.
 * Fixed vertical guides label placement.

###### v0.6.22 (2020-08-15):
 * Fixed ugly overflow of plot settings.
 * Improved input settings table handling of many files.
 * Removed outer padding of the sidebar.

###### v0.6.21 (2020-08-15):
 * Added font-weight switch between bold and normal for the plot title.

###### v0.6.20 (2020-08-15):
 * Added colorInput for title text color.

###### v0.6.19 (2020-08-15):
 * Added numericInput for title font size.
 * Added title font size verification before setting it.

###### v0.6.18 (2020-08-15):
 * Fixed colorInputs width.
 * Moved widths of inputs to a single variable for easier manipulation.
 * Unified case in plot settings subtitles.

###### v0.6.17 (2020-08-15):
 * Added title font size configuration interface to JS.

###### v0.6.16 (2020-08-15):
 * Incorporated plot_settings class functionalities into the IAOReader class.
 * Restructured `www/js` directory.

###### v0.6.15 (2020-08-15):
 * Added colorInputs for axes and axes labels.
 * Added default width to colorInput.

###### v0.6.14 (2020-08-15):
 * Added styling for the axes and their labels.
 * Added setters for setting these colors.

###### v0.6.13 (2020-08-15):
 * Added colorInputs for both mouseover and persistent vertical guides.
 * Changed default colors of the guides.

###### v0.6.12 (2020-08-15):
 * Fixed show background checkbox making the background disappear indefinitely.

###### v0.6.11 (2020-08-15):
 * TODOs and redundant functions clean-up.
 * Reducend data sent to JS to Start, End and FileName columns.

###### v0.6.10 (2020-08-15):
 * Implemented updateColorInput function to avoid code redundancy.

###### v0.6.9 (2020-08-15):
 * Added colorInput to facilitate further additions of this input type.

###### v0.6.8 (2020-08-15):
 * Improved background color setting implementation.

###### v0.6.7 (2020-08-15):
 * Added setters for vertical lines' colors.

###### v0.6.6 (2020-08-14):
 * Improved color plot settings arrangement and styling.

###### v0.6.5 (2020-08-14):
 * Added checkbox for toggling the plot's background.
 * Added initial color to the plot's background color input.

###### v0.6.4 (2020-08-14):
 * Added color input for plot background.

###### v0.6.3 (2020-08-14):
 * Increased top margin.
 * Removed unused JS script.
 * Added information about color palettes with URLs to palette update handler.

###### v0.6.2 (2020-08-14):
 * Added a selectInput for picking a color palette of choice.
 * Extended interface for plot settings generation to account for selectInputs.

###### v0.6.1 (2020-08-14):
 * Updated plot settings headers.

###### v0.6.0 (2020-08-14):
 * This version marks an end to vertical plot space optimization.
 * Extended interface for plot settings generation.
 * Used the updated interface for customizing the numericInput used for vertical offset between files.

###### v0.5.13 (2020-08-14):
 * Fixed vertical offset adjustment after testing with multiple files.

###### v0.5.12 (2020-08-14):
 * Added customization of the vertical spacing between files.

###### v0.5.11 (2020-08-14):
 * Added plot setting for choosing whether to optimize the plot vertically.
 * Added top margin to headers within plot settings.

###### v0.5.10 (2020-08-14):
 * Fixed Y-axis range being to wide.

###### v0.5.9 (2020-08-14):
 * Added function which adjusts height based on the calculated height differences and (hardcoded for now) offset.
 * Added assertion to previously implemented function.

###### v0.5.8 (2020-08-14):
 * Added function for calculating height differences between files on the plot.

###### v0.5.7 (2020-08-10):
 * Added development disclaimer to the title panel.

###### v0.5.6 (2020-08-09):
 * Added HTML title attribute to the `IAO Reader` in the title panel which indicates version of currently used application.

###### v0.5.5 (2020-08-09):
 * Extended title panel with GitHub project's URL.

###### v0.5.4 (2020-08-09):
 * Added sorting to the data preview.

###### v0.5.3 (2020-08-09):
 * Added title panel.

###### v0.5.2 (2020-08-09):
 * Updated Travis config.
 * This version marks start of differentiation between `master` and `devel` branches.

###### v0.5.1 (2020-08-09):
 * Continous delivery config update.

###### v0.5.0 (2020-08-09):
 * Added continuous delivery to the [shinyapps.io](https://www.shinyapps.io/).

###### v0.4.25 (2020-08-09):
 * Added `run_app` argument to `run_shiny_app` to allow deployment of the application to [shinyapps.io](https://www.shinyapps.io/).

###### v0.4.24 (2020-08-09):
 * Removed shinipsum hidden dependency.

###### v0.4.23 (2020-08-07):
 * Added information about maximum sequence length currently displayed to the Sequence Length section of the sidebar.

###### v0.4.22 (2020-08-01):
 * Updated CSS.

###### v0.4.21 (2020-07-31):
 * Added scrolling to the **Input Summary Table** when there are too many files.
 * Added page title.

###### v0.4.20 (2020-07-31):
 * Removed redundant functions used in the verification of the data.
 * Removed unused tests.

###### v0.4.19 (2020-07-29):
 * Fixed verification error messages.
 * Updated and extended tests.

###### v0.4.18 (2020-07-29):
 * Added type verification to `Protein` and `State` columns.

###### v0.4.17 (2020-07-17):
 * Added error handling to file reading.

###### v0.4.16 (2020-07-17):
 * Added `accept` parameter to the `fileInput` in the sidebar. Now the browser will suggest `.csv` data format.

###### v0.4.15 (2020-07-17):
 * Renamed `shiny_app` folder to `IAOReader` in the `inst` subdirectory.

###### v0.4.14 (2020-06-28):
 * Added ColorBrewer object for managing color palettes.
 * Implemented setter for color palettes.

###### v0.4.13 (2020-06-28):
 * Colors are only assigned to the displayed files now.
 * Removed `ColorId` - now lines get colored based on the file name.
 * Moved `color_pallette` to `plot_settings`.
 * Vertically centered checkboxes with CSS.

###### v0.4.12 (2020-06-28):
 * Added getter for currently displayed files to the JavaScript class.

###### v0.4.11 (2020-06-28):
 * Disabled Y axis ticks.
 * Added missing fonts.

###### v0.4.10 (2020-06-28):
 * Implemented the displayed file hiding in the JavaScript.

###### v0.4.9 (2020-06-28):
 * Prepared the R side for file display toggling.

###### v0.4.8 (2020-06-28):
 * Fixed observers from **Input Summary** table not being properly deleted. The list of observers was being reset before the observers were destroyed.

###### v0.4.7 (2020-06-28):
 * Extended input_ids in files input meta which were used in **Input Summary** table. This should solve some issues with overlapping input_ids.
 * Fixed if added in previous version.

###### v0.4.6 (2020-06-28):
 * Added button for uploading the development data usually used for testing.

###### v0.4.5 (2020-06-27):
 * Reorganised data flow in IAOReader. Now the data is filtered only once every plot redraw.

###### v0.4.4 (2020-06-27):
 * Moved the data preparation to IAOReader class method.

###### v0.4.3 (2020-06-21):
 * Fixed y axis value calculation by moving it to data filtering.

###### v0.4.2 (2020-06-21):
 * Added lines coloring by file.

###### v0.4.1 (2020-06-03):
 * Fixed the Plot Settings Reset button. It no longer tries to reset objects which are not meta elements.

###### v0.4.0 (2020-05-31):
 * This version has functional vertical guides (mouseover and on click).
 * Extended the plot settings generation interface to allow addition of manual shiny elements.

###### v0.3.19 (2020-05-31):
 * Added resetting of the guides to their initial state on data redraw.

###### v0.3.18 (2020-05-31):
 * Added a plot settings to toggle line marking by the vertical guides.

###### v0.3.17 (2020-05-30):
 * Added "snapping" to the `mark_lines` method effectively fixing lines not being marked although the vert was overlapping given line.

###### v0.3.16 (2020-05-30):
 * Added handler for resetting the mouseover vertical guide on svg mouse exit.

###### v0.3.15 (2020-05-30):
 * Added coloring lines to the persistent vertical guide.

###### v0.3.14 (2020-05-30):
 * Added coloring lines under the mouseover vertical guide.
 * Added unmark_lines function.
 * Removed changing `visibility` to `visible` on every `move_vert` call.

###### v0.3.13 (2020-05-30):
 * Changed single value margin to a separate value for each side.

###### v0.3.12 (2020-05-30):
 * Moved vertical guides colors to CSS variables.
 * Fixed starting position of the mouseover vert.

###### v0.3.11 (2020-05-30):
 * Added function for adding class to lines.

###### v0.3.10 (2020-05-29):
 * Added X axis value labels to vertical guides. Extended them to imitate axis ticks.
 * Parametrized vertical guides' colors.

###### v0.3.9 (2020-05-29):
 * Changed the vertical guides to actually be g tags containing lines. This will allow easier addition of labels.

###### v0.3.8 (2020-05-29):
 * Added persistent vertical guide appearing on click.
 * Added removal of the persistent guide on double click.
 * Renamed `mouse_in_svg` function to `mouse_out_of_bonds` to be more descriptive.

###### v0.3.7 (2020-05-29):
 * Parametrized the moved vert in moving functions.
 * Separated verts_g and vert creation for easier addition of new guides.
 * Added section headers to the IAOReader class.

###### v0.3.6 (2020-05-29):
 * Added utility functions for handling vertical guide and mouse.

###### v0.3.5 (2020-05-29):
 * Added `mousemove` handler for the vertical guide.
 * Renamed `draw_vert` to `move_vert` which is more appropriate.

###### v0.3.4 (2020-05-29):
 * Added rounding of X value to which the draw_vert method moves the vertical guide.
 * Moved declaration of attributes for the guide to constructor.

###### v0.3.3 (2020-05-29):
 * Cleaned-up JS classes constructors.

###### v0.3.2 (2020-05-29):
 * Added function for drawing vertical guide.
 * Added plot setting do disable the line.

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
 * Moved plot data transformation to endpoint responsible for updating it in IAOReader class object.

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
