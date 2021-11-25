main <- function(){
  folder_input <- "test_score_tidy"
  folder_output <- "test_score_ready"
  
  tidy_data <- read_interim(folder_input)
  
  non_recorded_score <- 0
  
  ready_data <- tidy_data %>% 
    gen_implied_test(non_recorded_score) %>% 
    gen_average_tests()
  
  save_interim(ready_data, folder_output)
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
                     implied_test = mean(implied_test),
                     duplicate_id = dplyr::row_number()) %>% 
    dplyr::ungroup() %>% 
    dplyr::filter(duplicate_id == 1) %>% 
    dplyr::select(- duplicate_id)
  
  
  data_output <- data_averages %>%
    dplyr::mutate(subject = "Average") %>% 
    dplyr::bind_rows(data_input) %>% 
    dplyr::arrange(Student_ID, subject)
  
  return(data_output)
}

main()