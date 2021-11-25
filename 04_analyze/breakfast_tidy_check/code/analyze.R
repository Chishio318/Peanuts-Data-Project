main <- function(){
  my_folder <- "breakfast_tidy"
  my_data <- read_interim(my_folder)
  
  var_categorical <- c("duplicate_id",
                       "student",
                       "breakfast",
                       "breakfast_renamed")
  
  check_categorical(my_data, 
        var_categorical, 
        my_folder)
}


main()