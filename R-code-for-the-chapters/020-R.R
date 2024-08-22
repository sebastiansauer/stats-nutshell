## flowchart LR
##   A{Goals} --> B(describe)
##   A --> C(predict)
##   A --> D(explain)
##   B --> E(distribution)
##   B --> F(assocation)
##   B --> G(extrapolation)
##   C --> H(point estimate)
##   C --> I(interval)
##   D --> J(causal inference)
##   D --> K(population)
##   D --> L(latent construct)
## 

data(mtcars)

d <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/palmerpenguins/penguins.csv")

head(d)  # see the first few rows, the "head" of the table
