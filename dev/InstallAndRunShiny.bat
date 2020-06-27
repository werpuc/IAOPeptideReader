R CMD INSTALL --no-multiarch --with-keep.source .
Rscript -e "iaoreader::run_shiny_app()"
