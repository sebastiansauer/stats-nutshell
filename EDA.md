---
output: html_document
editor_options: 
  chunk_output_type: console
---


# Exploratory Data Analysis

![](img/stern.png){width="5%"}



## R packages needed for this chapter


::: {.cell hash='EDA_cache/html/unnamed-chunk-1_6079e5ce64c5b66417274007c37270f5'}

```{.r .cell-code}
library(easystats)  # make stats easy again
library(tidyverse)  # data wrangling
library(tableone)  # tables
library(rstanarm)  # optional!
library(rio)  # import/export data, eg., to excel
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


::: {.cell hash='EDA_cache/html/unnamed-chunk-2_aec71c1ba93ceb55fcc7ef1e05d0c8bc'}

```{.r .cell-code}
library(easystats)  # once per session
describe_distribution(mtcars)
```

::: {.cell-output-display}
<div class="kable-table">

|Variable |       Mean|          SD|       IQR|    Min|     Max|   Skewness|   Kurtosis|  n| n_Missing|
|:--------|----------:|-----------:|---------:|------:|-------:|----------:|----------:|--:|---------:|
|mpg      |  20.090625|   6.0269481|   7.52500| 10.400|  33.900|  0.6723771| -0.0220063| 32|         0|
|cyl      |   6.187500|   1.7859216|   4.00000|  4.000|   8.000| -0.1922609| -1.7627939| 32|         0|
|disp     | 230.721875| 123.9386938| 221.52500| 71.100| 472.000|  0.4202331| -1.0675234| 32|         0|
|hp       | 146.687500|  68.5628685|  84.50000| 52.000| 335.000|  0.7994067|  0.2752116| 32|         0|
|drat     |   3.596563|   0.5346787|   0.84000|  2.760|   4.930|  0.2927802| -0.4504325| 32|         0|
|wt       |   3.217250|   0.9784574|   1.18625|  1.513|   5.424|  0.4659161|  0.4165947| 32|         0|
|qsec     |  17.848750|   1.7869432|   2.02250| 14.500|  22.900|  0.4063466|  0.8649307| 32|         0|
|vs       |   0.437500|   0.5040161|   1.00000|  0.000|   1.000|  0.2645418| -2.0632731| 32|         0|
|am       |   0.406250|   0.4989909|   1.00000|  0.000|   1.000|  0.4008089| -1.9665503| 32|         0|
|gear     |   3.687500|   0.7378041|   1.00000|  3.000|   5.000|  0.5823086| -0.8952916| 32|         0|
|carb     |   2.812500|   1.6152000|   2.00000|  1.000|   8.000|  1.1570911|  2.0200593| 32|         0|

</div>
:::
:::



`describe_distribution` provides us with an overview on typical descriptive summaries.


For nominal variables, consider `data_tabulate`:


::: {.cell hash='EDA_cache/html/unnamed-chunk-3_7ed716191172d307da328d7876b10cd0'}

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



::: {.cell hash='EDA_cache/html/unnamed-chunk-4_1e6710c7a4618c94812017b1dc0fb240'}

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



### TableOne

The [R package `{tableOne}`](https://cran.r-project.org/web/packages/tableone/vignettes/introduction.html) provides something like the typical "Table One" in many papers.


From the homepage:

>   The tableone package is an R package that eases the construction of “Table 1”, i.e., patient baseline characteristics table commonly found in biomedical research papers. The packages can summarize both continuous and categorical variables mixed within one table. Categorical variables can be summarized as counts and/or percentages. Continuous variables can be summarized in the “normal” way (means and standard deviations) or “nonnormal” way (medians and interquartile ranges).



::: {.cell hash='EDA_cache/html/unnamed-chunk-5_e1f3478568ec602eb0c4a272e7dbaaf2'}

```{.r .cell-code}
penguins <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/palmerpenguins/penguins.csv")
```
:::



It's quite simple to use:


::: {.cell hash='EDA_cache/html/unnamed-chunk-6_ac78d48410aa7b7d73fb3158679882f4'}

```{.r .cell-code}
CreateTableOne(data = penguins)
```

::: {.cell-output .cell-output-stdout}
```
                               
                                Overall         
  n                                 344         
  X (mean (SD))                  172.50 (99.45) 
  species (%)                                   
     Adelie                         152 (44.2)  
     Chinstrap                       68 (19.8)  
     Gentoo                         124 (36.0)  
  island (%)                                    
     Biscoe                         168 (48.8)  
     Dream                          124 (36.0)  
     Torgersen                       52 (15.1)  
  bill_length_mm (mean (SD))      43.92 (5.46)  
  bill_depth_mm (mean (SD))       17.15 (1.97)  
  flipper_length_mm (mean (SD))  200.92 (14.06) 
  body_mass_g (mean (SD))       4201.75 (801.95)
  sex = male (%)                    168 (50.5)  
  year (mean (SD))              2008.03 (0.82)  
