# Modelling and regression

![](img/stern.png){width="5%"}


## R packages needed for this chapter


::: {.cell hash='regression1_cache/html/unnamed-chunk-1_30f763fa3519da195ff3ddf012ab3657'}

```{.r .cell-code}
library(easystats)
library(tidyverse)
library(rstanarm)  # optional!
```
:::

::: {.cell hash='regression1_cache/html/unnamed-chunk-2_7aefcddcffcfa448f4f9373f9a2e0755'}

:::


## What's modelling?

[Read this great introduction by modelling by Russel Poldrack](https://statsthinking21.github.io/statsthinking21-core-site/fitting-models.html#what-is-a-model). Actually, the whole book is nice @poldrack_statistical_2022.


An epitome of modelling is this, let's call it the fundamental modelling equation, a bit grandiose but at the point, see @eq-modelling.





The data can be separated in the model's prediction and the rest (the "error"), i.e., what's unaccounted for by the model.

$$
\text{data} = \text{model} + \text{error}
$${#eq-modelling}




A more visual account of our basic modelling equation is depicted in @fig-model1.



:::{.cell}

:::{.cell-output-display}

:::{#fig-model1}

<p >

<pre class="mermaid mermaid-js" data-tooltip-selector="#mermaid-tooltip-1">flowchart LR
  X --&gt; Y
  error --&gt; Y
</pre>

<div id="mermaid-tooltip-1" class="mermaidTooltip"></div>
</p>


A more visual account of our basic modelling equation
:::
:::
:::




## Regression as the umbrella tool for modelling

![One regression](img/one-regression-to-rule-them-all.jpeg){width="50%"}

[Source: Image Flip](www.imgflip.com)

Alternatively, venture into the forest of statistical tests as [outlined e.g. here, at Uni Muenster](https://web.archive.org/web/20091029162244/http://www.wiwi.uni-muenster.de/ioeb/en/organisation/pfaff/stat_overview_table.html). Proceed at your own peril.

You may want to ponder on this image of a decision tree of which test to choose, see Figure @fig-choose-test.

![Choose your test carefully](img/choose-test.png){#fig-choose-test}

### Common statistical tests are linear models

As Jonas Kristoffer Lindeløv tells us, we can formulate most statistical tests as a linear model, ie., a regression.

![Common statistical tests as linear models](img/linear_tests_cheat_sheet.png){width=75%}

### How to find the regression line

In the simplest case, regression analyses can be interpreted geometrically as a line in a 2D coordinate system, see Figure @fig-regr1.

![Least Square Regression](img/800px-Coefficient_of_Determination.svg.png){#fig-regr1}

[Source: Orzetoo, CC-SA, Wikimedia](https://commons.wikimedia.org/wiki/File:Coefficient_of_Determination.svg)

Put simple, we are looking for the line which is in the "middle of the points". More precisely, we place the line such that the squared distances from the line to the points is minimal, see Figre @fig-regr1.

Consider Figure @fig-regr2, from [this source](https://bookdown.org/roback/bookdown-BeyondMLR/ch-MLRreview.html#assumptions-for-linear-least-squares-regression) by @roback_beyond_2021. It visualizes not only the notorious regression line, but also sheds light on regression assumptions, particularly on the error distribution.

![Regression and some of its assumptions](img/OLSassumptions-1.png){#fig-regr2}

Among the assumptions of the linear model are:

- linearity of the function
- variance of $y$ remains constant across range of $x$
- normality of residuals



### The linear model

Here's the canonical form of the linear model.

Consider a model with $k$ predictors:

$$y = \beta_0 + \beta_1 x_1 + \ldots + \beta_k x_k + \epsilon$$

### Algebraic derivation

For the mathematical inclined, check out [this derivation](https://data-se.netlify.app/2022/05/23/ableitung-der-koeffizienten-der-einfachen-regression/) of the simple case regression model. Note that the article is written in German, but your browser can effortlessly translate into English. Here's a [similar English article from StackExchange](https://math.stackexchange.com/questions/716826/derivation-of-simple-linear-regression-parameters).



## In all its glory


::: {.cell hash='regression1_cache/html/in-all-its-glory_f6ff172af2741a0f34d3bc30aaa8d4d2'}
::: {.cell-output-display}
![](regression1_files/figure-html/in-all-its-glory-1.png){width=672}
:::
:::



Let's depict the residuals, s. @fig-lm2.


::: {.cell hash='regression1_cache/html/fig-lm2_550059835de9bd967d93a16007b55f8a'}
::: {.cell-output-display}
![Residuals as deviations from the predicted value](regression1_files/figure-html/fig-lm2-1.png){#fig-lm2 width=672}
:::
:::



## First model: one metric predictor

First, let's load some data:


::: {.cell hash='regression1_cache/html/unnamed-chunk-4_2790791213d8e0cecab1a2487dc1cab5'}

```{.r .cell-code}
data(mtcars)
glimpse(mtcars)
```

::: {.cell-output .cell-output-stdout}
```
Rows: 32
Columns: 11
$ mpg  <dbl> 21.0, 21.0, 22.8, 21.4, 18.7, 18.1, 14.3, 24.4, 22.8, 19.2, 17.8,…
$ cyl  <dbl> 6, 6, 4, 6, 8, 6, 8, 4, 4, 6, 6, 8, 8, 8, 8, 8, 8, 4, 4, 4, 4, 8,…
$ disp <dbl> 160.0, 160.0, 108.0, 258.0, 360.0, 225.0, 360.0, 146.7, 140.8, 16…
$ hp   <dbl> 110, 110, 93, 110, 175, 105, 245, 62, 95, 123, 123, 180, 180, 180…
$ drat <dbl> 3.90, 3.90, 3.85, 3.08, 3.15, 2.76, 3.21, 3.69, 3.92, 3.92, 3.92,…
$ wt   <dbl> 2.620, 2.875, 2.320, 3.215, 3.440, 3.460, 3.570, 3.190, 3.150, 3.…
$ qsec <dbl> 16.46, 17.02, 18.61, 19.44, 17.02, 20.22, 15.84, 20.00, 22.90, 18…
$ vs   <dbl> 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,…
$ am   <dbl> 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0,…
$ gear <dbl> 4, 4, 4, 3, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 4, 4, 4, 3, 3,…
$ carb <dbl> 4, 4, 1, 1, 2, 1, 4, 2, 2, 4, 4, 3, 3, 3, 4, 4, 4, 1, 2, 1, 1, 2,…
```
:::
:::


### Frequentist

Define and fit the model:


::: {.cell hash='regression1_cache/html/lm1-freq_8fbd56fc8e0f333639dcc6113e5461fb'}

```{.r .cell-code}
lm1_freq <- lm(mpg ~ hp, data = mtcars)
```
:::


Get the parameter values:


::: {.cell hash='regression1_cache/html/lm1-frewq-params_afaa8ae5a8071254de977d13ea1b8ca8'}

```{.r .cell-code}
parameters(lm1_freq)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter   | Coefficient|        SE|   CI|     CI_low|    CI_high|         t| df_error|     p|
|:-----------|-----------:|---------:|----:|----------:|----------:|---------:|--------:|-----:|
|(Intercept) |  30.0988605| 1.6339210| 0.95| 26.7619488| 33.4357723| 18.421246|       30| 0e+00|
|hp          |  -0.0682283| 0.0101193| 0.95| -0.0888947| -0.0475619| -6.742388|       30| 2e-07|

</div>
:::
:::


Plot the model parameters:


::: {.cell hash='regression1_cache/html/plot-lm1-freq_51bc615ba27af3f0e8ff3896f87b8c45'}

```{.r .cell-code}
plot(parameters(lm1_freq))
```

::: {.cell-output-display}
![](regression1_files/figure-html/plot-lm1-freq-1.png){width=672}
:::
:::


### Bayesian


::: {.cell hash='regression1_cache/html/lm1-bayes_8f8326b95b1f425052582a8f44268745'}

```{.r .cell-code}
lm1_bayes <- stan_glm(mpg ~ hp, data = mtcars)
```

::: {.cell-output .cell-output-stdout}
```

SAMPLING FOR MODEL 'continuous' NOW (CHAIN 1).
Chain 1: 
Chain 1: Gradient evaluation took 7.4e-05 seconds
Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 0.74 seconds.
Chain 1: Adjust your expectations accordingly!
Chain 1: 
Chain 1: 
Chain 1: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 1: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 1: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 1: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 1: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 1: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 1: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 1: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 1: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 1: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 1: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 1: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 1: 
Chain 1:  Elapsed Time: 0.034904 seconds (Warm-up)
Chain 1:                0.035594 seconds (Sampling)
Chain 1:                0.070498 seconds (Total)
Chain 1: 

SAMPLING FOR MODEL 'continuous' NOW (CHAIN 2).
Chain 2: 
Chain 2: Gradient evaluation took 1.7e-05 seconds
Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 0.17 seconds.
Chain 2: Adjust your expectations accordingly!
Chain 2: 
Chain 2: 
Chain 2: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 2: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 2: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 2: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 2: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 2: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 2: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 2: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 2: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 2: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 2: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 2: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 2: 
Chain 2:  Elapsed Time: 0.036974 seconds (Warm-up)
Chain 2:                0.030925 seconds (Sampling)
Chain 2:                0.067899 seconds (Total)
Chain 2: 

SAMPLING FOR MODEL 'continuous' NOW (CHAIN 3).
Chain 3: 
Chain 3: Gradient evaluation took 1.8e-05 seconds
Chain 3: 1000 transitions using 10 leapfrog steps per transition would take 0.18 seconds.
Chain 3: Adjust your expectations accordingly!
Chain 3: 
Chain 3: 
Chain 3: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 3: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 3: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 3: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 3: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 3: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 3: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 3: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 3: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 3: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 3: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 3: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 3: 
Chain 3:  Elapsed Time: 0.033843 seconds (Warm-up)
Chain 3:                0.031322 seconds (Sampling)
Chain 3:                0.065165 seconds (Total)
Chain 3: 

SAMPLING FOR MODEL 'continuous' NOW (CHAIN 4).
Chain 4: 
Chain 4: Gradient evaluation took 1.6e-05 seconds
Chain 4: 1000 transitions using 10 leapfrog steps per transition would take 0.16 seconds.
Chain 4: Adjust your expectations accordingly!
Chain 4: 
Chain 4: 
Chain 4: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 4: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 4: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 4: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 4: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 4: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 4: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 4: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 4: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 4: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 4: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 4: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 4: 
Chain 4:  Elapsed Time: 0.033838 seconds (Warm-up)
Chain 4:                0.030412 seconds (Sampling)
Chain 4:                0.06425 seconds (Total)
Chain 4: 
```
:::
:::


Actually, we want to suppress some overly verbose output of the sampling, so add the argument `refresh = 0`:


::: {.cell hash='regression1_cache/html/lm-bayes-refresh0_f68ef60c7c5ad05c86fc6bfd2a7e8d41'}

```{.r .cell-code}
lm1_bayes <- stan_glm(mpg ~ hp, data = mtcars, refresh = 0)
```
:::


Get the parameter values:


::: {.cell hash='regression1_cache/html/unnamed-chunk-5_a84686611038a6a8f1f1711773890a05'}

```{.r .cell-code}
parameters(lm1_bayes)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter   |     Median|   CI|    CI_low|    CI_high| pd|      Rhat|      ESS|Prior_Distribution | Prior_Location| Prior_Scale|
|:-----------|----------:|----:|---------:|----------:|--:|---------:|--------:|:------------------|--------------:|-----------:|
|(Intercept) | 30.0458334| 0.95| 26.744874| 33.3780301|  1| 0.9999552| 3816.002|normal             |       20.09062|  15.0673701|
|hp          | -0.0683247| 0.95| -0.088284| -0.0476861|  1| 1.0002417| 3851.764|normal             |        0.00000|   0.2197599|

</div>
:::
:::


Plot the model parameters:


::: {.cell hash='regression1_cache/html/unnamed-chunk-6_d3d8d5ceaa6d7dc932d3757376720f7c'}

```{.r .cell-code}
plot(parameters(lm1_bayes))
```

::: {.cell-output-display}
![](regression1_files/figure-html/unnamed-chunk-6-1.png){width=672}
:::
:::


### Model performance


::: {.cell hash='regression1_cache/html/unnamed-chunk-7_8aa0625b1256729307ec353ff2422738'}

```{.r .cell-code}
r2(lm1_freq)
```

::: {.cell-output .cell-output-stdout}
```
# R2 for Linear Regression
       R2: 0.602
  adj. R2: 0.589
```
:::
:::

::: {.cell hash='regression1_cache/html/r2-bayes_9c99a448f25aa57b8eed74d85d66adfb'}

```{.r .cell-code}
r2(lm1_bayes)
```

::: {.cell-output .cell-output-stdout}
```
# Bayesian R2 with Compatibility Interval

  Conditional R2: 0.584 (95% CI [0.378, 0.749])
```
:::
:::


### Model check

Here's a bunch of typical model checks in the Frequentist sense.


::: {.cell fit-width='10' fig.asp='1' hash='regression1_cache/html/checkmodel-lm1-freq_93daa3551d1393e753e19879372dfff8'}

```{.r .cell-code}
check_model(lm1_freq)
```

::: {.cell-output-display}
![](regression1_files/figure-html/checkmodel-lm1-freq-1.png){width=100%}
:::
:::



And here are some Bayesian flavored model checks.


::: {.cell fit-width='10' fig.asp='1' hash='regression1_cache/html/checkmodel-lm1-bayes_c1ed59d01c06f907a47ffe587842fcf5'}

```{.r .cell-code}
check_model(lm1_bayes)
```

::: {.cell-output-display}
![](regression1_files/figure-html/checkmodel-lm1-bayes-1.png){width=100%}
:::
:::


### Get some predictions


::: {.cell hash='regression1_cache/html/lm1-preds_2ab30940a3cb9202fc7df5852e38e5b4'}

```{.r .cell-code}
lm1_pred <- estimate_relation(lm1_freq)
lm1_pred
```

::: {.cell-output-display}
<div class="kable-table">

|        hp| Predicted|        SE|    CI_low|  CI_high|
|---------:|---------:|---------:|---------:|--------:|
|  52.00000| 26.550990| 1.1766139| 24.148024| 28.95396|
|  83.44444| 24.405590| 0.9358933| 22.494241| 26.31694|
| 114.88889| 22.260189| 0.7548971| 20.718484| 23.80190|
| 146.33333| 20.114789| 0.6828911| 18.720139| 21.50944|
| 177.77778| 17.969389| 0.7518697| 16.433866| 19.50491|
| 209.22222| 15.823989| 0.9310065| 13.922620| 17.72536|
| 240.66667| 13.678588| 1.1707841| 11.287528| 16.06965|
| 272.11111| 11.533188| 1.4412478|  8.589767| 14.47661|
| 303.55556|  9.387788| 1.7280486|  5.858642| 12.91693|
| 335.00000|  7.242387| 2.0242544|  3.108308| 11.37647|

</div>
:::
:::


More details on the above function can be found on the [respective page at the easystats site](https://easystats.github.io/modelbased/reference/estimate_expectation.html#functions-for-estimating-predicted-values-and-uncertainty).

### Plot the model


::: {.cell hash='regression1_cache/html/plot-lm1-pred_516f5bebbc7613de1049f0e0496a9569'}

```{.r .cell-code}
plot(lm1_pred)
```

::: {.cell-output-display}
![](regression1_files/figure-html/plot-lm1-pred-1.png){width=672}
:::
:::


## More of this

More technical details for gauging model performance and model quality, can be found on the site of [the R package "performance](https://easystats.github.io/performance/) at the easystats site.




## Lab

Run a simple regression on your own research data. Present the results. Did you encounter any glitches?







## Bayes-members only

Bayes statistics provide a distribution as the result of the analysis, the posterior distribution, which provides us with quite some luxury.

As the posterior distribution manifests itself by a number of samples, we can easily filter and manipulate this sample distribution in order to ask some interesing questions.

See


::: {.cell hash='regression1_cache/html/unnamed-chunk-8_2c5e5556a490cef27bfa77bddc716f34'}

```{.r .cell-code}
lm1_bayes_tibble <- as_tibble(lm1_bayes)  # cast as a tibble (table)

head(lm1_bayes_tibble)  # show the first few rows
```

::: {.cell-output-display}
<div class="kable-table">

| (Intercept)|         hp|    sigma|
|-----------:|----------:|--------:|
|    31.31765| -0.0801401| 4.248651|
|    33.89991| -0.0824994| 4.802076|
|    30.73198| -0.0680882| 3.826181|
|    30.09580| -0.0701588| 4.905716|
|    30.35285| -0.0656387| 3.295531|
|    31.50666| -0.0706685| 4.168542|

</div>
:::
:::


### Asking for probabilites

*What's the probability that the effect of hp is negative?*


::: {.cell hash='regression1_cache/html/unnamed-chunk-9_58601c10b83842914656716ca43115e0'}

```{.r .cell-code}
lm1_bayes_tibble %>% 
  count(hp < 0)
```

::: {.cell-output-display}
<div class="kable-table">

|hp < 0 |    n|
|:------|----:|
|TRUE   | 4000|

</div>
:::
:::


Feel free to ask similar questions!

### Asking for quantiles

*With a given probability of, say 90%, how large is the effect of hp?*


::: {.cell hash='regression1_cache/html/unnamed-chunk-10_5b2b330e1792c0e9f0c996fd14031f3e'}

```{.r .cell-code}
quantile(lm1_bayes_tibble$hp, .9)
```

::: {.cell-output .cell-output-stdout}
```
        90% 
-0.05474905 
```
:::
:::


*What's the smallest 95% percent interval for the effect of hp?*


::: {.cell hash='regression1_cache/html/unnamed-chunk-11_34018e8741fd1ced4d78811a4a689e0d'}

```{.r .cell-code}
hdi(lm1_bayes)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter   |   CI|     CI_low|    CI_high|Effects |Component   |
|:-----------|----:|----------:|----------:|:-------|:-----------|
|(Intercept) | 0.95| 26.8722745| 33.4599590|fixed   |conditional |
|hp          | 0.95| -0.0884446| -0.0478163|fixed   |conditional |

</div>
:::
:::


In case you prefer 89% intervals (I do!):


::: {.cell hash='regression1_cache/html/unnamed-chunk-12_9e631f5aba491a74d911cfee1396fd18'}

```{.r .cell-code}
hdi(lm1_bayes, ci = .89)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter   |   CI|     CI_low|    CI_high|Effects |Component   |
|:-----------|----:|----------:|----------:|:-------|:-----------|
|(Intercept) | 0.89| 27.3645122| 32.6733738|fixed   |conditional |
|hp          | 0.89| -0.0850095| -0.0523753|fixed   |conditional |

</div>
:::
:::



### Model specification

In Bayes statistics, it is customary to specify the model in something like the following way:


$$\begin{aligned}

y_i &\sim N(\mu_i,\sigma)\\
\mu_i &= \beta_0 + \beta_1 x_i\\
\beta_0, \beta_1 &\sim N(0, 1) \\
\sigma &\sim E(1)
\end{aligned}$$

In this specification, $N$ refers to the normal distribution, and $E$ to the exponential distribution.
Furthermore, this model assumes that the $X$ and $Y$ are given in standard units.




### Prediction interval

A prediction interval answers the following question


>   How large is the uncertainty in $y$ associated with a given obersation? What interval of values should I expect for a randomly chosen observation?


For example, what's the uncertainty attached to the fuel economy of a car with 100 hp?



::: {.cell hash='regression1_cache/html/unnamed-chunk-13_2a16a52b3eaca3ace64ce12783c86e7f'}

```{.r .cell-code}
estimate_prediction(model = lm1_bayes, 
                    data = tibble(hp = 100) )
```

::: {.cell-output-display}
<div class="kable-table">

|  hp| Predicted|       SE|   CI_low|  CI_high|
|---:|---------:|--------:|--------:|--------:|
| 100|  23.24689| 4.143285| 14.99219| 31.56238|

</div>
:::
:::





### ... And more

We could even ask intriguing questions such as 


>   Given the model, and given two random observations, one from the experimental group and one from the control group, what is the probability that observation 1 has a higher value in $Y$ than observation 2 has?

Note that we are not only asking for "typical" observations as predicted by the model but we are also taking into account the uncertainty of the prediction for each group. 
Hence, *this* kind of questions is likely to yield more realistic (and less clear-cut) answers than just asking for the typical value.
In other words, such analyses draw on the posterior predictive distribution.









## Multiple metric predictors

Assume we have a theory that dictates that fuel economy is a (causal) function of horse power and engine displacement.


::: {.cell hash='regression1_cache/html/lm2-freq_f3bb56953b93b38fbf6cd25fbb14bb33'}

```{.r .cell-code}
lm2_freq <- lm(mpg ~ hp + disp, data = mtcars)
parameters(lm2_freq)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter   | Coefficient|        SE|   CI|     CI_low|    CI_high|         t| df_error|         p|
|:-----------|-----------:|---------:|----:|----------:|----------:|---------:|--------:|---------:|
|(Intercept) |  30.7359042| 1.3315661| 0.95| 28.0125457| 33.4592628| 23.082522|       29| 0.0000000|
|hp          |  -0.0248401| 0.0133855| 0.95| -0.0522165|  0.0025363| -1.855746|       29| 0.0736791|
|disp        |  -0.0303463| 0.0074049| 0.95| -0.0454909| -0.0152016| -4.098159|       29| 0.0003063|

</div>
:::
:::


Similarly for Bayes inference:


::: {.cell hash='regression1_cache/html/lm2-bayes_9b49d9262f9fdb667eb14f799e2eb0e3'}

```{.r .cell-code}
lm2_bayes <- stan_glm(mpg ~ hp + disp, data = mtcars)
```
:::


Results


::: {.cell hash='regression1_cache/html/lm2-results_b3013a3370e43218fdd00dd6a97ebae0'}

```{.r .cell-code}
parameters(lm2_bayes)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter   |     Median|   CI|     CI_low|    CI_high|      pd| ROPE_Percentage|     Rhat|      ESS|Prior_Distribution | Prior_Location| Prior_Scale|
|:-----------|----------:|----:|----------:|----------:|-------:|---------------:|--------:|--------:|:------------------|--------------:|-----------:|
|(Intercept) | 30.7631742| 0.95| 27.9592857| 33.4523213| 1.00000|               0| 1.000854| 4605.880|normal             |       20.09062|  15.0673701|
|hp          | -0.0252340| 0.95| -0.0538511|  0.0032994| 0.95825|               1| 1.001172| 2080.083|normal             |        0.00000|   0.2197599|
|disp        | -0.0304116| 0.95| -0.0456015| -0.0144810| 0.99900|               1| 1.000431| 1957.573|normal             |        0.00000|   0.1215712|

</div>
:::

```{.r .cell-code}
plot(parameters(lm2_bayes))
```

::: {.cell-output-display}
![](regression1_files/figure-html/lm2-results-1.png){width=672}
:::

```{.r .cell-code}
r2(lm2_bayes)
```

::: {.cell-output .cell-output-stdout}
```
# Bayesian R2 with Compatibility Interval

  Conditional R2: 0.731 (95% CI [0.580, 0.844])
```
:::
:::


Depending on the value of `disp` the prediction of `mpg` from `hp` will vary:


::: {.cell hash='regression1_cache/html/lm2-pred_493dc9d10a4d4930a9f0d09e4cb85a40'}

```{.r .cell-code}
lm2_pred <- estimate_relation(lm2_freq)
plot(lm2_pred)
```

::: {.cell-output-display}
![](regression1_files/figure-html/lm2-pred-1.png){width=672}
:::
:::


## One nominal predictor


::: {.cell hash='regression1_cache/html/lm3a_535b185d06fc6d1b2a30a814ca37d81a'}

```{.r .cell-code}
lm3a <- lm(mpg ~ am, data = mtcars)
parameters(lm3a)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter   | Coefficient|       SE|   CI|   CI_low|  CI_high|         t| df_error|        p|
|:-----------|-----------:|--------:|----:|--------:|--------:|---------:|--------:|--------:|
|(Intercept) |   17.147368| 1.124602| 0.95| 14.85062| 19.44411| 15.247492|       30| 0.000000|
|am          |    7.244939| 1.764422| 0.95|  3.64151| 10.84837|  4.106127|       30| 0.000285|

</div>
:::
:::

::: {.cell hash='regression1_cache/html/unnamed-chunk-14_c49dac5bae175a71ed12b3c2ea772ca4'}

```{.r .cell-code}
lm3a_means <- estimate_means(lm3a, at = "am = c(0, 1)")
lm3a_means 
```

::: {.cell-output-display}
<div class="kable-table">

| am|     Mean|       SE|   CI_low|  CI_high|
|--:|--------:|--------:|--------:|--------:|
|  0| 17.14737| 1.124602| 14.85062| 19.44411|
|  1| 24.39231| 1.359578| 21.61568| 27.16894|

</div>
:::
:::

If we were not to specify the values of `am` which we would like to get predictions for, the default of the function would select 10 values, spread across the range of `am`. For numeric variables, this is usually fine. However, for nominal variables - and `am` is in fact a nominally scaled variable - we insist that we want predictions for the levels of the variable only, that is for `0` and `1`.


However, unfortunately, the plot *needs* a nominal variable if we are to compare groups. 
In our case, `am` is considered a numeric variables, since it consists of numbers only. 
The plot does not work, malheureusement:




::: {.cell hash='regression1_cache/html/unnamed-chunk-15_3f26968118ac254f421277f6d43651a4'}

```{.r .cell-code}
plot(lm3a_means)
```

::: {.cell-output-display}
![](regression1_files/figure-html/unnamed-chunk-15-1.png){width=672}
:::
:::




We need to transform `am` to a factor variable. That's something like a string. 
If we hand over a `factor()` to the plotting function, everything will run smoothly. 
Computationwise, no big differences:



::: {.cell hash='regression1_cache/html/lm3a-factor_ec6e4c42488953d3cfbcf0df9b982713'}

```{.r .cell-code}
mtcars2 <-
  mtcars %>% 
  mutate(am_f = factor(am))

lm3a <- lm(mpg ~ am_f, data = mtcars2)
parameters(lm3a)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter   | Coefficient|       SE|   CI|   CI_low|  CI_high|         t| df_error|        p|
|:-----------|-----------:|--------:|----:|--------:|--------:|---------:|--------:|--------:|
|(Intercept) |   17.147368| 1.124602| 0.95| 14.85062| 19.44411| 15.247492|       30| 0.000000|
|am_f1       |    7.244939| 1.764422| 0.95|  3.64151| 10.84837|  4.106127|       30| 0.000285|

</div>
:::
:::

::: {.cell hash='regression1_cache/html/unnamed-chunk-16_cd8a9d0d0c1d4e3108c7c9e309b3b898'}

```{.r .cell-code}
lm3a_means <- estimate_means(lm3a)
plot(lm3a_means)
```

::: {.cell-output-display}
![](regression1_files/figure-html/unnamed-chunk-16-1.png){width=672}
:::
:::



Note that we should have converted `am` to a factor variable before fitting the model. Otherwise, the plot won't work.

Here's a more hand-crafted version of the last plot, see Fig. @fig-lm3a-means.


::: {.cell hash='regression1_cache/html/fig-lm3a-means_e45955c35ba6eb96437967555bfd10f8'}

```{.r .cell-code}
ggplot(mtcars2) +
  aes(x = am_f, y = mpg) +
  geom_violin() +
  geom_jitter(width = .1, alpha = .5) +
  geom_pointrange(data = lm3a_means,
                  color = "orange",
                  aes(ymin = CI_low, ymax = CI_high, y = Mean)) +
  geom_line(data = lm3a_means, aes(y = Mean, group = 1))
```

::: {.cell-output-display}
![Means per level of am](regression1_files/figure-html/fig-lm3a-means-1.png){#fig-lm3a-means width=672}
:::
:::


## One metric and one nominal predictor


::: {.cell hash='regression1_cache/html/lm4_dbe3a16013f682f75ade95a933811eb6'}

```{.r .cell-code}
mtcars2 <-
  mtcars %>% 
  mutate(cyl = factor(cyl))

lm4 <- lm(mpg ~ hp + cyl, data = mtcars2)
parameters(lm4)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter   | Coefficient|        SE|   CI|      CI_low|    CI_high|         t| df_error|         p|
|:-----------|-----------:|---------:|----:|-----------:|----------:|---------:|--------:|---------:|
|(Intercept) |  28.6501182| 1.5877870| 0.95|  25.3976840| 31.9025524| 18.044056|       28| 0.0000000|
|hp          |  -0.0240388| 0.0154079| 0.95|  -0.0556005|  0.0075228| -1.560163|       28| 0.1299540|
|cyl6        |  -5.9676551| 1.6392776| 0.95|  -9.3255631| -2.6097471| -3.640418|       28| 0.0010921|
|cyl8        |  -8.5208508| 2.3260749| 0.95| -13.2855993| -3.7561022| -3.663188|       28| 0.0010286|

</div>
:::
:::

::: {.cell hash='regression1_cache/html/lm4-pred_82b59b63241acbd1a5f1973d5dc49f74'}

```{.r .cell-code}
lm4_pred <- estimate_relation(lm4)
plot(lm4_pred)
```

::: {.cell-output-display}
![](regression1_files/figure-html/lm4-pred-1.png){width=672}
:::
:::



## Watch out for Simpson

Beware! Model estimates can swing wildly if you add (or remove) some predictor from your model. [See this post](https://ecologyforthemasses.com/2022/06/08/who-is-simpson-and-what-does-his-paradox-mean-for-ecologists/) for an demonstration.




## What about correlation?

Correlation is really a close cousin to regression. In fact, regression with standardized variables amounts to correlation.

Let's get the correlation matrix of the variables in involved in `lm4`.


::: {.cell hash='regression1_cache/html/lm4-corr_8e97ccf6a3950214c412baad22942a71'}

```{.r .cell-code}
lm4_corr <- 
  mtcars %>% 
  select(mpg, hp, disp) %>% 
  correlation()

lm4_corr
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter1 |Parameter2 |          r|   CI|     CI_low|    CI_high|         t| df_error|     p|Method              | n_Obs|
|:----------|:----------|----------:|----:|----------:|----------:|---------:|--------:|-----:|:-------------------|-----:|
|mpg        |hp         | -0.7761684| 0.95| -0.8852686| -0.5860994| -6.742388|       30| 2e-07|Pearson correlation |    32|
|mpg        |disp       | -0.8475514| 0.95| -0.9233594| -0.7081376| -8.747151|       30| 0e+00|Pearson correlation |    32|
|hp         |disp       |  0.7909486| 0.95|  0.6106794|  0.8932775|  7.080122|       30| 1e-07|Pearson correlation |    32|

</div>
:::
:::

::: {.cell hash='regression1_cache/html/unnamed-chunk-17_57cdfa2a1ed976620bbd0e9bb9fa23ba'}

```{.r .cell-code}
plot(summary(lm4_corr))
```

::: {.cell-output-display}
![](regression1_files/figure-html/unnamed-chunk-17-1.png){width=672}
:::
:::


## Exercises

1.  [mtcars simple 1](https://datenwerk.netlify.app/posts/mtcars-simple1/mtcars-simple1/)
2.  [mtcars simple 2](https://datenwerk.netlify.app/posts/mtcars-simple2/mtcars-simple2/)
3.  [mtcars simple 3](https://datenwerk.netlify.app/posts/mtcars-simple3/mtcars-simple3/)

## Lab

Get your own data, and build a simple model reflecting your research hypothesis. If you are lacking data (or hypothesis) get something close to it.

## Literature

An accessible treatment of regression is provided by @ismay_statistical_2020.

@roback_beyond_2021 provide a more than introductory account of regression while being accessible. A recent but already classic book (if this is possible) is the book by @gelman_regression_2021.
You may also benefit from @poldrack_statistical_2022 (open access).

## Debrief

[Science!](https://media.giphy.com/media/141amBdjqs9Vvy/giphy.gif)
