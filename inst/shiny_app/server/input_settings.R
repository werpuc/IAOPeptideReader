input_settings <- function(input, output, session) {
    observeEvent(input[["file_upload"]], {
        print(input[["file_upload"]])

        # TODO: for every file:
        #       1. read every file
        #       2. check it's structure
        #       3. add meta information to the others
        #       4. if the file has correct structure:
        #           a) save the data
        #           b) save (protein, state) mapping
        #           c) create observers
    })    
}
