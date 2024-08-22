url <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/Material/yacsdas-vis.md"
childtext <- readLines(url)
cat(childtext, sep="\n")

url <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/Material/yacsdas-EDA.md"
childtext <- readLines(url)
cat(childtext, sep="\n")

url <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/Material/yacsdas-lm.md"
childtext <- readLines(url)
cat(childtext, sep="\n")

url <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/Material/yacsdas-tidymodels.md"
childtext <- readLines(url)
cat(childtext, sep="\n")
