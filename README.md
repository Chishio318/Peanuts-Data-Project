# Questions

- どうやってコードを修正するか



00_cover

- contains ``.gitignore'' file that must not be deleted



drawback: this can be very heavy.

- because of renv, it will take some time to run this script for the first time.

[See](https://rstudio.github.io/renv/articles/renv.html)

When you wish to add new packages for your analysis, please go to

```
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
             "estimatr")
  return(lists)
}
```



おそらくTinyTeXのインストールで6分くらい使ったと思うので、まだ4分くらい残ってるはずだ。残りの時間を日本語の設定にあてよう。
