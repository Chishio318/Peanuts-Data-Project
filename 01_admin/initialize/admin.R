main <- function(){
  set_error_to_English()
  prepare_packages()
}


set_error_to_English <- function(){
  Sys.setenv(LANG = "en_US.UTF-8") 
}

prepare_packages <- function(){
  renv::restore()
  #devtools::update_packages(packages = TRUE)
  library(magrittr)
  # tinytex::install_tinytex()
  ggplot2::theme_set(ggplot2::theme_light())
  options(box.path = here::here("01_admin"))
}


main()