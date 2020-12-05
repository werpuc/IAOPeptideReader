R CMD INSTALL --no-multiarch --with-keep.source .
Rscript -e "IAOPeptideReader::run_shiny_app()"
