## IAO Reader

<!-- badges: start -->
[![Travis build status](https://travis-ci.com/tmakowski/masters-thesis.svg?branch=master)](https://travis-ci.com/tmakowski/masters-thesis)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/tmakowski/masters-thesis?branch=master&svg=true)](https://ci.appveyor.com/project/tmakowski/masters-thesis)
[![Codecov test coverage](https://codecov.io/gh/tmakowski/masters-thesis/branch/master/graph/badge.svg)](https://codecov.io/gh/tmakowski/masters-thesis?branch=master)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
<!-- badges: end -->

### Installation and Running the App
If one wishes to install the package it can be done as shown below.
```
# install.packages("remotes")
remotes::install_github("tmakowski/masters-thesis")

iaoreader::run_shiny_app()
```

### Remarks
During the implementation following assumptions were made:

 * uploaded files have unique names.
