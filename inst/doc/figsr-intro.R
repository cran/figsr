## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----example------------------------------------------------------------------
library(figsr)

set.seed(42)
df <- data.frame(
  x1 = rnorm(100),
  x2 = rnorm(100),
  y = 3 * (rnorm(100) > 0) + rnorm(100, sd = 0.2)
)

fit <- figs(y ~ x1 + x2, data = df, max_splits = 4)
print(fit)
summary(fit)

