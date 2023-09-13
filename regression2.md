# More linear models

![](img/stern.png){width="5%"}

## R-packages needed


## R packages needed for this chapter


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-1_044342c54650671281c1424559fb2a84'}

```{.r .cell-code}
library(easystats)
library(tidyverse)
```
:::



## Multiplicative associations

### The Log-Y model

Consider again the linear model, in a simple form:

$$\hat{y} = \beta_0 + \beta_1 x_1 +  \ldots + b_kx_k +$$ Surprisingly, we can use this *linear* model to describe *multiplicative* assocations:

$\hat{y} = e^{b_0 + b_1x_1 + b_2x_2 + \ldots + b_kx_k}$

(I wrote `b` instead of $\beta$ just to show that both has its meaning, but are separate things.)

Exponentiate both sides to get:

$log (\hat{y}) = b_0 + b_1x_1 + b_2x_2 + \ldots + b_kx_k$

For simplicity, let's drop the subscripts in the following without loss of generality and keep it short:

$y = e^{x}$, with $e \approx 2.71...$

Exponentiate both sides to get:

$log(y) = x$

This association is called multiplicative, because if x increases by 1, y increased by a *constant factor*.

::: callout-note
The logarithm is not defined for negative (input) values. And $log(0) = -\infty$.
:::

A side-effect of modelling `log_y` instead of `y` is that the distribution shape of the outcome variable changes. This can be useful at times.


Log-Y Regression can usefully be employed for modelling growth, among othrs, see @exm-logy.

