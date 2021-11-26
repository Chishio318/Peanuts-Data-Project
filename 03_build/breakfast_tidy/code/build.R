main <- function(){
  folder_input <- "breakfast"
  folder_output <- "breakfast_tidy"
  
  name_lists <- c("Charlie",
                  "Sally",
                  "Linus",
                  "Lucy",
                  "Schroeder")
  
  raw_data <- read_raw(my_folder = folder_input, name_lists)
  tidy_data <- raw_data %>% 
    prep_date(date_order = "ymd") %>% 
    prep_duplicate_counts() %>% 
    prep_breakfast_synonyms()
  
  save_interim(tidy_data, folder_output)
}


read_raw <- function(my_folder, name_lists){
  data_list <- name_lists %>% 
    purrr::map(function(name) here::here(
      "02_raw",my_folder,"data",paste0(name, ".xlsx"))) %>% 
    purrr::map(readxl::read_excel)
  
  data_output <- data_list %>% 
    dplyr::bind_rows(.id = "student_num") %>% 
    dplyr::mutate(student = name_lists[as.numeric(student_num)]) %>% 
    dplyr::select(-student_num)
  
  return(data_output)
}

prep_date <- function(data_input, date_order){
  data_output <- data_input %>%
    dplyr::mutate(
      date_formatted = lubridate::parse_date_time(
        data_input$date,
        order = date_order))
  
  return(data_output)
}

prep_duplicate_counts <- function(data_input){
  data_output <- data_input %>% 
    dplyr::group_by(student, date_formatted) %>% 
    dplyr::mutate(duplicate_id = dplyr::row_number()) %>%
    dplyr::ungroup()
  
  return(data_output)
}

prep_breakfast_synonyms <- function(data_input){
  data_output <- data_input %>% 
    dplyr::mutate(breakfast_renamed = breakfast,
                  breakfast_renamed = replace(
                    breakfast_renamed,
                    breakfast_renamed %in% c("Cornflakes",
                                             "corn flakes",
                                             "cornflakes",
                                             "ceral"),
                    "cereal"),
                  breakfast_renamed = replace(
                    breakfast_renamed,
                    breakfast_renamed %in% c("oatmeal",
                                             "oat meal"),
                    "oatmeal"))
  return(data_output)
}

main()