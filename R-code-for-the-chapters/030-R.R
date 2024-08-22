library(easystats)  # make stats easy again
library(tidyverse)  # data wrangling
library(tableone)  # tables, optional
library(rio)  # import/export data, eg., to excel
library(ggpubr)  # simple data visualization
library(ggstatsplot)  # data visualization ornamented with statistics

penguins <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/palmerpenguins/penguins.csv")

library(DataExplorer)

plot_histogram(penguins)

plot_intro(penguins)

plot_bar(penguins)

library(visdat)  # must be installed
vis_dat(penguins)

library(vtree)
vtree(penguins, c("sex", "island"))

penguins <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/palmerpenguins/penguins.csv")

library(tableone)
CreateTableOne(data = penguins)

tab1 <- CreateTableOne(data = penguins)
summary(tab1)

library(easystats)  # once per session
describe_distribution(penguins)

data_tabulate(penguins, select = c("sex", "island")) |> 
  print_md() 

penguins %>% 
  group_by(sex) %>% 
  data_tabulate(select = "island", collapse = TRUE)

library(easystats)  # once per session
describe_distribution(penguins)

data_tabulate(penguins, select = c("sex", "island")) |> 
  print_md() 

penguins %>% 
  group_by(sex) %>% 
  data_tabulate(select = "island", collapse = TRUE)

penguins <- read_csv("https://vincentarelbundock.github.io/Rdatasets/csv/palmerpenguins/penguins.csv")

head(penguins)

penguins %>% 
  summarise(across(bill_length_mm:body_mass_g, mean, na.rm = TRUE))

penguins %>% 
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE)))

penguins %>% 
  standardise(select = is.numeric) %>% 
  head()

penguins %>% 
  transmute(across(bill_length_mm:body_mass_g, 
                .fns = ~ {(.x - mean(.x, na.rm = TRUE)) / sd(.x, na.rm = TRUE)},
                .names = "{.col}_z")) %>% 
  head()

z_stand <- function(x){
  (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
}

d2 <-
penguins %>% 
  mutate(across(bill_length_mm:body_mass_g, 
                .fns = z_stand))
  
d2 %>% 
  glimpse()

d2 %>% 
  drop_na() %>% 
  rowwise() %>% 
  mutate(max_z = max(c(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g))) %>% 
  head()

library(ggpubr)  # must be installed

ggscatter(penguins,
          x = "bill_length_mm",
          y = "body_mass_g",
          color = "sex")

ggscatter(penguins,
          x = "bill_length_mm",
          y = "body_mass_g",
          color = "species",
          shape = "species",
          add = "reg.line",
          xlab = "Bill length (mm)",
          ylab = "Body maxx (g)",
          conf.int = TRUE,
          ellipse = TRUE,
          cor.coef = TRUE)

library(ggstatsplot)
ggbetweenstats(
  data = penguins,
  x = sex,
  y = body_mass_g)

penguins_no_na <-
penguins |> 
  drop_na()  # from package "tidyverse"

ggbetweenstats(
  data = penguins_no_na,
  x = sex,
  y = body_mass_g)

library(easystats)  # once per session only
describe_distribution(penguins) |> print_md()

library(flextable)
my_flex_tab <- flextable(head(penguins))
my_flex_tab

## save_as_docx("Table 1 " = my_flex_tab, path = "my_tab.docx")
## save_as_pptx("Table 1 " = my_flex_tab, path = "my_tab.pptx")

library(easystats)   # must be installed
df1 <- describe_distribution(mtcars)

str(df1)

## library(rio)  # must be installed
## export(df1, file = "df1.xlsx")
## export(df1, file = "df1.csv")

df2 <- data_tabulate(mtcars$am)
str(df2)

## export(df2, file = "df2.csv")

df3 <- data_tabulate(mtcars, select = c("am", "vs"))

df3 %>% str()

## export(df3[[1]], file = "df3.csv")
