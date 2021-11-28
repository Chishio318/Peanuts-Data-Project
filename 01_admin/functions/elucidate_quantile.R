elucidate_quantile <- function(data, var_name, output_folder){
  var_name <- rlang::enquo(var_name)
  
  box::use(`functions`/basics)
  box::use(ggplot2[...])
  box::use(magrittr[`%>%`])
  
  my_data <- check_and_select(data, !!var_name)
  my_statistics <- gen_summaries(data, !!var_name)
  
  my_plot <- data %>% 
    gen_quantile(!!var_name, 
                     n_obs = my_statistics$my_count_valid) %>% 
    lay_basic(!!var_name) %>% 
    lay_geom() %>% 
    lay_frame() %>% 
    lay_titles(main_title = var_name, 
                   stats = my_statistics) %>% 
    lay_mean_line(stats = my_statistics)
    
  basics$save_my_plot(my_plot, !!var_name,
               folder_name = output_folder)
}


check_and_select <- function(data_input, var_name){
  var_name <- rlang::enquo(var_name)
  box::use(magrittr[`%>%`])
  
  data_interim <- data_input %>% 
    dplyr::select(!!var_name)
  
  data_output <- dplyr::select_if(data_interim, is.numeric)  
  
  if(ncol(data_output) == 0) 
    stop('data is not numeric.')
  
  return(data_output)
}

gen_summaries <- function(data_input, var_name){
  var_name <- rlang::enquo(var_name)
  box::use(magrittr[`%>%`])
  
  data_output <- data_input %>% 
    dplyr::summarize(
      my_mean = mean(!!var_name, 
                     na.rm = TRUE),
      my_max = max(!!var_name, 
                   na.rm = TRUE),
      my_min = min(!!var_name, 
                   na.rm = TRUE),
      my_count_all = dplyr::n(),
      my_count_valid = sum(!is.na(!!var_name))
    )

  return(data_output)
}

gen_quantile <- function(data_input, var_name, n_obs){
  var_name <- rlang::enquo(var_name)
  box::use(magrittr[`%>%`])
  
  data_output <- data_input %>% 
    dplyr::mutate(my_rank = rank(!!var_name,
                                 ties.method = "first"),
                  my_quantile = my_rank/n_obs) %>% 
    dplyr::filter(my_quantile <= 1)
  
  return(data_output)
}

lay_basic <- function(data_input, var_name){
  var_name <- rlang::enquo(var_name)
  box::use(ggplot2[...])
  
  plot_output <- ggplot(data = data_input,
                        mapping = aes(x = my_quantile,
                                      y = !!var_name)) 
  return(plot_output)
}

lay_geom <- function(plot_input){
  box::use(ggplot2[...])
  
  my_color <- "royalblue4"
  my_shape <- 19 #filled circle
  degree_transparency <- 0.5
  
  plot_output <- plot_input +
    geom_point(size = 4,
               color = my_color,
               shape = my_shape,
               alpha = 1 - degree_transparency) +
    geom_line(color = my_color,
              size = 1)
  
  return(plot_output)
}

lay_frame <- function(plot_input){
  box::use(ggplot2[...])
  
  plot_output <- plot_input +
    scale_x_continuous(breaks = c(0, 0.5, 1),
                       labels = c("0", "1/2", "1"),
                       limits = c(0,1))
  
  return(plot_output)
}

lay_titles <- function(plot_input, main_title, stats){
  box::use(ggplot2[...])
  
  obs_title <- paste0("Total obs = ", stats$my_count_all, 
                      ",  Non-missing obs = ", stats$my_count_valid)
  summaries_text <- paste0("Statistics: mean = ", round(stats$my_mean,1),
                          ", max =", round(stats$my_max,1),
                          ", min =", round(stats$my_min,1))
  
  plot_output <- plot_input +
    labs(title = main_title,
         subtitle = obs_title,
         x = "quantiles",
         y = NULL,
         caption = summaries_text)
  return(plot_output)
}

lay_mean_line <- function(plot_input, stats){
  box::use(ggplot2[...])
  
  my_color <- "tan2"
  degree_transparency = 0.4
  
  plot_output <- plot_input +
    geom_hline(aes(yintercept = stats$my_mean),
               color = my_color,
               size = 1,
               alpha = 1 - degree_transparency)
  
  return(plot_output)
}
