main <- function(){
  box::use(`functions`/basics)
  box::use(`functions`/checks)
  
  my_folder <- "breakfast_tidy"
  my_data <- basics$read_interim(my_folder)
  
  var_categorical <- c("duplicate_id",
                       "student",
                       "breakfast",
                       "breakfast_renamed")
  
  checks$check_categorical(my_data, 
        var_categorical, 
        my_folder)
}


main()