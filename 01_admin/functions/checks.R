check_quantitative <- function(data, var_vector, folder_name){
  box::use(`functions`/elucidate_quantile)
  
  file_name <- paste0(folder_name, "_check")
  
  purrr::map(var_vector, 
             function(var){
               elucidate_quantile$elucidate_quantile(
                 data,
                 (!!as.name(var)), 
                 file_name)
             })
}

check_categorical <- function(data, var_vector, folder_name){
  box::use(`functions`/elucidate_table)
  
  file_name <- paste0(folder_name, "_check")
  
  purrr::map(var_vector, 
             function(var){
               elucidate_table$elucidate_table(
                 data, 
                 (!!as.name(var)), 
                 file_name)
             })
}