::: {#exm-logy}

## Bacteria growth

Some bacteria dish grows with at a fixed proportional rate, that is it doubles its population size in a fixed period of time. This is what is called exponential growth.
For concreteness, say, the bacteriae double each two days, starting with 1 unit of bacteria.

After about three weeks, i.e., 10 doubling periods (20 days), we'll have $y$  units of bacteriae:


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-2_7145e9009d8659ec0af3579192a22e95'}

```{.r .cell-code}
e <- 2.7178
y <- e^10
y
```

::: {.cell-output .cell-output-stdout}
```
[1] 21987.45
```
:::
:::


Quite a bit! More than 20 thousand times more than before.

:::


### Exercise

-   [Effect of education on income](https://datenwerk.netlify.app/posts/log-y-regr1/log-y-regr1/)
-   [Effect of log-y transformation on the distribution, an example](https://datenwerk.netlify.app/posts/log-y-regr2/log-y-regr2/)

::: callout-note
The exercises are written in German Language. Don't fret. Browsers are able to translate websites instantaneously. Alternatively, go to sites such as [Google Translate](https://translate.google.de/?sl=de&tl=en&op=websites) and enter the URL of the website to be translated. Also check out the webstor of your favorite browser to get an extention [such as this one for Google Chrome](https://chrome.google.com/webstore/detail/google-translate).
:::

### Visualizing Log Transformation

Check out [this post](https://data-se.netlify.app/2022/01/14/visualizing-a-log-y-regression-model/) for an example of a log-y regression visualized.

[This post](https://data-se.netlify.app/2021/06/17/ein-beispiel-zum-nutzen-einer-log-transformation/) puts some more weight to the argument that a log-y transformation is useful (if you want to model multiplicative relations).

### Further reading

Check out [this great essay by Kenneth Benoit](https://kenbenoit.net/assets/courses/ME104/logmodels2.pdf) on different log-variants in regression. Also @gelman_regression_2021, chapter 12 (and others), is useful.

## Interaction

### Multiple predictors, no interaction

Regression analyses can be used with more than one predictor, see Figure @fig-multregr.



:::{.cell fig-width="6.5"}

:::{.cell-output-display}

:::{#fig-multregr}

:::{}

<pre class="mermaid mermaid-js" data-label="fig-multregr">
flowchart LR
X --&gt; Y1

X1 --&gt; Y2
X2 --&gt; Y2
</pre>
:::


One predictor (X) vs. two predictors (X1, X2)
:::
:::
:::



 given by Figure @fig-3dregr2, where a 3D account of a regression is given. 3D means to input variables, and (which is always the case) one output variable.

::: callout-note
Note that the slope in linear in both axis (X1 and X2).
:::

A different perspective is shown [here](https://upload.wikimedia.org/wikipedia/commons/a/ae/2d_multiple_linear_regression.gif?20161014061355),  
where a 3D account of a regression is given. 3D means to input variables, and (which is always the case) one output variable.

::: callout-important
If the slope for one predictor is the same for all values of the other predictor, then we say that no interaction is taking place.
:::

Here's a visualization of a 3D regression plane (not line) *without interaction*: constant slope in one axis, see the following figure, @fig-3dregr2. The three cubes show the same data, just turned by different degrees (along the z axis).


::: {.cell layout-align="center" hash='regression2_cache/html/fig-3dregr2_48c90e576e029884ca20c60158cfeb90'}
::: {.cell-output-display}
![3D regression plane (not line) without interaction](img/3d1.png){#fig-3dregr2-1 fig-align='center' width=70%}
:::

::: {.cell-output-display}
![3D regression plane (not line) without interaction](img/3d2.png){#fig-3dregr2-2 fig-align='center' width=70%}
:::

::: {.cell-output-display}
![3D regression plane (not line) without interaction](img/3d3.png){#fig-3dregr2-3 fig-align='center' width=70%}
:::
:::


Note that in the above figure, the slope in each predictor axis equals 1, boringly. Hence the according 2D plots are boring, too.

For the sake of an example, consider this linear model:

$mpg \sim hp + disp$

Or, in more regression like terms:

$y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \epsilon$, where x1 is `hp` and `x2` is `disp` in the `mtcars` dataset.

In R terms:


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-4_3228f84cf5511f82684605e41abb43ff'}

```{.r .cell-code}
lm3d <- lm(mpg ~ hp + disp, data = mtcars)
```
:::


The 3D plot is shown in Figure @fig-mtcars3d.


::: {.cell layout-align="center" hash='regression2_cache/html/fig-mtcars3d_426a3a2399d895452d36d7cc58f7545f'}
::: {.cell-output-display}
![mpg ~ hp + disp](regression2_files/figure-html/fig-mtcars3d-1.png){#fig-mtcars3d fig-align='center' width=70%}
:::
:::


Here are the two corresponding 2d (1 predictor) regression models:


::: {.cell layout-ncol="2" layout-align="center" hash='regression2_cache/html/unnamed-chunk-6_03bdd34274b4e9c62e419645ab3a8f64'}

```{.r .cell-code}
lm1 <- lm(mpg ~ hp, data = mtcars)
plot(estimate_relation(lm1))
```

::: {.cell-output-display}
![](regression2_files/figure-html/unnamed-chunk-6-1.png){fig-align='center' width=70%}
:::

```{.r .cell-code}
lm2 <- lm(mpg ~ disp, data = mtcars)
plot(estimate_relation(lm2))
```

::: {.cell-output-display}
![](regression2_files/figure-html/unnamed-chunk-6-2.png){fig-align='center' width=70%}
:::
:::


Checkout [this post](https://data-se.netlify.app/2022/04/19/3d-regression-plane-with-scatter-plot/) for a visually slightly more appealing 3d regression plane.

### Interaction

For interaction to happen we relax the assumption that the slope of predictor 1 must be constant for all values of predictor 2.

In R, we specify an interaction model like this:


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-7_4f1f142c00fd46d9811d249e5c0b095d'}

```{.r .cell-code}
lm3d_interact <- lm(mpg ~ hp + disp + hp:disp, data = mtcars)
```
:::


The symbol `hp:disp` can be read as "the interaction effect of `hp` and `disp`".

Here's a visual account, see Figure @fig-mtcars3d-interact.


::: {.cell layout-align="center" hash='regression2_cache/html/fig-mtcars3d-interact_5ee2fe3e3416c1eb23b78fe9988595e6'}
::: {.cell-output-display}
![mpg ~ hp + disp](regression2_files/figure-html/fig-mtcars3d-interact-1.png){#fig-mtcars3d-interact fig-align='center' width=70%}
:::
:::


Compare @fig-mtcars3d-interact and @fig-mtcars3d.
The difference is the interaction effect.

In @fig-mtcars3d-interact you'll see that the lines along the Y axis are not parallel anymore. 
Similarly, the lines along the X axis are not parallel anymore.

::: callout-important
If the regression lines (indicating different values of one predictor) are *not* parallel, we say that an interaction effect is taking place.
:::

However, the *difference* or *change* between two adjacent values (lines) is constant. This value is the size the regression effect.

### Interaction made simple

If you find that two sophisticated, consider the following simple case.

First, we mutate `am` to be a factor variable, in order to make things simpler (without loss of generality).


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-9_08e55b928e3b66fd81ecce3f4f0201c5'}

```{.r .cell-code}
mtcars2 <-
  mtcars %>% 
  mutate(am_f = factor(am))
```
:::


Now we use this new variable for a simple regression model:


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-10_e9b4a64ce25735185cfc159fdcce0ec6'}

```{.r .cell-code}
lm_interact_simple <- lm(mpg ~ disp + am_f + disp:am_f, data = mtcars2)
```
:::


Here's the plot, Figure @fig-interact-simple.


::: {.cell layout-align="center" hash='regression2_cache/html/fig-interact-simple_2ef53d007bd582908a5b115af2040afd'}

```{.r .cell-code}
plot(estimate_relation(lm_interact_simple))
```

::: {.cell-output-display}
![A simple interaction model](regression2_files/figure-html/fig-interact-simple-1.png){#fig-interact-simple fig-align='center' width=70%}
:::
:::


In this picture, we see that the two regression lines are *not* parallel, and hence there is evidence of an interaction effect.

The interaction effect amounts to the *difference* in slops in  @fig-interact-simple.

One might be inclined to interpret Figure @fig-interact-simple as an 3D image, where the one (reddish) line is in the foreground and the blueish line in the background (or vice versa, as you like). Given a 3D image (and hence 2 predictors), we are where we started further above.

For completeness, here are the parameters of the model.


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-12_29b38b5a0b9f137445cef04893411787'}
::: {.cell-output-display}
|Parameter       | Coefficient |       SE |             95% CI | t(28) |      p |
|:---------------|:-----------:|:--------:|:------------------:|:-----:|:------:|
|(Intercept)     |       25.16 |     1.93 |     (21.21, 29.10) | 13.07 | < .001 |
|disp            |       -0.03 | 6.22e-03 |     (-0.04, -0.01) | -4.44 | < .001 |
|am f (1)        |        7.71 |     2.50 |      (2.58, 12.84) |  3.08 | 0.005  |
|disp × am f (1) |       -0.03 |     0.01 | (-0.05, -7.99e-03) | -2.75 | 0.010  |
:::
:::


### Centering variables

The effect of of `am_f` must be interpreted when `disp` is zero, which does not make much sense.

Therefore it simplifies the interpretation of regression coefficients to *center* all input variables, by subtrating the mean value ("demeaning" or "centering"):

$$x' = x - \bar{x}$$ In R, this can be achieved e.g,. in this way:


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-13_a8c3d6da7832739f5665fc591a380351'}

```{.r .cell-code}
mtcars3 <- 
mtcars2 %>% 
  mutate(disp_c = disp - mean(disp))
```
:::

::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-14_58b6b6011208093cfe91c4c3843ade52'}

```{.r .cell-code}
lm_interact_simple2 <- lm(mpg ~ disp_c + am_f + disp_c:am_f, data = mtcars3)
parameters(lm_interact_simple2)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter    | Coefficient|        SE|   CI|     CI_low|    CI_high|          t| df_error|         p|
|:------------|-----------:|---------:|----:|----------:|----------:|----------:|--------:|---------:|
|(Intercept)  |  18.7929250| 0.7631321| 0.95| 17.2297199| 20.3561302| 24.6260457|       28| 0.0000000|
|disp_c       |  -0.0275836| 0.0062190| 0.95| -0.0403225| -0.0148447| -4.4354101|       28| 0.0001295|
|am_f1        |   0.4517578| 1.3915089| 0.95| -2.3986189|  3.3021346|  0.3246532|       28| 0.7478567|
|disp_c:am_f1 |  -0.0314548| 0.0114574| 0.95| -0.0549242| -0.0079855| -2.7453781|       28| 0.0104373|

</div>
:::
:::


## Predictor relevance

Given a model, we might want to know which predictor has the strongest association with the outcome?

In order to answer this question, all predictor must have the same scale. Otherwise the importance of a predictor would increase by 1000, if we multiply each of the observations' values by the same factor. However, this multiplication should not change the relevance of a predictor.

A simple solution is to standardize all predictors to the same scale (sd=1).


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-15_6113501163f42270780d37129fcfb377'}

```{.r .cell-code}
mtcars4 <-
  mtcars %>% 
  standardize(select = c("disp", "hp", "cyl"))
```
:::


By the way, "standardizing" centers the variable by default to a mean value of zero (by demeaning).

See:


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-16_b63948e2998d696974b9c1ce4748329b'}

```{.r .cell-code}
head(mtcars4$disp)
```

::: {.cell-output .cell-output-stdout}
```
[1] -0.57061982 -0.57061982 -0.99018209  0.22009369  1.04308123 -0.04616698
```
:::

```{.r .cell-code}
head(mtcars$disp)
```

::: {.cell-output .cell-output-stdout}
```
[1] 160 160 108 258 360 225
```
:::
:::


Here's the SD:


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-17_57836103614b7aa76498c4579707cf27'}

```{.r .cell-code}
sd(mtcars4$disp)
```

::: {.cell-output .cell-output-stdout}
```
[1] 1
```
:::

```{.r .cell-code}
sd(mtcars$disp)
```

::: {.cell-output .cell-output-stdout}
```
[1] 123.9387
```
:::
:::


And here's the mean value:


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-18_62df871933139045b92666f01c4ed0b6'}

```{.r .cell-code}
mean(mtcars4$disp)
```

::: {.cell-output .cell-output-stdout}
```
[1] -9.084937e-17
```
:::

```{.r .cell-code}
mean(mtcars$disp)
```

::: {.cell-output .cell-output-stdout}
```
[1] 230.7219
```
:::
:::


Now we are in a position to decide which predictor is more important:


::: {.cell layout-align="center" hash='regression2_cache/html/unnamed-chunk-19_e5159b5a2ef343a995bf1cb055d0589c'}

```{.r .cell-code}
m <- lm(mpg ~ disp + hp + cyl, data = mtcars4)
parameters(m)
```

::: {.cell-output-display}
<div class="kable-table">

|Parameter   | Coefficient|        SE|   CI|    CI_low|    CI_high|         t| df_error|         p|
|:-----------|-----------:|---------:|----:|---------:|----------:|---------:|--------:|---------:|
|(Intercept) |   20.090625| 0.5400989| 0.95| 18.984282| 21.1969675| 37.198045|       28| 0.0000000|
|disp        |   -2.334768| 1.2894201| 0.95| -4.976025|  0.3064896| -1.810711|       28| 0.0809290|
|hp          |   -1.006457| 1.0045056| 0.95| -3.064094|  1.0511791| -1.001943|       28| 0.3249519|
|cyl         |   -2.192076| 1.4238730| 0.95| -5.108747|  0.7245958| -1.539516|       28| 0.1349044|

</div>
:::
:::


## Exercises

-   [Predictor relevance](https://datenwerk.netlify.app/posts/log-y-regr3/log-y-regr3/)
-   [Adjusting](https://datenwerk.netlify.app/posts/adjustieren1/adjustieren1/)
-   [Adjusting 2](https://datenwerk.netlify.app/posts/adjustieren2/adjustieren2/)
-   [Interpreting Regression coefficients](https://datenwerk.netlify.app/posts/interpret-koeff/interpret-koeff/)

## Lab

Get your own data, and build a simple model reflecting your research hypothesis based on the topics covered in this chapter. If you are lacking data (or hypothesis) get something close to it.

## Glimpse on parameter estimation

An elegant yet simple explanation of the math of parameter estimation can be found [at "go data driven"](https://godatadriven.com/blog/the-linear-algebra-behind-linear-regression/). 
A similar approach is presented [here](https://shainarace.github.io/LinearAlgebra/leastsquares.html).

Consider this geometric interpretation of the least square method in Figure @fig-leastsq.



::: {.cell layout-align="center" hash='regression2_cache/html/fig-leastsq_5a49421ea69ad7c4234985334843dfd1'}
::: {.cell-output-display}
![Geometric interpretation of the least square method. Source: Oleg Alexandrov on Wikimedia](img/543px-Linear_least_squares_geometric_interpretation.png){#fig-leastsq fig-align='center' width=25%}
:::
:::



## Literatur

A recent but already classic book on regression and inference (if this is possible) is the book by @gelman_regression_2021. A great textbook on statistical modelling (with a Bayesian flavor) was written by @mcelreath_statistical_2020; it's suitable for PhD level.

Mathematical foundations can be found in @deisenroth_mathematics_2020. [Here's](https://data-se.netlify.app/2022/06/13/free-resources-for-aspiring-data-adepts/) a collection of online resources tapping into statistics and machine learning.
