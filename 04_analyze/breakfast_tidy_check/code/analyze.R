main <- function(){
  my_folder <- "breakfast_tidy"
  my_data <- read_interim(my_folder)
  
  var_quantitative <- c("duplicate_id")
  elucidate_all(my_data, 
        var_quantitative, 
        my_folder, 
        type ="quantitative")
  
  var_categorical <- c("duplicate_id")
  
}

elucidate_all <- function(data, var_vector, folder_name){
  file_name <- paste0(folder_name, "_check")
  file_path <- here::here("04_analyze",file_name,"figure")
  
  for(var in var_vector){
    elucidate_quantile(data, (!!as.name(var)), file_path)
  }
  
  #depend on categorical
}


main()