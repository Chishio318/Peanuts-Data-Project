main <- function(){
  my_folder <- "test_score_ready"
  my_data <- read_interim(my_folder)
  
  var_quantitative <- c("implied_test")
    
  check_quantitative(my_data, 
                    var_quantitative, 
                    my_folder)
}


main()