main <- function(){
  library_lists() -> lists
  load_functions(lists)
}

library_lists <- function(){
  lists <- c("read_and_save",
             "elucidate_quantile")
  #"elucidate_table.R"
  return(lists)
}

load_functions <- function(lists){
  purrr::map(lists, load_each_function)
}

load_each_function <- function(lib_name){
  file_name0 <- paste0(lib_name, ".R")
  file_name <- here::here("01_admin", "03_function_libraries", file_name0)
  source(file_name)
}

main()