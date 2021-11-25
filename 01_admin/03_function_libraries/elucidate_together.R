check_quantitative <- function(data, var_vector, folder_name){
  file_name <- paste0(folder_name, "_check")
  
  purrr::map(var_vector, 
             function(var){elucidate_quantile(data, (!!as.name(var)), file_name)})
  
}

check_categorical <- function(data, var_vector, folder_name){
  file_name <- paste0(folder_name, "_check")
  
  purrr::map(var_vector, 
             function(var){elucidate_table(data, (!!as.name(var)), file_name)})
  
}