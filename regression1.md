# Modelling and regression

![](img/stern.png){width="5%"}


## R packages needed for this chapter


::: {.cell hash='regression1_cache/pdf/unnamed-chunk-1_5e60e969ded20b36c4862df64fc60c76'}

```{.r .cell-code}
library(easystats)
library(tidyverse)
library(rstanarm)  # optional!
```
:::



## What's modelling?

[Read this great introduction by modelling by Russel Poldrack](https://statsthinking21.github.io/statsthinking21-core-site/fitting-models.html#what-is-a-model). Actually, the whole book is nice @poldrack_statistical_2022.


An epitome of modelling is this, let's call it the fundamental modelling equation, a bit grandiose but at the point, see @eq-modelling.





The data can be separated in the model's prediction and the rest (the "error"), i.e., what's unaccounted for by the model.

$$
\text{data} = \text{model} + \text{error}
$${#eq-modelling}




A more visual account of our basic modelling equation is depicted in @fig-model1.






## Regression as the umbrella tool for modelling

![One regression](img/one-regression-to-rule-them-all.jpeg){width="50%"}
[Source: Image Flip](www.imgflip.com)

Alternatively, venture into the forest of statistical tests as [outlined e.g. here, at Uni Muenster](https://web.archive.org/web/20091029162244/http://www.wiwi.uni-muenster.de/ioeb/en/organisation/pfaff/stat_overview_table.html).

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

### The linear model

Here's the canonical form of the linear model.

Consider a model with $k$ predictors:

$$y = \beta_0 + \beta_1 x_1 + \ldots + \beta_k x_k + \epsilon$$

### Algebraic derivation

For the mathematical inclined, check out [this derivation](https://data-se.netlify.app/2022/05/23/ableitung-der-koeffizienten-der-einfachen-regression/) of the simple case regression model. Note that the article is written in German, but your browser can effortlessly translate into English. Here's a [similar English article from StackExchange](https://math.stackexchange.com/questions/716826/derivation-of-simple-linear-regression-parameters).



## In all its glory


::: {.cell hash='regression1_cache/pdf/in-all-its-glory_8f6281094a8b505d0e9d3faf9e78363d'}
::: {.cell-output-display}
![](regression1_files/figure-pdf/in-all-its-glory-1.pdf)
:::
:::


## First model: one metric predictor

First, let's load some data:


::: {.cell hash='regression1_cache/pdf/unnamed-chunk-2_1ff9809622f526d6b2c9105964db1844'}

```{.r .cell-code}
data(mtcars)
glimpse(mtcars)
```

::: {.cell-output .cell-output-stdout}
```
Rows: 32
Columns: 11
$ mpg  <dbl> 21.0, 21.0, 22.8, 21.4, 18.7, 18.1, 14.3, 24.4, 22.8, 19.2, 17.8,~
$ cyl  <dbl> 6, 6, 4, 6, 8, 6, 8, 4, 4, 6, 6, 8, 8, 8, 8, 8, 8, 4, 4, 4, 4, 8,~
$ disp <dbl> 160.0, 160.0, 108.0, 258.0, 360.0, 225.0, 360.0, 146.7, 140.8, 16~
$ hp   <dbl> 110, 110, 93, 110, 175, 105, 245, 62, 95, 123, 123, 180, 180, 180~
$ drat <dbl> 3.90, 3.90, 3.85, 3.08, 3.15, 2.76, 3.21, 3.69, 3.92, 3.92, 3.92,~
$ wt   <dbl> 2.620, 2.875, 2.320, 3.215, 3.440, 3.460, 3.570, 3.190, 3.150, 3.~
$ qsec <dbl> 16.46, 17.02, 18.61, 19.44, 17.02, 20.22, 15.84, 20.00, 22.90, 18~
$ vs   <dbl> 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,~
$ am   <dbl> 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0,~
$ gear <dbl> 4, 4, 4, 3, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 4, 4, 4, 3, 3,~
$ carb <dbl> 4, 4, 1, 1, 2, 1, 4, 2, 2, 4, 4, 3, 3, 3, 4, 4, 4, 1, 2, 1, 1, 2,~
```
:::
:::


### Frequentist

Define and fit the model:


::: {.cell hash='regression1_cache/pdf/lm1-freq_400060b0bde95999c938e5c2d0aac4c2'}

```{.r .cell-code}
lm1_freq <- lm(mpg ~ hp, data = mtcars)
```
:::


Get the parameter values:


::: {.cell hash='regression1_cache/pdf/lm1-frewq-params_49a783dbed9937e09e2acca72b7c90e5'}

```{.r .cell-code}
parameters(lm1_freq)
```

::: {.cell-output .cell-output-stdout}
```
Parameter   | Coefficient |   SE |         95% CI | t(30) |      p
------------------------------------------------------------------
(Intercept) |       30.10 | 1.63 | [26.76, 33.44] | 18.42 | < .001
hp          |       -0.07 | 0.01 | [-0.09, -0.05] | -6.74 | < .001
```
:::
:::


Plot the model parameters:


::: {.cell hash='regression1_cache/pdf/plot-lm1-freq_60db7bbb6052fd1561fe00f5168654c8'}

```{.r .cell-code}
plot(parameters(lm1_freq))
```

::: {.cell-output-display}
![](regression1_files/figure-pdf/plot-lm1-freq-1.pdf){fig-pos='H'}
:::
:::


### Bayesian


::: {.cell hash='regression1_cache/pdf/lm1-bayes_0b94f56f1ee1fb5568fbc496ce752c49'}

```{.r .cell-code}
lm1_bayes <- stan_glm(mpg ~ hp, data = mtcars)
```

::: {.cell-output .cell-output-stdout}
```

SAMPLING FOR MODEL 'continuous' NOW (CHAIN 1).
Chain 1: 
Chain 1: Gradient evaluation took 0.000671 seconds
Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 6.71 seconds.
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
Chain 1:  Elapsed Time: 0.031964 seconds (Warm-up)
Chain 1:                0.030428 seconds (Sampling)
Chain 1:                0.062392 seconds (Total)
Chain 1: 

SAMPLING FOR MODEL 'continuous' NOW (CHAIN 2).
Chain 2: 
Chain 2: Gradient evaluation took 1.4e-05 seconds
Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 0.14 seconds.
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
Chain 2:  Elapsed Time: 0.032053 seconds (Warm-up)
Chain 2:                0.030316 seconds (Sampling)
Chain 2:                0.062369 seconds (Total)
Chain 2: 

SAMPLING FOR MODEL 'continuous' NOW (CHAIN 3).
Chain 3: 
Chain 3: Gradient evaluation took 1.7e-05 seconds
Chain 3: 1000 transitions using 10 leapfrog steps per transition would take 0.17 seconds.
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
Chain 3:  Elapsed Time: 0.030275 seconds (Warm-up)
Chain 3:                0.03358 seconds (Sampling)
Chain 3:                0.063855 seconds (Total)
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
Chain 4:  Elapsed Time: 0.031825 seconds (Warm-up)
Chain 4:                0.029619 seconds (Sampling)
Chain 4:                0.061444 seconds (Total)
Chain 4: 
```
:::
:::


Actually, we want to suppress some overly verbose output of the sampling, so add the argument `refresh = 0`:


::: {.cell hash='regression1_cache/pdf/lm-bayes-refresh0_58824704a69bbfb19aa719d33ad09f12'}

```{.r .cell-code}
lm1_bayes <- stan_glm(mpg ~ hp, data = mtcars, refresh = 0)
```
:::


Get the parameter values:


::: {.cell hash='regression1_cache/pdf/unnamed-chunk-3_09a06926ea9c34fed3894433c7a8fb62'}

```{.r .cell-code}
parameters(lm1_bayes)
```

::: {.cell-output .cell-output-stdout}
```
Parameter   | Median |         95% CI |   pd | % in ROPE |  Rhat |     ESS |                   Prior
----------------------------------------------------------------------------------------------------
(Intercept) |  30.12 | [26.85, 33.34] | 100% |        0% | 1.001 | 3257.00 | Normal (20.09 +- 15.07)
hp          |  -0.07 | [-0.09, -0.05] | 100% |      100% | 1.000 | 3387.00 |   Normal (0.00 +- 0.22)
```
:::
:::


Plot the model parameters:


::: {.cell hash='regression1_cache/pdf/unnamed-chunk-4_830779a438edd5a8582665175173f952'}

```{.r .cell-code}
plot(parameters(lm1_bayes))
```

::: {.cell-output-display}
![](regression1_files/figure-pdf/unnamed-chunk-4-1.pdf){fig-pos='H'}
:::
:::


### Model performance


::: {.cell hash='regression1_cache/pdf/unnamed-chunk-5_c165df2f3e83d39ca2298a5b9e1b71bc'}

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

::: {.cell hash='regression1_cache/pdf/r2-bayes_b11c56cfb6fb061189ea436161792846'}

```{.r .cell-code}
r2(lm1_bayes)
```

::: {.cell-output .cell-output-stdout}
```
# Bayesian R2 with Compatibility Interval

  Conditional R2: 0.585 (95% CI [0.376, 0.744])
```
:::
:::


### Model check

Here's a bunch of typical model checks in the Frequentist sense.


::: {.cell fit-width='10' fig.asp='1' hash='regression1_cache/pdf/checkmodel-lm1-freq_566a6ef0c05f51b912456400db3ce6fa'}

```{.r .cell-code}
check_model(lm1_freq)
```

::: {.cell-output-display}
![](regression1_files/figure-pdf/checkmodel-lm1-freq-1.pdf){fig-pos='H' width=100%}
:::
:::



And here are some Bayesian flavored model checks.


::: {.cell fit-width='10' fig.asp='1' hash='regression1_cache/pdf/checkmodel-lm1-bayes_4ddb2be711e0946e7f7983667c4991e9'}

```{.r .cell-code}
check_model(lm1_bayes)
```

::: {.cell-output-display}
![](regression1_files/figure-pdf/checkmodel-lm1-bayes-1.pdf){fig-pos='H' width=100%}
:::
:::


### Get some predictions


::: {.cell hash='regression1_cache/pdf/lm1-preds_bcbb26836ddffd05115a20b424d2a3c4'}

```{.r .cell-code}
lm1_pred <- estimate_relation(lm1_freq)
lm1_pred
```

::: {.cell-output .cell-output-stdout}
```
Model-based Expectation

hp     | Predicted |   SE |         95% CI
------------------------------------------
52.00  |     26.55 | 1.18 | [24.15, 28.95]
83.44  |     24.41 | 0.94 | [22.49, 26.32]
114.89 |     22.26 | 0.75 | [20.72, 23.80]
146.33 |     20.11 | 0.68 | [18.72, 21.51]
177.78 |     17.97 | 0.75 | [16.43, 19.50]
209.22 |     15.82 | 0.93 | [13.92, 17.73]
240.67 |     13.68 | 1.17 | [11.29, 16.07]
272.11 |     11.53 | 1.44 | [ 8.59, 14.48]
303.56 |      9.39 | 1.73 | [ 5.86, 12.92]
335.00 |      7.24 | 2.02 | [ 3.11, 11.38]

Variable predicted: mpg
Predictors modulated: hp
```
:::
:::


More details on the above function can be found on the [respective page at the easystats site](https://easystats.github.io/modelbased/reference/estimate_expectation.html#functions-for-estimating-predicted-values-and-uncertainty).

### Plot the model


::: {.cell hash='regression1_cache/pdf/plot-lm1-pred_ef4205a9bed0dcc13d89a5ed1f01df43'}

```{.r .cell-code}
plot(lm1_pred)
```

::: {.cell-output-display}
![](regression1_files/figure-pdf/plot-lm1-pred-1.pdf){fig-pos='H'}
:::
:::


## More of this

More technical details for gauging model performance and model quality, can be found on the site of [the R package "performance](https://easystats.github.io/performance/) at the easystats site.

## Bayes-members only

Bayes statistics provide a distribution as the result of the analysis, the posterior distribution, which provides us with quite some luxury.

As the posterior distribution manifests itself by a number of samples, we can easily filter and manipulate this sample distribution in order to ask some interesing questions.

See:


::: {.cell hash='regression1_cache/pdf/unnamed-chunk-6_e747b9b6b90d56740872dec713407f73'}

```{.r .cell-code}
lm1_bayes %>% 
  as_tibble() %>% 
  head()
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 6 x 3
  `(Intercept)`      hp sigma
          <dbl>   <dbl> <dbl>
1          27.5 -0.0545  3.86
2          32.4 -0.0812  3.60
3          29.7 -0.0567  3.86
4          29.5 -0.0608  4.47
5          30.7 -0.0664  3.78
6          29.4 -0.0682  3.89
```
:::
:::


### Asking for probabilites

*What's the probability that the effect of hp is negative?*


::: {.cell hash='regression1_cache/pdf/unnamed-chunk-7_39fb7eed142b8d0a1cd27b9de5a54d76'}

```{.r .cell-code}
lm1_bayes %>% 
  as_tibble() %>% 
  count(hp < 0)
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 1 x 2
  `hp < 0`     n
  <lgl>    <int>
1 TRUE      4000
```
:::
:::


Feel free to ask similar questions!

### Asking for quantiles

*With a given probability of, say 90%, how large is the effect of hp?*


::: {.cell hash='regression1_cache/pdf/unnamed-chunk-8_e93f2dce642329d2d148d5d524343294'}

```{.r .cell-code}
lm1_bayes %>% 
  as_tibble() %>% 
  summarise(q_90 = quantile(hp, .9))
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 1 x 1
     q_90
    <dbl>
1 -0.0550
```
:::
:::


*What's the smallest 95% percent interval for the effect of hp?*


::: {.cell hash='regression1_cache/pdf/unnamed-chunk-9_4f0a3c3fb23768e0ecb95339d4982e33'}

```{.r .cell-code}
hdi(lm1_bayes)
```

::: {.cell-output .cell-output-stdout}
```
Highest Density Interval

Parameter   |        95% HDI
----------------------------
(Intercept) | [26.95, 33.43]
hp          | [-0.09, -0.05]
```
:::
:::


In case you prefer 89% intervals (I do!):


::: {.cell hash='regression1_cache/pdf/unnamed-chunk-10_33414b4739b3dbc963ad62454a83a968'}

```{.r .cell-code}
hdi(lm1_bayes, ci = .89)
```

::: {.cell-output .cell-output-stdout}
```
Highest Density Interval

Parameter   |        89% HDI
----------------------------
(Intercept) | [27.41, 32.68]
hp          | [-0.09, -0.05]
```
:::
:::


## Multiple metric predictors

Assume we have a theory that dictates that fuel economy is a (causal) function of horse power and engine displacement.


::: {.cell hash='regression1_cache/pdf/lm2-freq_bcebd7060c16f74a514159263c189625'}

```{.r .cell-code}
lm2_freq <- lm(mpg ~ hp + disp, data = mtcars)
parameters(lm2_freq)
```

::: {.cell-output .cell-output-stdout}
```
Parameter   | Coefficient |       SE |         95% CI | t(29) |      p
----------------------------------------------------------------------
(Intercept) |       30.74 |     1.33 | [28.01, 33.46] | 23.08 | < .001
hp          |       -0.02 |     0.01 | [-0.05,  0.00] | -1.86 | 0.074 
disp        |       -0.03 | 7.40e-03 | [-0.05, -0.02] | -4.10 | < .001
```
:::
:::


Similarly for Bayes inference:


::: {.cell hash='regression1_cache/pdf/lm2-bayes_76cc30acc8fe855c9c9880fe99e94c21'}

```{.r .cell-code}
lm2_bayes <- stan_glm(mpg ~ hp + disp, data = mtcars)
```
:::


Results


::: {.cell hash='regression1_cache/pdf/lm2-results_6a8ca37265c9de039f47e1a6b92daf17'}

```{.r .cell-code}
parameters(lm2_bayes)
```

::: {.cell-output .cell-output-stdout}
```
Parameter   | Median |         95% CI |     pd | % in ROPE |  Rhat |     ESS |                   Prior
------------------------------------------------------------------------------------------------------
(Intercept) |  30.78 | [27.94, 33.57] |   100% |        0% | 0.999 | 5095.00 | Normal (20.09 +- 15.07)
hp          |  -0.02 | [-0.05,  0.00] | 97.28% |      100% | 1.001 | 2226.00 |   Normal (0.00 +- 0.22)
disp        |  -0.03 | [-0.04, -0.01] |   100% |      100% | 1.001 | 2150.00 |   Normal (0.00 +- 0.12)
```
:::

```{.r .cell-code}
plot(parameters(lm2_bayes))
```

::: {.cell-output-display}
![](regression1_files/figure-pdf/lm2-results-1.pdf){fig-pos='H'}
:::

```{.r .cell-code}
r2(lm2_bayes)
```

::: {.cell-output .cell-output-stdout}
```
# Bayesian R2 with Compatibility Interval

  Conditional R2: 0.731 (95% CI [0.579, 0.847])
```
:::
:::


Depending on the value of `disp` the prediction of `mpg` from `hp` will vary:


::: {.cell hash='regression1_cache/pdf/lm2-pred_7014d48bf51dca654d2d49e276025f94'}

```{.r .cell-code}
lm2_pred <- estimate_relation(lm2_freq)
plot(lm2_pred)
```

::: {.cell-output-display}
![](regression1_files/figure-pdf/lm2-pred-1.pdf){fig-pos='H'}
:::
:::


## One nominal predictor


::: {.cell hash='regression1_cache/pdf/lm3a_9d7c21c9f5e959b269cd646dc43792ee'}

```{.r .cell-code}
mtcars2 <-
  mtcars %>% 
  mutate(am_f = factor(am))

lm3a <- lm(mpg ~ am_f, data = mtcars2)
parameters(lm3a)
```

::: {.cell-output .cell-output-stdout}
```
Parameter   | Coefficient |   SE |         95% CI | t(30) |      p
------------------------------------------------------------------
(Intercept) |       17.15 | 1.12 | [14.85, 19.44] | 15.25 | < .001
am f [1]    |        7.24 | 1.76 | [ 3.64, 10.85] |  4.11 | < .001
```
:::
:::

::: {.cell hash='regression1_cache/pdf/unnamed-chunk-11_b1e10fa1fd41d7ecfc3ec2c703a8f490'}

```{.r .cell-code}
lm3a_means <- estimate_means(lm3a, at = "am_f")
lm3a_means 
```

::: {.cell-output .cell-output-stdout}
```
Estimated Marginal Means

am_f |  Mean |   SE |         95% CI
------------------------------------
0    | 17.15 | 1.12 | [14.85, 19.44]
1    | 24.39 | 1.36 | [21.62, 27.17]

Marginal means estimated at am_f
```
:::
:::

::: {.cell hash='regression1_cache/pdf/unnamed-chunk-12_f1f83990f1772365d7a3bc7fab78200c'}

```{.r .cell-code}
plot(lm3a_means)
```

::: {.cell-output-display}
![](regression1_files/figure-pdf/unnamed-chunk-12-1.pdf){fig-pos='H'}
:::
:::


Note that we should have converted `am` to a factor variable before fitting the model. Otherwise, the plot won't work.

Here's a more hand-crafted version of the last plot, see Fig. @fig-lm3a-means.


::: {.cell hash='regression1_cache/pdf/fig-lm3a-means_8b7707668c2a21311d181f7eaab3148f'}

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
![](regression1_files/figure-pdf/fig-lm3a-means-1.pdf){#fig-lm3a-means fig-pos='H'}
:::
:::


## One metric and one nominal predictor


::: {.cell hash='regression1_cache/pdf/lm4_84431baf255114e7c0a89760d68345e1'}

```{.r .cell-code}
mtcars2 <-
  mtcars %>% 
  mutate(cyl = factor(cyl))

lm4 <- lm(mpg ~ hp + cyl, data = mtcars2)
parameters(lm4)
```

::: {.cell-output .cell-output-stdout}
```
Parameter   | Coefficient |   SE |          95% CI | t(28) |      p
-------------------------------------------------------------------
(Intercept) |       28.65 | 1.59 | [ 25.40, 31.90] | 18.04 | < .001
hp          |       -0.02 | 0.02 | [ -0.06,  0.01] | -1.56 | 0.130 
cyl [6]     |       -5.97 | 1.64 | [ -9.33, -2.61] | -3.64 | 0.001 
cyl [8]     |       -8.52 | 2.33 | [-13.29, -3.76] | -3.66 | 0.001 
```
:::
:::

::: {.cell hash='regression1_cache/pdf/lm4-pred_2b0bbfdb304523c7c26cb0cf5a879ab0'}

```{.r .cell-code}
lm4_pred <- estimate_relation(lm4)
plot(lm4_pred)
```

::: {.cell-output-display}
![](regression1_files/figure-pdf/lm4-pred-1.pdf){fig-pos='H'}
:::
:::


## What about correlation?

Correlation is really a close cousin to regression. In fact, regression with standardized variables amounts to correlation.

Let's get the correlation matrix of the variables in involved in `lm4`.


::: {.cell hash='regression1_cache/pdf/lm4-corr_88a71893d7a45bcd54f1552f71ef076a'}

```{.r .cell-code}
lm4_corr <- 
  mtcars %>% 
  select(mpg, hp, disp) %>% 
  correlation()

lm4_corr
```

::: {.cell-output .cell-output-stdout}
```
# Correlation Matrix (pearson-method)

Parameter1 | Parameter2 |     r |         95% CI | t(30) |         p
--------------------------------------------------------------------
mpg        |         hp | -0.78 | [-0.89, -0.59] | -6.74 | < .001***
mpg        |       disp | -0.85 | [-0.92, -0.71] | -8.75 | < .001***
hp         |       disp |  0.79 | [ 0.61,  0.89] |  7.08 | < .001***

p-value adjustment method: Holm (1979)
Observations: 32
```
:::
:::

::: {.cell hash='regression1_cache/pdf/unnamed-chunk-13_a80e793699ae47265146e2e1fc262fc1'}

```{.r .cell-code}
plot(summary(lm4_corr))
```

::: {.cell-output-display}
![](regression1_files/figure-pdf/unnamed-chunk-13-1.pdf){fig-pos='H'}
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
