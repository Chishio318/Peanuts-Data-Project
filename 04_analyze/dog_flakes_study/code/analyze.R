main <- function(){
  data <- read_interim("master")
  
  dog_flake_month_vector <- gen_dog_flake(data)
  
  my_plot <- data %>%
    gen_month_order() %>% 
    lay_basic() %>% 
    lay_shapes() %>% 
    lay_frame() %>% 
    lay_titles() %>% 
    lay_dog_flakes(dog_flake_month_vector)
  
  save_my_plot(my_plot, var_name = "dog_flakes_study",
                       folder_name = "dog_flakes_study")
}

gen_dog_flake <- function(data){
  dog_flake_month_vector <- data %>% 
    dplyr::filter(n_dogflakes>0) %>% 
    dplyr::pull(month)
  return(dog_flake_month_vector)
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
    ) %>% 
    dplyr::filter(is.na(Average) == FALSE)
  
  return(data_output)
}

lay_basic <- function(data_input){
  require(ggplot2)
  plot_output <- ggplot(data = data_input,
                        mapping = aes(x = month_order,
                                      y = Average,
                                      group = student))
  return(plot_output)
}

lay_shapes <- function(plot_input){
  my_colors <- c("Charlie" = "orangered3",
                 "Sally" = "orangered3",
                 "Lucy" = "gray50",
                 "Schoulder" = "gray50",
                 "Linus" = "gray50")
  my_shapes <- c("Charlie" = 19, #filled circle
                 "Sally" = 18, #filled diamond
                 "Lucy" = 46, #empty dot
                 "Schoulder" = 46,
                 "Linus" = 46) #empty dot
  my_breaks <- c("Charlie", "Sally", "Lucy")
  my_labels <- c("Charlie", "Sally", "Others")
  
  plot_output <- plot_input +
    geom_point(mapping = aes(color = student, 
                             shape = student),
               size = 4) +
    geom_line(mapping = aes(color = student,
                            group = student),
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
    scale_x_continuous(breaks = c(9, 10, 11, 12, 13),
                       labels = c("Sep", "Oct", "Nov", "Dec", "Feb"))
  
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

lay_dog_flakes <- function(plot_input, dog_flake_month_vector){
  my_caption <- paste(strwrap("Only dog flakes in some morning", 20), 
                      collapse = "\n")
  
  dog_flake_month <- unique(dog_flake_month_vector)
  interval = 0.3
  my_xmin = dog_flake_month - interval
  my_xmax = dog_flake_month + interval
  
  plot_output <- plot_input +
    geom_rect(aes(xmin = my_xmin, 
                  xmax = my_xmax, 
                  fill = "red"), 
              ymin = -Inf, 
              ymax = Inf, 
              alpha = 0.05,
              show.legend = FALSE) +
    annotate(geom = "text", 
             x = 11.3, 
             y = 100, 
             label = my_caption, 
             hjust = 0, 
             vjust = 1,
             colour = "red",
             size = 4)
  
  return(plot_output)
}

main()