```
:::
:::



To get more detailled results, use the `summary` method:


::: {.cell hash='EDA_cache/html/unnamed-chunk-7_053fbe311e825a6dc5057c0bbaff35ca'}

```{.r .cell-code}
tab1 <- CreateTableOne(data = penguins)
summary(tab1)
```

::: {.cell-output .cell-output-stdout}
```

     ### Summary of continuous variables ###

strata: Overall
                    n miss p.miss mean    sd median  p25  p75  min  max  skew
X                 344    0    0.0  172  99.4    172   87  258    1  344  0.00
bill_length_mm    344    2    0.6   44   5.5     44   39   48   32   60  0.05
bill_depth_mm     344    2    0.6   17   2.0     17   16   19   13   22 -0.14
flipper_length_mm 344    2    0.6  201  14.1    197  190  213  172  231  0.35
body_mass_g       344    2    0.6 4202 802.0   4050 3550 4750 2700 6300  0.47
year              344    0    0.0 2008   0.8   2008 2007 2009 2007 2009 -0.05
                  kurt
X                 -1.2
bill_length_mm    -0.9
bill_depth_mm     -0.9
flipper_length_mm -1.0
body_mass_g       -0.7
year              -1.5

=======================================================================================

     ### Summary of categorical variables ### 

strata: Overall
     var   n miss p.miss     level freq percent cum.percent
 species 344    0    0.0    Adelie  152    44.2        44.2
                         Chinstrap   68    19.8        64.0
                            Gentoo  124    36.0       100.0
                                                           
  island 344    0    0.0    Biscoe  168    48.8        48.8
                             Dream  124    36.0        84.9
                         Torgersen   52    15.1       100.0
                                                           
     sex 344   11    3.2    female  165    49.5        49.5
                              male  168    50.5       100.0
                                                           
```
:::
:::






## Tidyverse

### Intro to the tidyverse

The Tidyverse is probably the R thing with the most publicity. And it's great. It's a philosophy baken into an array of R packages. Perhaps central is the idea that a lot of little lego pieces, if fitting nicely together, provides a simple yet flexibel and thus powerful machinery.

There's a lot of introctory material to the tidyverse around [for instance ](https://datasciencebook.ca/wrangling.html), so I'm not repeating that here.



### More advanced tidyverse






#### Repeat a function over many columns

At times, we would like to compute the same functions for many variables, ie columns for tidyverse applications.

Let's load the penguins data for illustration.


::: {.cell hash='EDA_cache/html/unnamed-chunk-8_9c5cb99ec8d24ceb9bfa5dc32c3a17f3'}

```{.r .cell-code}
d <- read_csv("https://vincentarelbundock.github.io/Rdatasets/csv/palmerpenguins/penguins.csv")

head(d)
```

::: {.cell-output-display}
<div class="kable-table">

| ...1|species |island    | bill_length_mm| bill_depth_mm| flipper_length_mm| body_mass_g|sex    | year|
|----:|:-------|:---------|--------------:|-------------:|-----------------:|-----------:|:------|----:|
|    1|Adelie  |Torgersen |           39.1|          18.7|               181|        3750|male   | 2007|
|    2|Adelie  |Torgersen |           39.5|          17.4|               186|        3800|female | 2007|
|    3|Adelie  |Torgersen |           40.3|          18.0|               195|        3250|female | 2007|
|    4|Adelie  |Torgersen |             NA|            NA|                NA|          NA|NA     | 2007|
|    5|Adelie  |Torgersen |           36.7|          19.3|               193|        3450|female | 2007|
|    6|Adelie  |Torgersen |           39.3|          20.6|               190|        3650|male   | 2007|

</div>
:::
:::



Say, we would like to compute the mean value for each numeric variable in the data set:



::: {.cell hash='EDA_cache/html/unnamed-chunk-9_edaaf29be7067282662be2c029a58835'}

```{.r .cell-code}
d %>% 
  summarise(across(bill_length_mm:body_mass_g, mean, na.rm = TRUE))
