library(tidyverse)
library(knitr)

knitr::include_graphics("img/desk_vs_inf-crop.png")

knitr::include_graphics("img/Estimate.gif")

## flowchart LR
##   A(prior belief) --> B(new data) --> C(posterior belief)
## 
## 

knitr::include_graphics("img/frequentists_vs_bayesians_2x.png")

ggplot(NULL, aes(c(-3,3))) +
  geom_area(stat = "function", fun = dnorm, fill = "grey80", xlim = c(-3, 1.960)) +
  geom_area(stat = "function", fun = dnorm, fill = "firebrick", xlim = c(1.96, 3)) + 
  theme_void() +
  labs(title = "The p-value as the (size of the) red area under the curve") +
  geom_vline(xintercept = 1.96, linetype = "dashed") +
   annotate("label", x = 1.96, y = 0.1, label = "observed effect")
