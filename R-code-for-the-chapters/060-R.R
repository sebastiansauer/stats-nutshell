library(easystats)
library(tidyverse)

e <- 2.7178
y <- e^10
y

## flowchart LR
## X --> Y1
## 
## X1 --> Y2
## X2 --> Y2

# plane <- function(x, y) {
#   x+y
# }
# 
# x <- y <- seq(-1, 1, length = 30)
# z <- outer(x,y, plane)
# 
# persp(x,y,z, theta = 30)
# persp(x,y,z, theta = 90)
# persp(x,y,z, theta = 150)


knitr::include_graphics(c("img/3d1.png", "img/3d2.png", "img/3d3.png"))

lm3d <- lm(mpg ~ hp + disp, data = mtcars)

x <- seq(min(mtcars$hp), max(mtcars$hp), length.out = 25)
y <- seq(min(mtcars$disp), max(mtcars$disp), length.out = 25)
z <- outer(x, y, function(x,y) {predict(lm3d, data.frame(hp = x, disp = y))})
persp(x,y,z , theta = c(45, 135, 225, 315), col = "lightblue")

lm1 <- lm(mpg ~ hp, data = mtcars)
plot(estimate_relation(lm1))

lm2 <- lm(mpg ~ disp, data = mtcars)
plot(estimate_relation(lm2))

lm3d_interact <- lm(mpg ~ hp + disp + hp:disp, data = mtcars)

x <- seq(min(mtcars$hp), max(mtcars$hp), length.out = 25)
y <- seq(min(mtcars$disp), max(mtcars$disp), length.out = 25)
z <- outer(x, y, function(x,y) {predict(lm3d_interact, data.frame(hp = x, disp = y))})
persp(x,y,z , theta = c(45, 135, 225, 315), col = "lightblue")

mtcars2 <-
  mtcars %>% 
  mutate(am_f = factor(am))

lm_interact_simple <- lm(mpg ~ disp + am_f + disp:am_f, data = mtcars2)

plot(estimate_relation(lm_interact_simple))

display(parameters(lm_interact_simple))

mtcars3 <- 
mtcars2 %>% 
  mutate(disp_c = disp - mean(disp))

lm_interact_simple2 <- lm(mpg ~ disp_c + am_f + disp_c:am_f, data = mtcars3)
parameters(lm_interact_simple2)

mtcars4 <-
  mtcars %>% 
  standardize(select = c("disp", "hp", "cyl"))

head(mtcars4$disp)
head(mtcars$disp)

sd(mtcars4$disp)
sd(mtcars$disp)

mean(mtcars4$disp)
mean(mtcars$disp)

m <- lm(mpg ~ disp + hp + cyl, data = mtcars4)
parameters(m)

knitr::include_graphics("img/543px-Linear_least_squares_geometric_interpretation.png")
