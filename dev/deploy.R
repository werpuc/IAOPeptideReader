# Script for running tests coverage and deploying the application to shinyapps.io
# on successful Travis build.
covr::codecov()

rsconnect::setAccountInfo(
    name = Sys.getenv("SHINYAPPS_NAME"),
    token = Sys.getenv("SHINYAPPS_TOKEN"),
    secret = Sys.getenv("SHINYAPPS_SECRET")
)

rsconnect::deployApp(
    appName = "iaoreader",
    forceUpdate = TRUE
)
