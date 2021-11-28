main <- function(){
  finish_time()
  #finish_log()
  clear_all()
}


finish_time <- function(){
  tictoc::toc(log = TRUE)
}

finish_log <- function(){
  sink(NULL, type = "message")
  sink(NULL, type = "output")
}

clear_all <- function(){
  rm(list = ls(), envir = .GlobalEnv)  # functions
}

main()


