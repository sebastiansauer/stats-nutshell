# Exploratory Data Analysis

Exploratory Data Analysis (EDA) is a procedure to scrutinize a dataset at hand in order learn about it. EDA comprises descriptive statistics, data visualization and data transformation techniques (such as dimension reduction).


It's not so mathematical deep as modelling, but in practice it's really important.

There's this famous saying:


>   In Data Science, 80% of time spent prepare data, 20% of time spent complain about the need to prepare data.


EDA can roughly be said to comprise the following parts:

- Importing (and exporting) data
- Data cleansing (such as deal with missing data etc)
- Data transformation or "wrangling" (such as long to wide format)
- Computing desriptive statistics (such as the notorious mean)
- Analyzing distributions (is it normal?)
- Finding patterns in data (aka data mining)
- More complex data transformation techniques (such as factor analysis)


## Data Explorer

There are many systems and approaches to explore data.
One particular interesting system is the R-package `DataExplorer`.


![R-package DataExplorer](http://boxuancui.github.io/DataExplorer/reference/figures/logo.png){width=20%}


Check it out [on its Githup page](http://boxuancui.github.io/DataExplorer/).




## vtree

A bit similar to {DataExplorer}, the [R package {vtree}](https://nbarrowman.github.io/vtree) helps to explore visually datasets. 

![vtree is used to generate variable trees, like the one above.](https://nbarrowman.github.io/images/vertical.png)


## Tidyverse

The Tidyverse is probably the R thing with the most publicity. And it's great.
It's a philosophy baken into an array of R packages. 
Perhaps central is the idea that a lot of little lego pieces, if fitting nicely together, provides a simple yet flexibel and thus powerful machinery.




## janitor

The R package {janitor} provides some nice stuff for data cleansing.
Check out [this case study](https://www.exploringdata.org/post/how-to-clean-data-janitor-package/).





## Case Study

![R package/dataset palmerpenguins](https://allisonhorst.github.io/palmerpenguins/logo.png){width=20%}


Explore the `palmerpenguins` dataset, it's a famous dataset made for learning data analysis.


There's a great [interactive course on EDA based on the penguins](https://allisonhorst.shinyapps.io/dplyr-learnr/#section-welcome).
Have a look, it's great!


![Release the penguins](https://media.giphy.com/media/3og0IO5z8Rd30ktV6g/giphy.gif){width=50%}



## Cheatsheets

There are a number of nice cheatsheets [available on an array of topics related to EDA](https://www.rstudio.com/resources/cheatsheets/), made available by the folks at RStudio.



::: {layout-ncol=2}
![{dplyr}: data wrangling](https://raw.githubusercontent.com/rstudio/cheatsheets/main/pngs/data-transformation.png)

![{tidyr}: data preparation](https://raw.githubusercontent.com/rstudio/cheatsheets/main/pngs/tidyr.png)

![{ggplot}: data visualization](https://raw.githubusercontent.com/rstudio/cheatsheets/main/pngs/data-visualization.png)

![{gtsummary}: publication ready tables](https://raw.githubusercontent.com/rstudio/cheatsheets/main/pngs/gtsummary.png)

:::


So much great stuff! 
A bit too much to digest in one go,
but definitely worthwhile if you plan to dig deeper in data analysis.



