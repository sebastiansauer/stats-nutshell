# Basics


## R Basics

Check out [chapter 1 in ModernDive](https://moderndive.com/1-getting-started.html) for an accessible introduction to getting started with R and RStudio.

Please also note that R and RStudio should be installed upfront (see also in ModernDive).



## Initial quiz


To get an idea whether you have digested some R basics, consider the following quiz.


:::{#exr-q1}

## Define a variable

Define in R the variable `age` and assign the value `42`.^[`age <- 42`, spaces are optional but useful]
:::


:::{#exr-q2}

## Define a variable as a string

Define in R the variable `name` and assign the value `me`.^[`age <- "me"`]
:::


:::{#exr-q3}

## Define a variable by another variable

Define in R the variable `name` and assign the *variable* `age`.^[`age <- age`]
:::




:::{#exr-q3a}

## Call a function

Ask R what today's  `date()` is, that is, call a function.^[`date()`]
:::



:::{#exr-q4}

## Define a vector

Define in R a vector `x` with the values 1,2,3 .^[`x <- c(1, 2, 3)`]
:::



:::{#exr-q5}

## Vector wise computation

Square each value in the vector `x`.^[`x^2`]
:::




:::{#exr-q6}

## Vector wise computation 2

Square each value in the vector `x` and sum up the values.^[`sum(x^2)`]
:::


:::{#exr-q7}

## Vector wise computation 3

Square each value in the vector `x`, sum up the values, and divide by 3.^[`mean(x^2)`]
:::

:::{#exr-q8}

## Compute the variance

Compute the variance of `x` using basic arithmetic.^[`sum(x^2)`][^sol8]
:::


[^sol8]:



    ::: {.cell}
    
    ```{.r .cell-code}
    x <- c(1, 2, 3)
    
    sum((x - mean(x))^2) / (length(x)-1)
    ```
    
    ::: {.cell-output .cell-output-stdout}
    ```
    [1] 1
    ```
    :::
    
    ```{.r .cell-code}
    # compare: 
    var(x)  
    ```
    
    ::: {.cell-output .cell-output-stdout}
    ```
    [1] 1
    ```
    :::
    :::





:::{#exr-q9}

## Work with NA

Define the vector `y` with the values 1,2,NA. Compute the mean. Explain the results.^[`y <- c(1, 2, NA); mean(y)` NA (not available, ie., missing) is contagious in R: If there's a missing element, R will assume that something has gone wrong and will raise a red flag, i.e, give you a NA back.]
:::





## Data import


Check out [chapter 4 in ModernDive](https://moderndive.com/4-tidy.html) on how to import data into RStudio and for some basic concepts about "tidy data".

Spoiler: There's a button in RStudio in the "Environment" Pane saying "Import Dataset". 
Just click it, and things should work out.




## Blitz start with data {#sec-blitz-data}


To blitz start with data, type the following in R:


::: {.cell}

```{.r .cell-code}
data(mtcars)
```
:::


And the data set `mtcars` will be available.

To get help for the data set, type `help(mtcars)`




A bit more advanced, but it's a nice data set, try the Palmer Penguins data set:


::: {.cell}

```{.r .cell-code}
d <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/palmerpenguins/penguins.csv")

head(d)  # see the first few rows, the "head" of the table
```

::: {.cell-output-display}
<div class="kable-table">

|  X|species |island    | bill_length_mm| bill_depth_mm| flipper_length_mm| body_mass_g|sex    | year|
|--:|:-------|:---------|--------------:|-------------:|-----------------:|-----------:|:------|----:|
|  1|Adelie  |Torgersen |           39.1|          18.7|               181|        3750|male   | 2007|
|  2|Adelie  |Torgersen |           39.5|          17.4|               186|        3800|female | 2007|
|  3|Adelie  |Torgersen |           40.3|          18.0|               195|        3250|female | 2007|
|  4|Adelie  |Torgersen |             NA|            NA|                NA|          NA|NA     | 2007|
|  5|Adelie  |Torgersen |           36.7|          19.3|               193|        3450|female | 2007|
|  6|Adelie  |Torgersen |           39.3|          20.6|               190|        3650|male   | 2007|

</div>
:::
:::



Here's some [documentation (code book)](https://vincentarelbundock.github.io/Rdatasets/doc/palmerpenguins/penguins.html) for this data set.




## More data set 


Check out [this curated list](https://data-se.netlify.app/2022/02/23/data-sets-for-for-teaching/) of data sets useful for learning and practicing your data skills.




## Literature


@ismay_statistical_2020 is a helpful start into the first steps in R.


