## IAO Reader

<!-- badges: start -->
[![Travis build status](https://travis-ci.com/tmakowski/iaoreader.svg?branch=master)](https://travis-ci.com/tmakowski/iaoreader)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/tmakowski/iaoreader?branch=master&svg=true)](https://ci.appveyor.com/project/tmakowski/iaoreader)
[![Codecov test coverage](https://codecov.io/gh/tmakowski/iaoreader/branch/master/graph/badge.svg)](https://codecov.io/gh/tmakowski/iaoreader?branch=master)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
<!-- badges: end -->

This is my masters thesis project at the [Faculty of Mathematics and Information Sciences](https://ww2.mini.pw.edu.pl) at the [Warsaw University of Technology](https://www.pw.edu.pl).

### Installation and Running the App
If one wishes to install the package it can be done as shown below.
```
# install.packages("remotes")
remotes::install_github("tmakowski/iaoreader")

iaoreader::run_shiny_app()
```

### Remarks
During the implementation following assumptions were made:

 * uploaded files have unique names,
 * the application will be started by `run_shiny_app` function, i.e. not directly with `shiny::runApp`.

