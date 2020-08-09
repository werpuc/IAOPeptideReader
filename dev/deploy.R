# Script for deploying the application to shinyapps.io.
rsconnect::setAccountInfo(
    name = Sys.getenv("SHINYAPPS_NAME"),
    token = Sys.getenv("SHINYAPPS_TOKEN"),
    secret = Sys.getenv("SHINYAPPS_SECRET")
)

rsconnect::deployApp(
    appName = "iaoreader",
    forceUpdate = TRUE
)
