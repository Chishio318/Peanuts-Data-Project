main <- function(){
  set_error_to_English()
  clear_environment()
  prepare_packages()
}


set_error_to_English <- function(){
  Sys.setenv(LANG = "en_US.UTF-8") 
}


clear_environment <- function(){
  cat("\014")   # console
  if(!is.null(dev.list())) dev.off() #figures
}


prepare_packages <- function(){
  renv::restore()
  devtools::update_packages(pkgs = TRUE)
  library("tidyverse")
  tinytex::install_tinytex()
}


main()