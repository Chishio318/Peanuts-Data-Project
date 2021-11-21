main <- function(){
  my_folder <- "pancakes_study"
  
  data_master <- mybase::read_interim("master")
  
  reg_formula = list("Average" = implied_test ~ n_pancakes)
  main_varnames <- c('n_pancakes' = 'freq(pancakes)',
                     '(Intercept)' = 'Constant')
  data_master %>% 
    run_regressions(
      reg_formula,
      cluster_name = student, 
      fe_name = student) %>%
    format_and_save_table(
      my_file = "initial_reg",
      my_title = "Initial regressions",
      my_varnames = main_varnames,
      my_folder = my_folder)
  
  data_master %>%
    run_scatter(
      x_var = n_pancakes,
      y_var = implied_test,
      group_var = student) %>%
    mybase::save_my_plot(folder = my_folder)
}

lay_regressions <- function(data_input, model_input, cluster_name, fe_name){
  cluster_name <- rlang::enquo(cluster_name)
  fe_name <- rlang::enquo(fe_name)
  
  OLS_model <- purrr::map(model_input,
                          ~ estimatr::lm_robust(.x, 
                                                clusters = !!cluster_name,
                                                se_type = "stata",
                                                data = data_input))
  
  FE_model <- purrr::map(model_input,
                         ~ estimatr::lm_robust(.x, 
                                               clusters = !!cluster_name,
                                               fixed_effects = ~ !!fe_name,
                                               se_type = "stata",
                                               data = data_input))
  
  estimates_lists <- c(OLS_model, FE_model)
  names(estimates_lists) <- c('OLS', 'FE')
  return(estimates_lists)
}

format_and_save_table <- function(estimates_lists, my_file_name, 
                                  my_title, my_varnames, my_folder){
  my_file_tex0 <- paste0(my_file_name, ".tex")  
  my_file_png0 <- paste0(my_file_name, ".png")  
  my_file_tex <- here::here("04_analyze", my_folder, "table", my_file_tex0)
  my_file_png <- here::here("04_analyze", my_folder, "figure", my_file_png0)
  
  my_content <- "^(?!R2|Num)"
  my_fmt <- "%.2f"
  
  
  my_rows <- tibble::tribble(~term,  ~'OLS',  ~'FE',
                             'Clustering', 'Y', 'Y')
  attr(my_rows, 'position') <- 5
  
  table_tex <- modelsummary::msummary(
    estimates_lists, gof_omit = my_content, fmt = my_fmt, title = my_title, 
    coef_map = my_varnames, add_rows = my_rows,
    output = "latex", booktabs = TRUE) %>% 
    format_table()
  writeLines(table_tex, my_file_tex)
  
  table_image <- modelsummary::msummary(
    estimates_lists, gof_omit = my_content, fmt = my_fmt, title = my_title, 
    coef_map = my_varnames, add_rows = my_rows,
    output = "kableExtra") %>% 
    format_table()
  kableExtra::save_kable(table_image, my_file_png)
  
}

format_table <- function(table_input){
  table_output <- table_input %>% 
    kableExtra::kable_styling(bootstrap_options = c("hover", "condensed")) %>% 
    kableExtra::add_header_above(c(" " = 1, "(1)" = 1, "(2)" = 1)) %>%
    kableExtra::kable_classic_2(full_width = F) %>% 
    kableExtra::footnote(general = "Heteroskedasticity-robust standard errors clustered at students level are reported in the parenthesis.",
                         threeparttable = T) 
  return(table_output)
}

run_scatter <- function(data_input, x_var, y_var, group_var){
  require(ggplot2)
  plot_output <- ggplot(data = data_input,
                        mapping = aes(x = x_var,
                                      y = y_var,
                                      group = group_var,
                                      color = group_var)) +
    geom_point()
  return(plot_output)
}


main()