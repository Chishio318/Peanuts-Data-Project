main <- function(){
  my_folder <- "test_score"
  
  raw_data <- read_raw(my_folder,
                       file_name = "James Street Elementary School Tests.csv")
  
  tidy_data <- raw_data %>% 
    prep_shape() %>% 
    prep_nonnumeric() %>% 
    prep_asserts()

  save_tidy(tidy_data, my_folder)
}


read_raw <- function(folder_name, file_name){
  file_path <- here::here("02_read",folder_name,"data",file_name)
  data <- readr::read_csv(file_path)
  return(data)
}

prep_shape <- function(data_input){
  data_output <- data_input %>%
    dplyr::mutate(across(everything(), as.character)) %>% 
    tidyr::pivot_longer(
      cols = !Student_ID,
      names_to = c("subject", "month"),
      names_sep = "_",
      values_to = "test_original"
    ) 
  
  return(data_output)
}

prep_nonnumeric <- function(data_input){
  data_output <- data_input %>%
    dplyr::mutate(missing_dummy = dplyr::if_else(is.na(test_original) == TRUE, 
                                                 true = 1, 
                                                 false = 0),
                  absent_dummy = dplyr::if_else(test_original == "absent", 
                                                true = 1, 
                                                false = 0, 
                                                missing = 0),
                  test = replace(test_original,
                                         which(test_original == "absent"),
                                         NA),
                  test = as.numeric(test))
  
  return(data_output)
}

prep_asserts <- function(data_input){
  
  testthat::test_that('data type correct', {
    testthat::expect_true(is.numeric(data_input$test))
    testthat::expect_true(is.numeric(data_input$missing_dummy))
    testthat::expect_true(is.numeric(data_input$absent_dummy))
  })
  
  return(data_input)
}

main()