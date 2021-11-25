main <- function(){
  my_folder <- "test_score_tidy"
  my_data <- read_interim(my_folder)
  
  var_categorical <- c("missing_dummy",
                       "absent_dummy")
  
  check_categorical(my_data, 
                    var_categorical, 
                    my_folder)
  
  var_quantitative <- c("test")
  
  check_quantitative(my_data, 
                     var_quantitative, 
                     my_folder)
}


main()