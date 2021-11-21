main <- function(){
  #data <- read_interim("master")
  data <- my_base::read_interim()
  
  my_plot <- data %>%
    gen_month_order() %>% 
    lay_basic() %>% 
    lay_shapes() %>% 
    lay_frame() %>% 
    lay_titles() %>% 
    lay_dog_flakes()
  
  my_base::save_my_plot(my_plot, 
                       folder_name = "dog_flakes_study")
}


read_interim <- function(){
  data_example <- readr::read_csv("example.csv")
  return(data_example)
}

gen_month_order <- function(data_input){
  start_month <- 9
  adjust_month <- 1
  
  data_output <- data_input %>% 
    dplyr::mutate(
      month_order = dplyr::if_else(
        month < start_month,
        true = month + 12 - adjust_month, 
        false = month
      ),
      .after = month
    )
  return(data_output)
}

lay_basic <- function(data_input){
  require(ggplot2)
  plot_output <- ggplot(data = data_input,
                        mapping = aes(x = month_order,
                                      y = test,
                                      group = student))
  return(plot_output)
}

lay_shapes <- function(plot_input){
  my_colors <- c("Charlie" = "orangered3",
                 "Sally" = "orangered3",
                 "Lucy" = "gray50",
                 "Schoulder" = "gray50")
  my_shapes <- c("Charlie" = 19, #filled circle
                 "Sally" = 18, #filled diamond
                 "Lucy" = 46, #empty dot
                 "Schoulder" = 46) #empty dot
  my_breaks <- c("Charlie", "Sally", "Lucy")
  my_labels <- c("Charlie", "Sally", "Others")
  
  plot_output <- plot_input +
    geom_point(mapping = aes(color = student, 
                             shape = student),
               size = 4) +
    geom_line(mapping = aes(color = student),
              size = 1) +
    scale_color_manual(values = my_colors,
                       breaks = my_breaks,
                       labels = my_labels) +
    scale_shape_manual(values = my_shapes,
                       breaks = my_breaks,
                       labels = my_labels)
  
  return(plot_output)
}

lay_frame <- function(plot_input){
  plot_output <- plot_input +
    theme(panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          legend.position = "bottom") +
    theme(legend.title=element_blank()) +
    scale_x_continuous(breaks = c(11, 12, 13, 14),
                       labels = c("Nov", "Dec", "Feb", "Mar"))
  
  return(plot_output)
}

lay_titles <- function(plot_input){
  plot_output <- plot_input +
    labs(title = "Dog Flake Breakfasts and Test Scores",
         subtitle = "Based on Peanuts Data",
         x = NULL,
         y = "Test Scores",
         caption = "Source: James Street Elementary School")
  return(plot_output)
}

lay_dog_flakes <- function(plot_input){
  my_caption <- paste(strwrap("Only dog flakes in some morning", 20), 
                      collapse = "\n")
  
  plot_output <- plot_input +
    geom_rect(aes(xmin = 10.8, 
                  xmax = 11.2, 
                  fill = "red"), 
              ymin = -Inf, 
              ymax = Inf, 
              alpha = 0.05,
              show.legend = FALSE) +
    annotate(geom = "text", 
             x = 11.2, 
             y = 100, 
             label = my_caption, 
             hjust = 0, 
             vjust = 1,
             colour = "red",
             size = 4)
  
  return(plot_output)
}

main()