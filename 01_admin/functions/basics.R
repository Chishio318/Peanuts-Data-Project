save_interim <- function(data, folder_name){
  file_path <- gen_file_path_interim(folder_name)
  saveRDS(data, file_path)
}

read_interim <- function(folder_name){
  file_path <- gen_file_path_interim(folder_name)
  data <- readRDS(file_path)
  return(data)
}

gen_file_path_interim <- function(folder_name){
  file_name <- paste0(folder_name, ".rds")
  file_path <- here::here("03_build",folder_name,"output",file_name)
  return(file_path)
}

save_my_plot <- function(my_plot, var_name, folder_name){
  var_name <- rlang::enquo(var_name)
  my_plot
  
  golden_ratio <- 1.618
  size1 <- 11
  size2 <- size1*golden_ratio
  my_unit = "cm"
  
  pdf_name <- paste0(var_name, ".pdf")
  png_name <- paste0(var_name, ".png")
  save_path <- here::here('04_analyze', folder_name, 'figure')
  
  var_id <- 2
  ggplot2::ggsave(pdf_name[var_id],
         width = size2, height = size1, unit = my_unit,
         path = save_path)
  ggplot2::ggsave(png_name[var_id],
         width = size2, height = size1, unit = my_unit,
         dpi = "print",
         path = save_path)
  
  while (!is.null(grDevices::dev.list()))  grDevices::dev.off()
  
}


