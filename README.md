## IAO Reader

<!-- badges: start -->
[![Travis build status](https://travis-ci.org/tmakowski/masters-thesis.svg?branch=master)](https://travis-ci.org/tmakowski/masters-thesis)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/tmakowski/masters-thesis?branch=master&svg=true)](https://ci.appveyor.com/project/tmakowski/masters-thesis)
[![Codecov test coverage](https://codecov.io/gh/tmakowski/masters-thesis/branch/master/graph/badge.svg)](https://codecov.io/gh/tmakowski/masters-thesis?branch=master)
<!-- badges: end -->

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
