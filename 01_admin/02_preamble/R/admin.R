main <- function(){
  set_error_to_English()
  clear_environment()
  prepare_packages()
  #set_log()
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
  #devtools::update_packages(packages = TRUE)
  library("magrittr")
  # tinytex::install_tinytex()
  ggplot2::theme_set(ggplot2::theme_light())
}

set_log <- function(){
  main_name <- here::here(
    "05_report", 
    "log",
    format(Sys.time(), "%d-%b-%Y %H.%M")
  )
  
  output_name <- paste0(main_name, "_output.txt")
  message_name <- paste0(main_name, "_message.txt")
  message_file <- file(message_name, open = "a")
  
  sink(file = output_name, append = TRUE, split = TRUE, type = "output")
  sink(file = message_file, type = "message")
}

initialize_time <- function(){
  tictoc::tic("master")
}

main()