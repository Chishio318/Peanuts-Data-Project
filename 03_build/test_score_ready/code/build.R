main <- function(){
  my_folder <- "test_score"
  
  tidy_data <- basics$read_interim(my_folder, extension = "tidy")
  
  ready_data <- tidy_data %>% 
    gen_implied_test(non_recorded_score = 0) %>% 
    gen_average_tests()
  
  basics$save_interim(ready_data, my_folder, extension = "ready")
}

gen_implied_test <- function(data_input, non_recorded_score){
  data_output <- data_input %>% 
    dplyr::mutate(implied_test = test,
                  implied_test = replace(
                    implied_test,
                    is.na(implied_test) == TRUE,
                    non_recorded_score
                  ))
    
  return(data_output)
}

gen_average_tests <- function(data_input){
  data_averages <- data_input %>% 
    dplyr::group_by(Student_ID, month) %>% 
    dplyr::transmute(test = mean(test, rm.na = TRUE),
                     implied_test = mean(implied_test)) %>% 
    dplyr::distinct() %>% 
    dplyr::ungroup()
  
  data_output <- data_averages %>%
    dplyr::mutate(subject = "Average") %>% 
    dplyr::bind_rows(data_input) %>% 
    dplyr::arrange(Student_ID, subject)
  
  return(data_output)
}

box::use(`functions`/basics)
main()