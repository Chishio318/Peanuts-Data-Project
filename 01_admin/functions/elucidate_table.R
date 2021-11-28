elucidate_table <- function(data, var_name, output_folder){
  var_name <- rlang::enquo(var_name)
  box::use(magrittr[`%>%`])
  
  data %>% 
    gen_table(!!var_name) %>% 
    format_and_save_table(!!var_name, output_folder)
}

gen_table <- function(data_input, var_name, max_distinct){
  var_name <- rlang::enquo(var_name)
  box::use(magrittr[`%>%`])
  
  table_output <- data_input %>% 
    dplyr::group_by(!!var_name) %>% 
    dplyr::summarise(count = dplyr::n()) %>% 
    dplyr::mutate(frequency = round(count/sum(count),2)) 
  
  num_distinct <- nrow(table_output)

  if(missing(max_distinct)){
    max_distinct <- 30
  }
  
  if(num_distinct > max_distinct){
    helper_message <- paste0("There are ", num_distinct, " distinct values.")
    print(helper_message)
    stop('too many distinct values for tables.')
  }
  
  return(table_output)
}

format_and_save_table <- function(my_table, var_name, output_folder){
  var_name <- rlang::enquo(var_name)
  box::use(magrittr[`%>%`])
  
  my_file_tex0 <- paste0(var_name, ".tex")  
  varname_id <- 2
  my_file_tex <- here::here("04_analyze", output_folder, "table", my_file_tex0[varname_id])

  table_tex <- my_table %>% 
    kableExtra::kbl(format = "latex", booktabs = T) %>% 
    kableExtra::kable_styling(latex_options = "hold_position",
                  full_width = F) %>% 
    kableExtra::kable_classic_2(full_width = F) 
  writeLines(table_tex, my_file_tex)
  
  my_file_html0 <- paste0(var_name, ".html")  
  my_file_html <- here::here("04_analyze", output_folder, "table", my_file_html0[varname_id])

  table_html <- my_table %>% 
    kableExtra::kbl(format = "html") %>% 
    kableExtra::kable_styling(bootstrap_options = "hover") %>%
    kableExtra::kable_classic_2(full_width = F) %>% 
    cat(., file = my_file_html)
}