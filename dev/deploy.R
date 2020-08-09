# Script for deploying application to shinyapps.io on successful Travis build.
pkgload::load_all(export_all = FALSE, helpers = FALSE, attach_testthat = FALSE)

rsconnect::setAccountInfo(
    name = Sys.getenv("SHINYAPPS_NAME"),
    token = Sys.getenv("SHINYAPPS_TOKEN"),
    secret = Sys.getenv("SHINYAPPS_SECRET")
)

rsconnect::deployApp(
    appName = "iaoreader",
    forceUpdate = TRUE
)
