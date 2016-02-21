# scratch
library(knitr)
rmarkdown::render("Frst_R_MarkDown.Rmd")
browseURL("Frst_R_MarkDown.html")
# 
# writeLines(c("# hello markdown", "```{r hello-random, echo=TRUE}", "rnorm(5)", "```"), 
#            "test.Rmd")
# knit2html("test.Rmd")
# if (interactive()) browseURL("test.html")