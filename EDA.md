---
output: html_document
editor_options: 
  chunk_output_type: console
---



# Exploratory Data Analysis

![](img/stern.png){width="5%"}



## R packages needed for this chapter



::: {.cell hash='EDA_cache/pdf/unnamed-chunk-1_431d269fc5bf37acc77b746e1e7b09cc'}

```{.r .cell-code}
library(easystats)
library(tidyverse)
library(rstanarm)  # optional!
```
:::





## What's EDA?


Exploratory Data Analysis (EDA) is a procedure to scrutinize a dataset at hand in order learn about it. EDA comprises descriptive statistics, data visualization and data transformation techniques (such as dimension reduction).

It's not so mathematical deep as modelling, but in practice it's really important.

There's this famous saying:

> In Data Science, 80% of time spent prepare data, 20% of time spent complain about the need to prepare data.

EDA can roughly be said to comprise the following parts:

-   Importing (and exporting) data
-   Data cleansing (such as deal with missing data etc)
-   Data transformation or "wrangling" (such as long to wide format)
-   Computing desriptive statistics (such as the notorious mean)
-   Analyzing distributions (is it normal?)
-   Finding patterns in data (aka data mining)
-   More complex data transformation techniques (such as factor analysis)




## Data journey {#sec-data-journey}

@r4ds present a visual sketch of what could be called the "data journey",
i.e., the steps we are taking in order to learn from data, seen from an hands-on angle,
see @fig-data-journey.

