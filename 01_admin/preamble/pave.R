# rm(list = ls())
Sys.setenv(LANG = "en_US.UTF-8") #set error message in English

cat("\014")   #clears console
if(!is.null(dev.list())) dev.off()  #clear figures

renv::restore() #update package lists

library("tidyverse")