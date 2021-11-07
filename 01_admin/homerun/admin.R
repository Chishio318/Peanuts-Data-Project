main <- function(){
  preamble()
  build()
  analyze()
  report()
}


pave <- function(){
  hit('preamble', 'preamble')
}


build <- function(){
  hit('build', 'data1')
  hit('build', 'data2')
  hit('build', 'data3')
  hit('build', 'shape_data')
}


analyze <- function(){
  hit('analyze', 'elucidate')
  hit('analyze', 'scatter_regress')
}


report <- function(){
  hit('report', 'check')
  hit('report', 'draft')
}


hit <- function(verb_name, object_name){
  if (verb_name == 'pave'){
    library_path <- "01_admin/preamble/lib"
    .libPaths(library_path)
    #source(here::here('01_admin', 
    #                  object_name, 'add_packages', 'add_packages.R'))
    source(here::here('01_admin', object_name, 'pave', 'pave.R'))
  }
  
  else if (verb_name == 'build'){
    source(here::here('03_build', object_name, 'code', 'build.R'))
  }
  
  else if (verb_name == 'analyze'){
    source(here::here('04_analyze', object_name, 'code', 'analyze.R'))
  }
  
  else if (verb_name == 'report'){
    rmarkdown::render(here::here('05_report', 
                                 object_name, 'markdown', 'report.Rmd'),
                      output_dir = here::here('05_report', 
                                              object_name, 'output')) 
  }
}


main()
#