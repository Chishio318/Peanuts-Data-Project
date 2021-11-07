# rm(list = ls())
Sys.setenv(LANG = "en_US.UTF-8") #set error message in English

devtools::update_packages(pkgs = TRUE)
renv::restore()

cat("\014")   ###clears console
if(!is.null(dev.list())) dev.off()