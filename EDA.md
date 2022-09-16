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




## Data journey

@r4ds present a visual sketch of what could be called the "data journey",
i.e., the steps we are taking in order to learn from data, seen from an hands-on angle,
see @fig-data-journey.

![The data journey](img/data-journey.png){#fig-data-journey}


## Blitz data


See @sec-blitz-data for some data sets suitable to get going.


## Data Explorer

There are many systems and approaches to explore data. One particular interesting system is the R-package `DataExplorer`.

![R-package DataExplorer](img/dataexplorer-logo.png){width="20%"}

Check it out [on its Githup page](http://boxuancui.github.io/DataExplorer/).

## vtree

A bit similar to {DataExplorer}, the [R package {vtree}](https://nbarrowman.github.io/vtree) helps to explore visually datasets.

![vtree is used to generate variable trees, like the one above.](img/vtree-vertical.png)

## Tidyverse

The Tidyverse is probably the R thing with the most publicity. And it's great. It's a philosophy baken into an array of R packages. Perhaps central is the idea that a lot of little lego pieces, if fitting nicely together, provides a simple yet flexibel and thus powerful machinery.

## janitor

The R package {janitor} provides some nice stuff for data cleansing. Check out [this case study](https://www.exploringdata.org/post/how-to-clean-data-janitor-package/).


## The easystats way

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

