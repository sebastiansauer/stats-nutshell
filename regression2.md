
# More Regression


![](img/stern.png){width=5%}

## R-packages needed

For this chapter, the following R packages are needed.


::: {.cell}

```{.r .cell-code}
library(tidyverse)
library(easystats)
```
:::





## Multiplicative associations


### The Log-Y model

Consider again the linear model, in a simple form:




$$\hat{y} = \beta_0 + \beta_1 x_1 +  \ldots + b_kx_k +$$
Surprisingly, we can use this *linear* model to describe *multiplicative* assocations:


$\hat{y} = e^{b_0 + b_1x_1 + b_2x_2 + \ldots + b_kx_k}$

(I wrote `b` instead of $\beta$ just to show that both has its meaning, but are separate things.)

Exponentiate both sides to get:

$log (\hat{y}) = b_0 + b_1x_1 + b_2x_2 + \ldots + b_kx_k$

For simplicity, let's drop the subscripts in the following without loss of generality and keep it short:



$y = e^{x}$, with $\approx  2.71...$

Exponentiate both sides to get:

$log(y) = x$


This association is called multiplicative, because if x increases by 1, y increased by a *constant factor*.




:::{.callout-note}
The logarithm is not defined for negative (input) values. And $log(0) = -\infty$.
:::


A side-effect of modelling `log_y` instead of `y` is that the distribution shape of the outcome variable changes. 
This can be useful in times.



### Exercise

