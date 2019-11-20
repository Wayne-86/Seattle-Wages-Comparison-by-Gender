# install.packages("formatR")
library(knitr)
library(formatR)

get_text_from_md_file <- function(fn) {
  return(div(HTML(markdown::markdownToHTML(fn))))
}