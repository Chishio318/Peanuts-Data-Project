# rm(list = ls())
Sys.setenv(LANG = "en_US.UTF-8") #set error message in English

devtools::update_packages(pkgs = TRUE)
renv::restore()

cat("\014")   ###clears console
if(!is.null(dev.list())) dev.off()

library("tidyverse")
tinytex::install_tinytex()
tinytex::tlmgr_install(c("collection-langgerman",
                         "collection-langjapanese",
                         "koma-script",
                         "enumitem", "setspace", "xpatch"))