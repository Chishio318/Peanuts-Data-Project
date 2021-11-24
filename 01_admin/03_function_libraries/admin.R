read_interim <- function(folder_name){
  e <- new.env()
  sys.source("01_admin/03_function_libraries/read_and_save.R", 
             envir = e)
  output <- do.call("read_interim", 
                    list(folder_name), 
                    envir = e)
  
  return(output)
}

save_interim <- function(data, folder_name){
  e <- new.env()
  sys.source("01_admin/03_function_libraries/read_and_save.R", 
             envir = e)
  do.call("save_interim", 
          list(data, folder_name), 
          envir = e)
}

save_my_plot <- function(my_plot, var_name, folder_name){
  var_name <- rlang::enquo(var_name)
  
  e <- new.env()
  sys.source("01_admin/03_function_libraries/read_and_save.R", 
             envir = e)
  do.call("save_my_plot", 
                    list(my_plot, var_name, folder_name), 
                    envir = e)
}
      
elucidate_quantile <- function(data, var_name, output_folder){
  var_name <- rlang::enquo(var_name)
  
  e <- new.env()
  sys.source("01_admin/03_function_libraries/elucidate_quantile.R", 
             envir = e)
  do.call("elucidate_quantile", 
          list(data, var_name, output_folder), 
          envir = e)
}

elucidate_table <- function(data, var_name, output_folder){
  var_name <- rlang::enquo(var_name)
  
  e <- new.env()
  sys.source("01_admin/03_function_libraries/elucidate_table.R", 
             envir = e)
  do.call("elucidate_table", 
          list(data, var_name, output_folder), 
          envir = e)
}

check_quantitative <- function(data, var_vector, folder_name){
  
  e <- new.env()
  sys.source("01_admin/03_function_libraries/elucidate_together.R", 
             envir = e)
  do.call("check_quantitative", 
          list(data, var_vector, folder_name), 
          envir = e)
}

check_categorical <- function(data, var_vector, folder_name){
  
  e <- new.env()
  sys.source("01_admin/03_function_libraries/elucidate_together.R", 
             envir = e)
  do.call("check_categorical", 
          list(data, var_vector, folder_name), 
          envir = e)
}