main <- function(){
  load_data(file_path = 'merge_data') -> data
  scatter_plot(data, file_path = 'scatter_regress')
  regress_table(data, file_path = 'scatter_regress')
}


load_data <- function(file_path){
  data_path <- here::here('03_build',file_path, 'output')
  file_name <- paste0(data_path, "/intermediate_data.Rds")
  data <- readRDS(file_name)
  return(data)
}


scatter_plot <- function(input_data, file_path){
  scatter <- ggplot2::ggplot(data = input_data,
                             aes(x = indep_var, y = dep_var)) +
    geom_point(shape=18, color="blue")+
    theme_bw()
  
  figure_path <- here::here('04_analyze', file_path, 'figure')
  file_name <- paste0(figure_path, "/figure.pdf")
  last_plot()
  ggsave(file_name, width = 5, height = 5)
  
}


regress_table <- function(input_data, file_path){

}


main()
#