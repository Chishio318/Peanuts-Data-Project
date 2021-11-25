main <- function(){
  assemble()
  build()
  analyze()
  report()
  settle()
}


assemble <- function(){
  lets('assemble', 'packages')
  lets('assemble', 'preamble')
  lets('assemble', 'function_libraries')
}


build <- function(){
  lets('build', 'test_score_tidy')
  lets('build', 'breakfast_tidy')
  lets('build', 'test_score_ready')
  lets('build', 'breakfast_ready')
  lets('build', 'master')
}


analyze <- function(){
  lets('analyze', 'test_score_tidy_check')
  lets('analyze', 'breakfast_tidy_check')
  lets('analyze', 'test_score_ready_check')
  lets('analyze', 'breakfast_ready_check')
  
  lets('analyze', 'pancakes_study')
  lets('analyze', 'dog_flakes_study')
}


report <- function(){
  lets('report', 'checks')
}


settle <- function(){
  lets('settle', 'postamble')
}

lets <- function(verb_name, object_name){
  if (verb_name == 'assemble' && object_name == 'preamble'){
    source(here::here('01_admin', '02_preamble', 'R', 'admin.R'))
  }
  
  else if (verb_name == 'assemble' && object_name == 'packages'){
    source(here::here('01_admin', '01_packages', 'admin.R'))
  }
  
  else if (verb_name == 'assemble' && object_name == 'function_libraries'){
    source(here::here('01_admin', '03_function_libraries', 'admin.R'))
  }
  
  else if (verb_name == 'build'){
    source(here::here('03_build', object_name, 'code', 'build.R'))
  }
  
  else if (verb_name == 'analyze'){
    source(here::here('04_analyze', object_name, 'code', 'analyze.R'))
  }
  
  else if (verb_name == 'report'){
    rmarkdown::render(here::here('05_report', 
                                 object_name, 'text', 'report.Rmd'),
                      output_dir = here::here('05_report', 
                                              object_name, 'output')) 
  }
  
  else if (verb_name == 'settle' && object_name == 'postamble'){
    source(here::here('01_admin', '04_postamble', 'admin.R'))
  }
  
}

main()