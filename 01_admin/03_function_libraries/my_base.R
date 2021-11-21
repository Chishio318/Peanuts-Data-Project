disposables::make_packages(mybase ={
  save_interim <- function(data, folder_name, extension){
    file_path <- mybase::gen_file_path_interim(folder_name, extension)
    saveRDS(data, file_path)
  };
  
  read_interim <- function(folder_name, extension){
    file_path <- mybase::gen_file_path_interim(folder_name, extension)
    data <- readRDS(file_path)
    return(data)
  };
  
  gen_file_path_interim <- function(folder_name, extension){
    if (missing(extension)){
      file_path0 <- folder_name
    } else{
      file_path0 <- paste0(folder_name, "_", extension)
    }
    file_name <- paste0(file_path0, ".rds")
    file_path <- here::here("03_build",file_path0,"output",file_name)
    return(file_path)
  };
  
  save_my_plot <- function(my_plot, folder_name){
    my_plot
    
    golden_ratio <- 1.618
    size1 <- 11
    size2 <- size1*golden_ratio
    my_unit = "cm"
    
    pdf_name <- paste0(folder_name, ".pdf")
    png_name <- paste0(folder_name, ".png")
    save_path <- here::here('04_analyze', folder_name, 'figures')
    
    ggsave(pdf_name,
           width = size2, height = size1, unit = my_unit,
           path = save_path)
    ggsave(png_name,
           width = size2, height = size1, unit = my_unit,
           dpi = "print",
           path = save_path)
    
    while (!is.null(dev.list()))  dev.off()
    
  }
})