```

::: {.cell-output-display}
<div class="kable-table">

| bill_length_mm| bill_depth_mm| flipper_length_mm| body_mass_g|
|--------------:|-------------:|-----------------:|-----------:|
|       43.92193|      17.15117|          200.9152|    4201.754|

</div>
:::
:::



Synonymously, we could write:


::: {.cell hash='EDA_cache/html/unnamed-chunk-10_fc59f8a3a6d73adbca9e4fb157a24f45'}

```{.r .cell-code}
d %>% 
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE)))
```

::: {.cell-output-display}
<div class="kable-table">

|  ...1| bill_length_mm| bill_depth_mm| flipper_length_mm| body_mass_g|     year|
|-----:|--------------:|-------------:|-----------------:|-----------:|--------:|
| 172.5|       43.92193|      17.15117|          200.9152|    4201.754| 2008.029|

</div>
:::
:::



Say, we would like to compute the z-value of each numeric variable.

Addmittedly, `easystats` makes it quite simple:



::: {.cell hash='EDA_cache/html/unnamed-chunk-11_02cc84d5aa2e9df1dd350484823abe18'}

```{.r .cell-code}
d %>% 
  standardise(select = is.numeric) %>% 
  head()
```

::: {.cell-output-display}
<div class="kable-table">

|      ...1|species |island    | bill_length_mm| bill_depth_mm| flipper_length_mm| body_mass_g|sex    |      year|
|---------:|:-------|:---------|--------------:|-------------:|-----------------:|-----------:|:------|---------:|
| -1.724511|Adelie  |Torgersen |     -0.8832047|     0.7843001|        -1.4162715|  -0.5633167|male   | -1.257484|
| -1.714456|Adelie  |Torgersen |     -0.8099390|     0.1260033|        -1.0606961|  -0.5009690|female | -1.257484|
| -1.704400|Adelie  |Torgersen |     -0.6634077|     0.4298326|        -0.4206603|  -1.1867934|female | -1.257484|
| -1.694345|Adelie  |Torgersen |             NA|            NA|                NA|          NA|NA     | -1.257484|
| -1.684289|Adelie  |Torgersen |     -1.3227986|     1.0881294|        -0.5628905|  -0.9374027|female | -1.257484|
| -1.674234|Adelie  |Torgersen |     -0.8465718|     1.7464261|        -0.7762357|  -0.6880121|male   | -1.257484|

</div>
:::
:::



See the help page of `standardise` for mor details on how to select variables and on more options.


But for the purpose of illustration, let's do it with more simple means, i.e. tidyverse only.



::: {.cell hash='EDA_cache/html/unnamed-chunk-12_e2cc7a54ffd4d4fc40c4d75d86a85e6e'}

```{.r .cell-code}
d %>% 
  transmute(across(bill_length_mm:body_mass_g, 
                .fns = ~ {(.x - mean(.x, na.rm = TRUE)) / sd(.x, na.rm = TRUE)},
                .names = "{.col}_z")) %>% 
  head()