![The data journey](img/data-journey.png){#fig-data-journey}


## Blitz data


See @sec-blitz-data for some data sets suitable to get going.


## Data cleansing

The R package {janitor} provides some nice stuff for data cleansing. Check out [this case study](https://www.exploringdata.org/post/how-to-clean-data-janitor-package/).



## Convenience functions

There a quite a few functions (residing in some packages) that help you doing EDA from a helicoptor point of view. In other words, you do not have to pay attention to nitty-gritty details, the function will do that for you. 
This is approach is, well, convenient, but of course comes at a price.
You will not have a great amount of choice and influence on the way the data is analyzed and presented. 


### Data Explorer

There are many systems and approaches to explore data. One particular interesting system is the R-package `DataExplorer`.

![R-package DataExplorer](img/dataexplorer-logo.png){width="20%"}

Check it out [on its Githup page](http://boxuancui.github.io/DataExplorer/).













### vtree

A bit similar to {DataExplorer}, the [R package {vtree}](https://nbarrowman.github.io/vtree) helps to explore visually datasets.

![vtree is used to generate variable trees, like the one above.](img/vtree-vertical.png)



### The easystats way

There are some packages, such as `{easystats}`, which provide comfortable access to basic statistics:



::: {.cell hash='EDA_cache/pdf/unnamed-chunk-2_f3fdfb14a69495e6e192ae18101fcca1'}

```{.r .cell-code}
library(easystats)  # once per session
describe_distribution(mtcars)
```

::: {.cell-output .cell-output-stdout}
```
Variable |   Mean |     SD |    IQR |           Range | Skewness | Kurtosis |  n | n_Missing
--------------------------------------------------------------------------------------------
mpg      |  20.09 |   6.03 |   7.53 |  [10.40, 33.90] |     0.67 |    -0.02 | 32 |         0
cyl      |   6.19 |   1.79 |   4.00 |    [4.00, 8.00] |    -0.19 |    -1.76 | 32 |         0
disp     | 230.72 | 123.94 | 221.53 | [71.10, 472.00] |     0.42 |    -1.07 | 32 |         0
hp       | 146.69 |  68.56 |  84.50 | [52.00, 335.00] |     0.80 |     0.28 | 32 |         0
drat     |   3.60 |   0.53 |   0.84 |    [2.76, 4.93] |     0.29 |    -0.45 | 32 |         0
wt       |   3.22 |   0.98 |   1.19 |    [1.51, 5.42] |     0.47 |     0.42 | 32 |         0
qsec     |  17.85 |   1.79 |   2.02 |  [14.50, 22.90] |     0.41 |     0.86 | 32 |         0
vs       |   0.44 |   0.50 |   1.00 |    [0.00, 1.00] |     0.26 |    -2.06 | 32 |         0
am       |   0.41 |   0.50 |   1.00 |    [0.00, 1.00] |     0.40 |    -1.97 | 32 |         0
gear     |   3.69 |   0.74 |   1.00 |    [3.00, 5.00] |     0.58 |    -0.90 | 32 |         0
carb     |   2.81 |   1.62 |   2.00 |    [1.00, 8.00] |     1.16 |     2.02 | 32 |         0
```
:::
:::




`describe_distribution` provides us with an overview on typical descriptive summaries.


For nominal variables, consider `data_tabulate`:



::: {.cell hash='EDA_cache/pdf/unnamed-chunk-3_2b9091cc3e2b49589785e3c2d120e817'}

```{.r .cell-code}
data_tabulate(mtcars, select = c("am", "vs"))
```

::: {.cell-output .cell-output-stdout}
```
am (am) <numeric>
# total N=32 valid N=32

Value |  N | Raw % | Valid % | Cumulative %
------+----+-------+---------+-------------
0     | 19 | 59.38 |   59.38 |        59.38
1     | 13 | 40.62 |   40.62 |       100.00
<NA>  |  0 |  0.00 |    <NA> |         <NA>

vs (vs) <numeric>
# total N=32 valid N=32

Value |  N | Raw % | Valid % | Cumulative %
------+----+-------+---------+-------------
0     | 18 | 56.25 |   56.25 |        56.25
1     | 14 | 43.75 |   43.75 |       100.00
<NA>  |  0 |  0.00 |    <NA> |         <NA>
```
:::
:::




We can also get *grouped* tabulations,
which amounts to something similar to a [contingency table](https://en.wikipedia.org/wiki/Contingency_table):




::: {.cell hash='EDA_cache/pdf/unnamed-chunk-4_377d7803cdf903320b4888ed1f00224a'}

```{.r .cell-code}
mtcars %>% 
  group_by(am) %>% 
  data_tabulate(select = "vs", collapse = TRUE)
```

::: {.cell-output .cell-output-stdout}
```
# Frequency Table

Variable |  Group | Value |  N | Raw % | Valid % | Cumulative %
---------+--------+-------+----+-------+---------+-------------
vs       | am (0) |     0 | 12 | 63.16 |   63.16 |        63.16
         |        |     1 |  7 | 36.84 |   36.84 |       100.00
         |        |  <NA> |  0 |  0.00 |    <NA> |         <NA>
---------+--------+-------+----+-------+---------+-------------
vs       | am (1) |     0 |  6 | 46.15 |   46.15 |        46.15
         |        |     1 |  7 | 53.85 |   53.85 |       100.00
         |        |  <NA> |  0 |  0.00 |    <NA> |         <NA>
---------------------------------------------------------------
```
:::
:::






:::{callout-note}
Checkout the function reference of your favorite package in order to learn what's on the shelf.
For example, [here's the function reference site](https://easystats.github.io/datawizard/reference/index.html) of `datawizard`, one of the packages in the `easystats` ecosystem.
::::




## Tidyverse

### Intro to the tidyverse

The Tidyverse is probably the R thing with the most publicity. And it's great. It's a philosophy baken into an array of R packages. Perhaps central is the idea that a lot of little lego pieces, if fitting nicely together, provides a simple yet flexibel and thus powerful machinery.

There's a lot of introctory material to the tidyverse around [for instance ](https://datasciencebook.ca/wrangling.html), so I'm not repeating that here.



### More advanced tidyverse






#### Repeat a function over many columns

At times, we would like to compute the same functions for many variables, ie columns for tidyverse applications.

Let's load the penguins data for illustration.



::: {.cell hash='EDA_cache/pdf/unnamed-chunk-5_ab7d86234658a50d716a2b200aebfa17'}

```{.r .cell-code}
d <- read_csv("https://vincentarelbundock.github.io/Rdatasets/csv/palmerpenguins/penguins.csv")

head(d)
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 6 x 9
   ...1 species island    bill_length_mm bill_dept~1 flipp~2 body_~3 sex    year
  <dbl> <chr>   <chr>              <dbl>       <dbl>   <dbl>   <dbl> <chr> <dbl>
1     1 Adelie  Torgersen           39.1        18.7     181    3750 male   2007
2     2 Adelie  Torgersen           39.5        17.4     186    3800 fema~  2007
3     3 Adelie  Torgersen           40.3        18       195    3250 fema~  2007
4     4 Adelie  Torgersen           NA          NA        NA      NA <NA>   2007
5     5 Adelie  Torgersen           36.7        19.3     193    3450 fema~  2007
6     6 Adelie  Torgersen           39.3        20.6     190    3650 male   2007
# ... with abbreviated variable names 1: bill_depth_mm, 2: flipper_length_mm,
#   3: body_mass_g
```
:::
:::




Say, we would like to compute the mean value for each numeric variable in the data set:




::: {.cell hash='EDA_cache/pdf/unnamed-chunk-6_0f79885fa2a6b112be3d21d22065d69d'}

```{.r .cell-code}
d %>% 
  summarise(across(bill_length_mm:body_mass_g, mean, na.rm = TRUE))
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 1 x 4
  bill_length_mm bill_depth_mm flipper_length_mm body_mass_g
           <dbl>         <dbl>             <dbl>       <dbl>
1           43.9          17.2              201.       4202.
```
:::
:::




Synonymously, we could write:



::: {.cell hash='EDA_cache/pdf/unnamed-chunk-7_5ad5da7219adcc7ff1e7886d3a6dd25b'}

```{.r .cell-code}
d %>% 
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE)))
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 1 x 6
   ...1 bill_length_mm bill_depth_mm flipper_length_mm body_mass_g  year
  <dbl>          <dbl>         <dbl>             <dbl>       <dbl> <dbl>
1  172.           43.9          17.2              201.       4202. 2008.
```
:::
:::




Say, we would like to compute the z-value of each numeric variable.

Addmittedly, `easystats` makes it quite simple:




::: {.cell hash='EDA_cache/pdf/unnamed-chunk-8_86e7a22ecf6d85226216f00a6eae441a'}

```{.r .cell-code}
d %>% 
  standardise(select = is.numeric) %>% 
  head()
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 6 x 9
   ...1 species island    bill_length_mm bill_dept~1 flipp~2 body_~3 sex    year
  <dbl> <chr>   <chr>              <dbl>       <dbl>   <dbl>   <dbl> <chr> <dbl>
1 -1.72 Adelie  Torgersen         -0.883       0.784  -1.42   -0.563 male  -1.26
2 -1.71 Adelie  Torgersen         -0.810       0.126  -1.06   -0.501 fema~ -1.26
3 -1.70 Adelie  Torgersen         -0.663       0.430  -0.421  -1.19  fema~ -1.26
4 -1.69 Adelie  Torgersen         NA          NA      NA      NA     <NA>  -1.26
5 -1.68 Adelie  Torgersen         -1.32        1.09   -0.563  -0.937 fema~ -1.26
6 -1.67 Adelie  Torgersen         -0.847       1.75   -0.776  -0.688 male  -1.26
# ... with abbreviated variable names 1: bill_depth_mm, 2: flipper_length_mm,
#   3: body_mass_g
```
:::
:::




See the help page of `standardise` for mor details on how to select variables and on more options.


But for the purpose of illustration, let's do it with more simple means, i.e. tidyverse only.




::: {.cell hash='EDA_cache/pdf/unnamed-chunk-9_126632baca152d41cb607b118549c3d3'}

```{.r .cell-code}
d %>% 
  transmute(across(bill_length_mm:body_mass_g, 
                .fns = ~ {(.x - mean(.x, na.rm = TRUE)) / sd(.x, na.rm = TRUE)},
                .names = "{.col}_z"))
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 344 x 4
   bill_length_mm_z bill_depth_mm_z flipper_length_mm_z body_mass_g_z
              <dbl>           <dbl>               <dbl>         <dbl>
 1           -0.883           0.784              -1.42        -0.563 
 2           -0.810           0.126              -1.06        -0.501 
 3           -0.663           0.430              -0.421       -1.19  
 4           NA              NA                  NA           NA     
 5           -1.32            1.09               -0.563       -0.937 
 6           -0.847           1.75               -0.776       -0.688 
 7           -0.920           0.329              -1.42        -0.719 
 8           -0.865           1.24               -0.421        0.590 
 9           -1.80            0.480              -0.563       -0.906 
10           -0.352           1.54               -0.776        0.0602
# ... with 334 more rows
```
:::
:::




It's maybe more succint to put the z-value computation in its function, and then just apply this function:



::: {.cell hash='EDA_cache/pdf/unnamed-chunk-10_32a44461ebbf4a0f3329d9a2f134be62'}

```{.r .cell-code}
z_stand <- function(x){
  (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
}
```
:::

::: {.cell hash='EDA_cache/pdf/unnamed-chunk-11_972f0daa2aa21f19e4290cb88863a717'}

```{.r .cell-code}
d2 <-
d %>% 
  mutate(across(bill_length_mm:body_mass_g, 
                .fns = z_stand))
  
d2 %>% 
  glimpse()
```

::: {.cell-output .cell-output-stdout}
```
Rows: 344
Columns: 9
$ ...1              <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1~
$ species           <chr> "Adelie", "Adelie", "Adelie", "Adelie", "Adelie", "A~
$ island            <chr> "Torgersen", "Torgersen", "Torgersen", "Torgersen", ~
$ bill_length_mm    <dbl> -0.8832047, -0.8099390, -0.6634077, NA, -1.3227986, ~
$ bill_depth_mm     <dbl> 0.78430007, 0.12600328, 0.42983257, NA, 1.08812936, ~
$ flipper_length_mm <dbl> -1.4162715, -1.0606961, -0.4206603, NA, -0.5628905, ~
$ body_mass_g       <dbl> -0.563316704, -0.500969030, -1.186793445, NA, -0.937~
$ sex               <chr> "male", "female", "female", NA, "female", "male", "f~
$ year              <dbl> 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007~
```
:::
:::




### Rowwise operations


For technical reasons, it's a bit cumbersome in (base) R to compute rowwise operations. 
The thing is, R's dataframes are organized as vectors of *columns* so it's much easier to do stuff columnwise.

However, since recently, computing rowwise operations with the tidyverse has become simpler.
Consider the following example. Say we would like to know the highest z-value for each variable we just computed, that is the highest values *per individual*, ie., by row in the data frame.





::: {.cell hash='EDA_cache/pdf/unnamed-chunk-12_ba6cc72661da17bdb6a2892785cff8b4'}

```{.r .cell-code}
d2 %>% 
  drop_na() %>% 
  rowwise() %>% 
  mutate(max_z = max(c(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g))) %>% 
  head()
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 6 x 10
# Rowwise: 
   ...1 species island    bill_lengt~1 bill_~2 flipp~3 body_~4 sex    year max_z
  <dbl> <chr>   <chr>            <dbl>   <dbl>   <dbl>   <dbl> <chr> <dbl> <dbl>
1     1 Adelie  Torgersen       -0.883   0.784  -1.42   -0.563 male   2007 0.784
2     2 Adelie  Torgersen       -0.810   0.126  -1.06   -0.501 fema~  2007 0.126
3     3 Adelie  Torgersen       -0.663   0.430  -0.421  -1.19  fema~  2007 0.430
4     5 Adelie  Torgersen       -1.32    1.09   -0.563  -0.937 fema~  2007 1.09 
5     6 Adelie  Torgersen       -0.847   1.75   -0.776  -0.688 male   2007 1.75 
6     7 Adelie  Torgersen       -0.920   0.329  -1.42   -0.719 fema~  2007 0.329
# ... with abbreviated variable names 1: bill_length_mm, 2: bill_depth_mm,
#   3: flipper_length_mm, 4: body_mass_g
```
:::
:::





## Case Study

![R package/dataset palmerpenguins](img/palmerpenguins-logo.png){width="20%"}

Explore the `palmerpenguins` dataset, it's a famous dataset made for learning data analysis.

There's a great [interactive course on EDA based on the penguins](https://allisonhorst.shinyapps.io/dplyr-learnr/#section-welcome). Have a look, it's great!




[Go penguins! Allez!](https://media.giphy.com/media/3og0IO5z8Rd30ktV6g/giphy.gif){width="50%"}

## Cheatsheets

There are a number of nice cheat sheets [available on an array of topics related to EDA](https://www.rstudio.com/resources/cheatsheets/), made available by the folks at RStudio.


Consider this collection:

- [{dplyr}: data wrangling](https://raw.githubusercontent.com/rstudio/cheatsheets/main/pngs/data-transformation.png)

- [{tidyr}: data preparation](https://raw.githubusercontent.com/rstudio/cheatsheets/main/pngs/tidyr.png)

- [{ggplot}: data visualization](https://raw.githubusercontent.com/rstudio/cheatsheets/main/pngs/data-visualization.png)

- [{gtsummary}: publication ready tables](https://raw.githubusercontent.com/rstudio/cheatsheets/main/pngs/gtsummary.png)


So much great stuff! A bit too much to digest in one go, 
but definitely worthwhile if you plan to dig deeper in data analysis.



## Literature

@r4ds is an highly recommendable resource in order to get a thorough understanding of data analysis using R. Note that this source is focusing on the "how to", not so much to theoretical foundations.
@ismay_statistical_2020 is a gently introduction into many steps on the data journey, including EDA.

