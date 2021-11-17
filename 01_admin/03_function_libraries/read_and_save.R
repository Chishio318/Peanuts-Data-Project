save_interim <- function(data, folder_name, extension){
  file_path <- gen_file_path_interim(folder_name, extension)
  saveRDS(data, file_path)
}

read_interim <- function(folder_name, extension){
  file_path <- gen_file_path_interim(folder_name, extension)
  data <- readRDS(file_path)
  return(data)
}

gen_file_path_interim <- function(folder_name, extension){
  if (missing(extension)){
    file_path0 <- folder_name
  } else{
    file_path0 <- paste0(folder_name, "_", extension)
  }
  file_name <- paste0(file_path0, ".rds")
  file_path <- here::here("03_build",file_path0,"output",file_name)
  return(file_path)
}

