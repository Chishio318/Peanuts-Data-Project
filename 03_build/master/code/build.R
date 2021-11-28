main <- function(){
  box::use(`functions`/basics)
  
  breakfast_data <- basics$read_interim("breakfast_ready")
  test_data <- basics$read_interim("test_score_ready")
  id_data <- read_raw("student_id", file_name = "JSES students.csv")
  
  breakfast_data_for_merge <- prep_breakfast(breakfast_data)
  id_data_for_merge <- prep_id(id_data)
  
  master_data <- prep_merge(
    breakfast_data_for_merge,
    test_data,
    id_data_for_merge) %>% 
    prep_outcome_var()
  
  basics$save_interim(master_data, "master")
}


read_raw <- function(folder_name, file_name){
  file_path <- here::here("02_raw",folder_name,"data",file_name)
  data <- readr::read_csv(file_path)
  return(data)
}

prep_breakfast <- function(data_input){
  data_output <- data_input %>% 
    dplyr::mutate(full_name = dplyr::if_else(student == "Charlie", "Charles Brown", "no name"),
                  full_name = dplyr::if_else(student == "Sally", "Sally Brown", full_name),
                  full_name = dplyr::if_else(student == "Linus", "Linus van Pelt", full_name),
                  full_name = dplyr::if_else(student == "Lucy", "Lucy van Pelt", full_name),
                  full_name = dplyr::if_else(student == "Schroeder", "Charlie Schroeder", full_name),
                  month_id = month.abb[month],
                  month_id = dplyr::if_else(month == 9, "Sept", month_id)) %>% 
    dplyr::filter(month != 1)
  return(data_output)
}

prep_id <- function(data_input){
  names(data_input) <- make.names(names(data_input),unique = TRUE)
  data_output <- data_input %>% 
    dplyr::mutate(Student_ID = as.character(Student.Number))
  return(data_output)
}

prep_merge <- function(breakfast_data, test_data, id_data){
  data_output <- breakfast_data %>% 
    dplyr::left_join(id_data, by = c("full_name" = "Student.Names")) %>% 
    dplyr::left_join(test_data, by = c("Student_ID",
                                       "month_id" = "month"))
  return(data_output)
}

prep_outcome_var <- function(data_input){
  data_output <- data_input %>% 
    tidyr::pivot_wider(names_from = subject, values_from = implied_test)
  
  return(data_output)
}

main()