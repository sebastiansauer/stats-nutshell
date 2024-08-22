library(easystats)
library(tidyverse)
library(rstanarm)  # optional!

theme_set(theme_minimal())

## flowchart LR
##   X --> Y
##   error --> Y

ggplot(mtcars) +
  aes(x = hp, y = mpg) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal()

d <- mtcars
lm1 <- lm(mpg ~ hp, data = d)

d <-
  d %>% 
  mutate(pred = predict(lm1),
         resid = residuals(lm1))


ggplot(d, 
       aes(x = hp, y = mpg)) +
  geom_smooth(method = "lm", se = FALSE, color = "dodgerblue") +
  geom_segment(aes(xend = hp, yend = pred), alpha = .5) +
  geom_point() +
  geom_hline(yintercept = mean(d$mpg), 
             color = "grey60", linetype = "dashed") +
  geom_vline(xintercept = mean(d$hp), 
             color = "grey60", linetype = "dashed") + 
  annotate("point", x = mean(d$hp), y = mean(d$mpg),
           size = 5, color = "red", alpha = .5)

data(mtcars)
glimpse(mtcars)

lm1_freq <- lm(mpg ~ hp, data = mtcars)

parameters(lm1_freq)

plot(parameters(lm1_freq))

lm1_bayes <- stan_glm(mpg ~ hp, data = mtcars)

lm1_bayes <- stan_glm(mpg ~ hp, data = mtcars, refresh = 0)

parameters(lm1_bayes)

plot(parameters(lm1_bayes))

r2(lm1_freq)

r2(lm1_bayes)

check_model(lm1_freq)

check_model(lm1_bayes)

lm1_pred <- estimate_relation(lm1_freq)
lm1_pred

plot(lm1_pred)

lm1_bayes_tibble <- as_tibble(lm1_bayes)  # cast as a tibble (table)

head(lm1_bayes_tibble)  # show the first few rows

lm1_bayes_tibble %>% 
  count(hp < 0)

quantile(lm1_bayes_tibble$hp, .9)

hdi(lm1_bayes)

hdi(lm1_bayes, ci = .89)

estimate_prediction(model = lm1_bayes, 
                    data = tibble(hp = 100) )

lm2_freq <- lm(mpg ~ hp + disp, data = mtcars)
parameters(lm2_freq)

lm2_bayes <- stan_glm(mpg ~ hp + disp, data = mtcars)

parameters(lm2_bayes)
plot(parameters(lm2_bayes))
r2(lm2_bayes)

lm2_pred <- estimate_relation(lm2_freq)
plot(lm2_pred)

lm3a <- lm(mpg ~ am, data = mtcars)
parameters(lm3a)

lm3a_means <- estimate_means(lm3a, at = "am = c(0, 1)")
lm3a_means 

plot(lm3a_means)

mtcars2 <-
  mtcars %>% 
  mutate(am_f = factor(am))

lm3a <- lm(mpg ~ am_f, data = mtcars2)
parameters(lm3a)

lm3a_means <- estimate_means(lm3a)
plot(lm3a_means)

ggplot(mtcars2) +
  aes(x = am_f, y = mpg) +
  geom_violin() +
  geom_jitter(width = .1, alpha = .5) +
  geom_pointrange(data = lm3a_means,
                  color = "orange",
                  aes(ymin = CI_low, ymax = CI_high, y = Mean)) +
  geom_line(data = lm3a_means, aes(y = Mean, group = 1))

mtcars2 <-
  mtcars %>% 
  mutate(cyl = factor(cyl))

lm4 <- lm(mpg ~ hp + cyl, data = mtcars2)
parameters(lm4)

lm4_pred <- estimate_relation(lm4)
plot(lm4_pred)

lm4_corr <- 
  mtcars %>% 
  select(mpg, hp, disp) %>% 
  correlation()

lm4_corr

plot(summary(lm4_corr))
