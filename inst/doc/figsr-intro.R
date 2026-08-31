## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 4
)

## ----example------------------------------------------------------------------
library(figsr)

set.seed(42)
df <- data.frame(x1 = rnorm(300), x2 = rnorm(300), x3 = rnorm(300))
df$y <- 3 * (df$x1 > 0) + 2 * (df$x2 > 0.5) - 1.5 * (df$x3 < -0.2) +
  rnorm(300, sd = 0.3)

fit <- figs(y ~ x1 + x2 + x3, data = df, max_splits = 6)
fit

## ----rules--------------------------------------------------------------------
summary(fit)

## ----predict------------------------------------------------------------------
preds <- predict(fit, new_data = df)
head(preds)

cor(preds$.pred, df$y)

## ----importance---------------------------------------------------------------
figsr_importance(fit)

## ----plot, fig.alt = "The trees of the fitted FIGS model, drawn side by side."----
plot(fit)

## ----classification-----------------------------------------------------------
set.seed(7)
dfc <- data.frame(x1 = rnorm(300), x2 = rnorm(300))
score <- 1.5 * dfc$x1 + dfc$x2
dfc$y <- factor(ifelse(score + rnorm(300, sd = 0.5) > 0, "yes", "no"))

fit_c <- figs(y ~ x1 + x2, data = dfc, max_splits = 6)

head(predict(fit_c, new_data = dfc))
head(predict(fit_c, new_data = dfc, type = "prob"))

## ----parsnip------------------------------------------------------------------
library(parsnip)

spec <- figs_tree(max_splits = 6, min_n = 5) |>
  set_engine("figsr") |>
  set_mode("regression")

wf_fit <- fit(spec, y ~ x1 + x2 + x3, data = df)
head(predict(wf_fit, new_data = df))

## ----bagging------------------------------------------------------------------
bag <- bagging_figs(y ~ x1 + x2 + x3, data = df, n_estimators = 5, max_splits = 6)
head(predict(bag, new_data = df))