```

::: {.cell-output-display}
<div class="kable-table">

| bill_length_mm_z| bill_depth_mm_z| flipper_length_mm_z| body_mass_g_z|
|----------------:|---------------:|-------------------:|-------------:|
|       -0.8832047|       0.7843001|          -1.4162715|    -0.5633167|
|       -0.8099390|       0.1260033|          -1.0606961|    -0.5009690|
|       -0.6634077|       0.4298326|          -0.4206603|    -1.1867934|
|               NA|              NA|                  NA|            NA|
|       -1.3227986|       1.0881294|          -0.5628905|    -0.9374027|
|       -0.8465718|       1.7464261|          -0.7762357|    -0.6880121|

</div>
:::
:::



It's maybe more succint to put the z-value computation in its function, and then just apply this function:


::: {.cell hash='EDA_cache/html/unnamed-chunk-13_f13ab5640f3f2b377d5f1978327443fc'}

```{.r .cell-code}
z_stand <- function(x){
  (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
}
```
:::

::: {.cell hash='EDA_cache/html/unnamed-chunk-14_25fac674f4b632acf36e7e8d41235418'}

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
$ ...1              <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1…
$ species           <chr> "Adelie", "Adelie", "Adelie", "Adelie", "Adelie", "A…
$ island            <chr> "Torgersen", "Torgersen", "Torgersen", "Torgersen", …
$ bill_length_mm    <dbl> -0.8832047, -0.8099390, -0.6634077, NA, -1.3227986, …
$ bill_depth_mm     <dbl> 0.78430007, 0.12600328, 0.42983257, NA, 1.08812936, …
$ flipper_length_mm <dbl> -1.4162715, -1.0606961, -0.4206603, NA, -0.5628905, …
$ body_mass_g       <dbl> -0.563316704, -0.500969030, -1.186793445, NA, -0.937…
$ sex               <chr> "male", "female", "female", NA, "female", "male", "f…
$ year              <dbl> 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007…
```
:::
:::



#### Rowwise operations


For technical reasons, it's a bit cumbersome in (base) R to compute rowwise operations. 
The thing is, R's dataframes are organized as vectors of *columns* so it's much easier to do stuff columnwise.

However, since recently, computing rowwise operations with the tidyverse has become simpler.
Consider the following example. Say we would like to know the highest z-value for each variable we just computed, that is the highest values *per individual*, ie., by row in the data frame.




::: {.cell hash='EDA_cache/html/unnamed-chunk-15_5a44817c1572357524406907f4369d3e'}

```{.r .cell-code}
d2 %>% 
  drop_na() %>% 
  rowwise() %>% 
  mutate(max_z = max(c(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g))) %>% 
  head()
```

::: {.cell-output-display}
<div class="kable-table">

| ...1|species |island    | bill_length_mm| bill_depth_mm| flipper_length_mm| body_mass_g|sex    | year|     max_z|
|----:|:-------|:---------|--------------:|-------------:|-----------------:|-----------:|:------|----:|---------:|
|    1|Adelie  |Torgersen |     -0.8832047|     0.7843001|        -1.4162715|  -0.5633167|male   | 2007| 0.7843001|
|    2|Adelie  |Torgersen |     -0.8099390|     0.1260033|        -1.0606961|  -0.5009690|female | 2007| 0.1260033|
|    3|Adelie  |Torgersen |     -0.6634077|     0.4298326|        -0.4206603|  -1.1867934|female | 2007| 0.4298326|
|    5|Adelie  |Torgersen |     -1.3227986|     1.0881294|        -0.5628905|  -0.9374027|female | 2007| 1.0881294|
|    6|Adelie  |Torgersen |     -0.8465718|     1.7464261|        -0.7762357|  -0.6880121|male   | 2007| 1.7464261|
|    7|Adelie  |Torgersen |     -0.9198375|     0.3285561|        -1.4162715|  -0.7191859|female | 2007| 0.3285561|

</div>
:::
:::




## Exporting to Office


### Excel

The most straightforward approach is to convince your EDA function to produce a data frame.
Data frames can be written as CSV or XLSX to disk, and then easily imported to office packages.

`easystats` and `tidyverse` are two examples where this happens.



::: {.cell hash='EDA_cache/html/unnamed-chunk-16_311d9415aa3418b833531df578b9d4f5'}

```{.r .cell-code}
df1 <- describe_distribution(mtcars)
```
:::


Now, `df1` is a data frame:


::: {.cell hash='EDA_cache/html/unnamed-chunk-17_4a2763ef0667ef5e2c158c384d0c3655'}

```{.r .cell-code}
str(df1)
```

::: {.cell-output .cell-output-stdout}
```
Classes 'parameters_distribution', 'see_parameters_distribution' and 'data.frame':	11 obs. of  10 variables:
 $ Variable : chr  "mpg" "cyl" "disp" "hp" ...
 $ Mean     : num  20.09 6.19 230.72 146.69 3.6 ...
 $ SD       : num  6.027 1.786 123.939 68.563 0.535 ...
 $ IQR      : num  7.53 4 221.53 84.5 0.84 ...
 $ Min      : num  10.4 4 71.1 52 2.76 ...
 $ Max      : num  33.9 8 472 335 4.93 ...
 $ Skewness : num  0.672 -0.192 0.42 0.799 0.293 ...
 $ Kurtosis : num  -0.022 -1.763 -1.068 0.275 -0.45 ...
 $ n        : int  32 32 32 32 32 32 32 32 32 32 ...
 $ n_Missing: int  0 0 0 0 0 0 0 0 0 0 ...
 - attr(*, "object_name")= chr "mtcars"
 - attr(*, "threshold")= num 0.1
```
:::
:::



Let's export as XLSX (via the R package `rio`) and as CSV:




::: {.cell hash='EDA_cache/html/unnamed-chunk-18_39b05e91bbda54716e6ff1de6d0d4af5'}

```{.r .cell-code}
export(df1, file = "df1.xlsx")
export(df1, file = "df1.csv")
```
:::



For exporting `csv` files we could also use `write_csv()` from the tidyverse or `write.csv` from base R.



::: {.cell hash='EDA_cache/html/unnamed-chunk-19_862493b4eaa7ccfc9d9fa5e838a94959'}

```{.r .cell-code}
df2 <- data_tabulate(mtcars$am)
str(df2)
```

::: {.cell-output .cell-output-stdout}
```
Classes 'dw_data_tabulate' and 'data.frame':	3 obs. of  6 variables:
 $ Variable    : chr  "mtcars$am" "mtcars$am" "mtcars$am"
 $ Value       : Factor w/ 2 levels "0","1": 1 2 NA
 $ N           : int  19 13 0
 $ Raw %       : num  59.4 40.6 0
 $ Valid %     : num  59.4 40.6 NA
 $ Cumulative %: num  59.4 100 NA
 - attr(*, "type")= chr "numeric"
 - attr(*, "object")= chr "mtcars$am"
 - attr(*, "duplicate_varnames")= logi [1:3] FALSE TRUE TRUE
 - attr(*, "total_n")= int 32
 - attr(*, "valid_n")= int 32
```
:::
:::

::: {.cell hash='EDA_cache/html/unnamed-chunk-20_6399da51a8a6595057d8eacb8de1eb36'}

```{.r .cell-code}
export(df2, file = "df2.csv")
```
:::



Note that if we use `data_tabulate` like this:


::: {.cell hash='EDA_cache/html/unnamed-chunk-21_ef0f031b84fac9d57d4cec4012df68dc'}

```{.r .cell-code}
df3 <- data_tabulate(mtcars, select = c("am", "vs"))

df3 %>% str()
```

::: {.cell-output .cell-output-stdout}
```
List of 2
 $ :Classes 'dw_data_tabulate' and 'data.frame':	3 obs. of  6 variables:
  ..$ Variable    : chr [1:3] "am" "am" "am"
  ..$ Value       : Factor w/ 2 levels "0","1": 1 2 NA
  ..$ N           : int [1:3] 19 13 0
  ..$ Raw %       : num [1:3] 59.4 40.6 0
  ..$ Valid %     : num [1:3] 59.4 40.6 NA
  ..$ Cumulative %: num [1:3] 59.4 100 NA
  ..- attr(*, "type")= chr "numeric"
  ..- attr(*, "varname")= chr "am"
  ..- attr(*, "object")= chr "am"
  ..- attr(*, "duplicate_varnames")= logi [1:3] FALSE TRUE TRUE
  ..- attr(*, "total_n")= int 32
  ..- attr(*, "valid_n")= int 32
 $ :Classes 'dw_data_tabulate' and 'data.frame':	3 obs. of  6 variables:
  ..$ Variable    : chr [1:3] "vs" "vs" "vs"
  ..$ Value       : Factor w/ 2 levels "0","1": 1 2 NA
  ..$ N           : int [1:3] 18 14 0
  ..$ Raw %       : num [1:3] 56.2 43.8 0
  ..$ Valid %     : num [1:3] 56.2 43.8 NA
  ..$ Cumulative %: num [1:3] 56.2 100 NA
  ..- attr(*, "type")= chr "numeric"
  ..- attr(*, "varname")= chr "vs"
  ..- attr(*, "object")= chr "vs"
  ..- attr(*, "duplicate_varnames")= logi [1:3] FALSE TRUE TRUE
  ..- attr(*, "total_n")= int 32
  ..- attr(*, "valid_n")= int 32
 - attr(*, "class")= chr [1:2] "dw_data_tabulates" "list"
 - attr(*, "collapse")= logi FALSE
```
:::
:::



We'll get a *list* of two data frames.

To export either, we need to access each list list element:


::: {.cell hash='EDA_cache/html/unnamed-chunk-22_421f0386ac5c345c3cd71d5237b50152'}

```{.r .cell-code}
export(df3[[1]], file = "df3.csv")
```
:::




### Word


Obviously, once your data has arriven as a spreadsheet in Excel (or similar software packages),
it's no big deal to get it into Word processors as well.

In addition, one [user gave the following recommendation on StackOverflow](https://stackoverflow.com/questions/60815583/how-to-save-table1-package-output-table-to-doc-format-r):


>   Another possible solution: The above strategy did not work for me when I had a similar issue, but it was resolved once I knitted the table1 object and opened the html in browser to copy the html table and successfully paste into word. Doing it within RStudio viewer would not work for me for some reason.


Lastly, there are options to export directly to Word or Powerpoint.
The R package `flextable` provides functions for that purpose:




::: {.cell hash='EDA_cache/html/unnamed-chunk-23_3bc583d5cd13c8f80ad1cb4a68b3e064'}

```{.r .cell-code}
library(flextable)
my_flex_tab <- flextable(penguins)

save_as_docx("Table 1 " = my_flex_tab, path = "my_tab.docx")

save_as_pptx("Table 1 " = my_flex_tab, path = "my_tab.pptx")
```
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

