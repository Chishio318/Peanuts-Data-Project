main <- function(){
  my_folder <- "breakfast"

  tidy_data <- basics$read_interim(my_folder, extension = "tidy")

  ready_data <- tidy_data %>% 
    gen_dummies() %>%
    prep_shape_month() %>% 
    gen_pancake_frac() %>% 
    prep_asserts()
  
  basics$save_interim(ready_data, my_folder, extension = "ready")  
}

gen_dummies <- function(data_input){
  data_output <- data_input %>% 
    dplyr::group_by(student, date_formatted) %>% 
    dplyr::mutate(dogflakes = max(breakfast == "dog flakes"),
                  pancakes = max(breakfast == "pancakes")) %>% 
    dplyr::ungroup()
  
  return(data_output)
}

prep_shape_month <- function(data_input){
  data_output <- data_input %>% 
    dplyr::mutate(month = lubridate::month(date_formatted),
                  max_n_days = lubridate::days_in_month(date_formatted)) %>% 
    dplyr::group_by(student, month) %>% 
    dplyr::summarize(n_pancakes = sum(pancakes),
                     n_dogflakes = sum(dogflakes),
                     n_days = dplyr::n(),
                     max_n_days = max_n_days) %>% 
    dplyr::ungroup() %>% 
    dplyr::distinct(student, month, .keep_all = TRUE)
  
  return(data_output)
}

gen_pancake_frac <- function(data_input){
  data_output <- data_input %>% 
    dplyr::mutate(frac_pancake_in_recorded_days = n_pancakes/n_days,
                  frac_pancake_in_max_days = n_pancakes/max_n_days)
  
  return(data_output)
}

prep_asserts <- function(data_input){
  testthat::test_that('number of reported days less than that in the month', {
    testthat::expect_equal(sum(data_input$n_days > data_input$max_n_days), 0)
  })
  
  return(data_input)
}

box::use(`functions`/basics)
main()