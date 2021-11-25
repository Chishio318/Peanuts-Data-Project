main <- function(){
  my_folder <- "breakfast_ready"
  my_data <- read_interim(my_folder)
  
  var_quantitative <- c("n_pancakes",
                        "n_dogflakes",
                        "n_days",
                        "frac_pancake_in_recorded_days",
                        "frac_pancake_in_max_days")
  
  check_quantitative(my_data, 
                     var_quantitative, 
                     my_folder)
}


main()