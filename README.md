## IAO Reader

### Running the App
The simplest way to try the application is running it directly from GitHub.
```
# install.packages("shiny")
shiny::runGitHub("tmakowski/masters-thesis", subdir = "inst/shiny_app")
```

If one wishes to install the package before starting the application it can be done as shown below.
```
# install.packages("remotes")
remotes::install_github("tmakowski/masters-thesis")

iaoreader::run_shiny_app()
```

### Remarks
During the implementation following assumptions were made:

 * uploaded files have unique names.
