main <- function(){
  # initialize_renv()
  packages_list() -> lists
  update_list(lists)
}

initialize_renv <- function(){
  install.packages("renv")
  renv::init(bare = TRUE)
}

packages_list <- function(){
  lists <- c("tidyverse",
             "rmarkdown",
             "here",
             "kableExtra",
             "tinytex",
             "conflicted",
             "devtools",
             "data.table",
             "knitr",
             "modelsummary",
             "estimatr",
             "RColorBrewer",
             "testthat",
             "xtable",
             "tictoc",
             "rlang",
             "box")
  return(lists)
}

update_list <- function(lists){
  install.packages(lists)
  renv::snapshot()
}

main()