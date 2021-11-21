main <- function(){
  set_error_to_English()
  clear_environment()
  prepare_packages()
  initialize_time()
}


set_error_to_English <- function(){
  Sys.setenv(LANG = "en_US.UTF-8") 
}

clear_environment <- function(){
  cat("\014")   # console
  if(!is.null(dev.list())) dev.off() # figures
  gc();  gc(); # garbage collection
}

prepare_packages <- function(){
  renv::restore()
  devtools::update_packages(pkgs = TRUE)
  library("magrittr")
  tinytex::install_tinytex()
}

initialize_time <- function(){
  tictoc::tic("master")
}

#sink(file = log, append = TRUE, split = TRUE, type = "output")
#sink(file = log, append = TRUE, type = "message")


main()