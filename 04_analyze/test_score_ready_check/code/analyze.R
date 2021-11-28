main <- function(){
  box::use(`functions`/basics)
  box::use(`functions`/checks)
  
  my_folder <- "test_score_ready"
  my_data <- basics$read_interim(my_folder)
  
  var_quantitative <- c("implied_test")
    
  checks$check_quantitative(my_data, 
                    var_quantitative, 
                    my_folder)
}


main()