- [Effect of education on income](https://datenwerk.netlify.app/post/log-y-regr1/log-y-regr1/)
- [Effect of log-y transformation on the distribution, an example](https://datenwerk.netlify.app/post/log-y-regr2/log-y-regr2/)


:::{.callout-note}
The exercises are written in German Language. Don't fret. Browsers are able to translate websites instantaneously. Alternatively, go to sites such as [Google Translate](https://translate.google.de/?sl=de&tl=en&op=websites) and enter the URL of the website to be translated. Also check out the webstor of your favorite browser to get an extention [such as this one for Google Chrome](https://chrome.google.com/webstore/detail/google-translate).
:::


### Visualizing Log Transformation

Check out [this post](https://data-se.netlify.app/2022/01/14/visualizing-a-log-y-regression-model/) for an example of a log-y regression visualized.

[This post](https://data-se.netlify.app/2021/06/17/ein-beispiel-zum-nutzen-einer-log-transformation/) puts some more weight to the argument that a log-y transformation is useful (if you want to model multiplicative relations).

### Further reading

Check out [this great essay by Kenneth Benoit](https://kenbenoit.net/assets/courses/ME104/logmodels2.pdf) on different log-variants in regression. 
Also @gelman_regression_2021, chapter 12 (and others), is useful.





## Interaction




### Multiple predictors, no interaction


Regression analyses can be used with more than one predictor, see Figure @fig-multregr.




:::{.cell fig-width="6.5"}

:::{.cell-output-display}

:::{#fig-multregr}

<p >

<pre class="mermaid" data-tooltip-selector="#mermaid-tooltip-1">
flowchart LR
X --&gt; Y1

X1 --&gt; Y2
X2 --&gt; Y2
</pre>

<div id="mermaid-tooltip-1" class="mermaidTooltip"></div>
</p>


One predictor (X) vs. two predictors (X1, X2)
:::
:::
:::





A different perspective is given by Figure @fig-3dregr, where a 3D account of a regression is given. 3D means to input variables, and (which is always the case) one output variable.

:::{.callout-note}
Note that the slope in linear in both axis (X1 and X2).
:::




![Multiple Regression. Image source: Cfbaf, Public Domain](https://upload.wikimedia.org/wikipedia/commons/a/ae/2d_multiple_linear_regression.gif?20161014061355){#fig-3dregr}



:::{.callout-important}
If the slope for one predictor is the same for all values of the other predictor, then we say that no interaction is taking place.
:::


Here's a visualization of a 3D regression plane (not line) *without interaction*: constant slope in one axis, see Figure @fig-3dregr2.



::: {.cell}
::: {.cell-output-display}
![](regression2_files/figure-html/fig-3dregr2-1.png){#fig-3dregr2-1 width=33%}
:::

::: {.cell-output-display}
![](regression2_files/figure-html/fig-3dregr2-2.png){#fig-3dregr2-2 width=33%}
:::

::: {.cell-output-display}
![](regression2_files/figure-html/fig-3dregr2-3.png){#fig-3dregr2-3 width=33%}
:::
:::



Note that the slope in each predictor axis equals 1, boringly. 
Hence the according 2D plots are boring, too, see Figure @3d-2dregr.


For the sake of an example,
consider this linear model:


$mpg \sim hp + disp$

Or, in more regression like terms:


$y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \epsilon$, where x1 is `hp` and `x2` is `disp` in the `mtcars` dataset.

In R terms:


::: {.cell}

```{.r .cell-code}
lm3d <- lm(mpg ~ hp + disp, data = mtcars)
```
:::



The 3D plot is shown in Figure @fig-mtcars3d.


::: {.cell}
::: {.cell-output-display}
![mpg ~ hp + disp](regression2_files/figure-html/fig-mtcars3d-1.png){#fig-mtcars3d width=672}
:::
:::



Here are the two corresponding 2d (1 predictor) regression models:



::: {.cell}

```{.r .cell-code}
lm1 <- lm(mpg ~ hp, data = mtcars)
plot(estimate_relation(lm1))
```

::: {.cell-output-display}
![](regression2_files/figure-html/unnamed-chunk-6-1.png){width=672}
:::

```{.r .cell-code}
lm2 <- lm(mpg ~ disp, data = mtcars)
plot(estimate_relation(lm2))
```

::: {.cell-output-display}
![](regression2_files/figure-html/unnamed-chunk-6-2.png){width=672}
:::
:::






Checkout [this post](https://data-se.netlify.app/2022/04/19/3d-regression-plane-with-scatter-plot/) for a visually slightly more appealing 3d regression plane.



### Interaction

For interaction to happen we relax the assumption that the slope of predictor 1 must be constant for all values of predictor 2.

In R, we specify an interaction model like this:


::: {.cell}

```{.r .cell-code}
lm3d_interact <- lm(mpg ~ hp + disp + hp:disp, data = mtcars)
```
:::


The symbol `hp:disp` can be read as "the interaction effect of `hp` and `disp`".

Here's a visual account, see Figure @fig-mtcars3d-interact.




::: {.cell}
::: {.cell-output-display}
![mpg ~ hp + disp](regression2_files/figure-html/fig-mtcars3d-interact-1.png){#fig-mtcars3d-interact width=672}
:::
:::


Compare @fig-mtcars3d-interact and @fig-mtcars3d.

In @fig-mtcars3d-interact you'll see that the lines along the Y axis are not parallel anymore.
Similarly, the lines along the X axis are not parallel anymore.


:::{.callout-important}
If the regression lines (indicating different values of one predictor) are *not* parallel, we say that an interaction effect is taking place.
:::


However, the *difference* or *change* between two adjacent values (lines) is constant. This value is the size the regression effect.


### Interaction made simple


If you find that two sophisticated, consider the following simple case.


First, we mutate `am` to be a factor variable, in order to make things simpler (without loss of generality).


::: {.cell}

```{.r .cell-code}
mtcars2 <-
  mtcars %>% 
  mutate(am_f = factor(am))
```
:::


Now we use this new variable for a simple regression model:


::: {.cell}

```{.r .cell-code}
lm_interact_simple <- lm(mpg ~ disp + am_f + disp:am_f, data = mtcars2)
```
:::



Here's the plot, Figure @fig-interact-simple.


::: {.cell}

```{.r .cell-code}
plot(estimate_relation(lm_interact_simple))
```

::: {.cell-output-display}
![A simple interaction model](regression2_files/figure-html/fig-interact-simple-1.png){#fig-interact-simple width=672}
:::
:::



In this picture, we see that the two regression lines are *not* parallel, 
and hence there is evidence of an interaction effect.


The interaction effect amounts to the *difference* in slops in Figure @fig-interact-simple.

One might be inclined to interpret  Figure @fig-interact-simple as an 3D image, where the one (reddish) line is in the foreground and the blueish line in the background (or vice versa, as you like).
Given a 3D image (and hence 2 predictors), we are where we started further above.

For completeness, here are the parameters of the model.



::: {.cell}
::: {.cell-output-display}
|Parameter       | Coefficient |       SE |             95% CI | t(28) |      p |
|:---------------|:-----------:|:--------:|:------------------:|:-----:|:------:|
|(Intercept)     |       25.16 |     1.93 |     (21.21, 29.10) | 13.07 | < .001 |
|disp            |       -0.03 | 6.22e-03 |     (-0.04, -0.01) | -4.44 | < .001 |
|am f (1)        |        7.71 |     2.50 |      (2.58, 12.84) |  3.08 | 0.005  |
|disp * am f (1) |       -0.03 |     0.01 | (-0.05, -7.99e-03) | -2.75 | 0.010  |
:::
:::



### Centering variables

The effect of of `am_f` must be interpreted when `disp` is zero, which does not make much sense.

Therefore it simplifies the interpretation of regression coefficients to *center* all input variables, by subtrating the mean value ("demeaning" or "centering"):

$$x' = x - \bar{x}$$
In R, this can be achieved e.g,. in this way:


::: {.cell}

```{.r .cell-code}
mtcars3 <- 
mtcars2 %>% 
  mutate(disp_c = disp - mean(disp))
```
:::

::: {.cell}

```{.r .cell-code}
lm_interact_simple2 <- lm(mpg ~ disp_c + am_f + disp_c:am_f, data = mtcars3)
parameters(lm_interact_simple2)
```

::: {.cell-output .cell-output-stdout}
```
Parameter         | Coefficient |       SE |         95% CI | t(28) |      p
----------------------------------------------------------------------------
(Intercept)       |       18.79 |     0.76 | [17.23, 20.36] | 24.63 | < .001
disp c            |       -0.03 | 6.22e-03 | [-0.04, -0.01] | -4.44 | < .001
am f [1]          |        0.45 |     1.39 | [-2.40,  3.30] |  0.32 | 0.748 
disp c * am f [1] |       -0.03 |     0.01 | [-0.05, -0.01] | -2.75 | 0.010 
```
:::

::: {.cell-output .cell-output-stderr}
```

Uncertainty intervals (equal-tailed) and p-values (two-tailed) computed
  using a Wald t-distribution approximation.
```
:::
:::






## Predictor relevance


Given a model, we might want to know which predictor has the strongest association with the outcome?

In order to answer this question, all predictor must have the same scale.
Otherwise the importance of a predictor would increase by 1000, if we multiply each of the observations' values by the same factor.
However, this multiplication should not change the relevance of a predictor.

A simple solution is to standardize all predictors to the same scale (sd=1).



::: {.cell}

```{.r .cell-code}
mtcars4 <-
  mtcars %>% 
  standardize(select = c("disp", "hp", "cyl"))
```
:::



By the way, "standardizing" centers the variable by default to a mean value of zero (by demeaning).

See:


::: {.cell}

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


::: {.cell}

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



::: {.cell}

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


::: {.cell}

```{.r .cell-code}
m <- lm(mpg ~ disp + hp + cyl, data = mtcars4)
parameters(m)
```

::: {.cell-output .cell-output-stdout}
```
Parameter   | Coefficient |   SE |         95% CI | t(28) |      p
------------------------------------------------------------------
(Intercept) |       20.09 | 0.54 | [18.98, 21.20] | 37.20 | < .001
disp        |       -2.33 | 1.29 | [-4.98,  0.31] | -1.81 | 0.081 
hp          |       -1.01 | 1.00 | [-3.06,  1.05] | -1.00 | 0.325 
cyl         |       -2.19 | 1.42 | [-5.11,  0.72] | -1.54 | 0.135 
```
:::

::: {.cell-output .cell-output-stderr}
```

Uncertainty intervals (equal-tailed) and p-values (two-tailed) computed
  using a Wald t-distribution approximation.
```
:::
:::





## Exercises


- [Predictor relevance](https://datenwerk.netlify.app/post/log-y-regr3/log-y-regr3/)
- [Adjusting](https://datenwerk.netlify.app/post/adjustieren1/adjustieren1/)
- [Adjusting 2](https://datenwerk.netlify.app/post/adjustieren2/adjustieren2/)
- [Interpreting Regression coefficients](https://datenwerk.netlify.app/post/interpret-koeff/interpret-koeff/)




## Lab

Get your own data, and build a simple model reflecting your research hypothesis based on the topics covered in this chapter. If you are lacking data (or hypothesis) get something close to it.





## Glimpse on parameter estimation

An elegant yet simple explanation of the math of parameter estimation can be found [at "go data driven"](https://godatadriven.com/blog/the-linear-algebra-behind-linear-regression/).
A similar approach is presented [here](https://shainarace.github.io/LinearAlgebra/leastsquares.html).

Here's the essence of a geometric interpretation of the least square method, see  Figure @fig-leastsq.



![Geometric interpretation of the least square method. Source: Oleg Alexandrov on Wikimedia](https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Linear_least_squares_geometric_interpretation.png/543px-Linear_least_squares_geometric_interpretation.png?20080406011122){#fig-leastsq}




## Further Reading

Mathematical foundations can be found in @deisenroth_mathematics_2020.
[Here's](https://data-se.netlify.app/2022/06/13/free-resources-for-aspiring-data-adepts/) a collection of online resources tapping into statistics and machine learning.


