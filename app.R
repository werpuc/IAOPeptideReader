# This file is used by the dev/deploy.R script.
pkgload::load_all(export_all = FALSE, helpers = FALSE, attach_testthat = FALSE)
iaoreader::run_shiny_app(run_app = FALSE)
