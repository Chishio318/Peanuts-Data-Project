main <- function(){
  import_merge() -> data
  save_data(data, file_path = 'merge_data')
}


import_merge <- function(){
  indep_var <- readr::read_csv(here::here('02_bring', 'indep_var', 'data', 'indep_var.csv'))
  dep_var <- readr::read_csv(here::here('02_bring', 'dep_var', 'data', 'dep_var.csv'))
  
  merged_data <- dplyr::left_join(indep_var, dep_var, by = "ID")
  return(merged_data)
}


save_data <- function(data, file_path){
  data_path <- here::here('03_build',file_path, 'output')
  saveRDS(data, file = paste0(data_path, "/intermediate_data.Rds"))
}


main()
#