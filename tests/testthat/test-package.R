library(palmerpenguins)
library(gapminder)
library(tidyverse)

test_that("Function returns ggplot object",{
  is.plot <- residual_plot(gapminder,gapminder$lifeExp,gapminder$gdpPercap) #function we are testing
  expect_is(is.plot,"ggplot") #should be a ggplot product
})

test_that("This function only works for numeric values", {
  expect_error(residual_plot(penguins, penguins$species, penguins$bill_length_mm)) #species is categorical
  expect_error(residual_plot(penguins, penguins$bill_length_mm, penguins$species)) #try in both variable options
  expect_no_error(residual_plot(penguins, penguins$bill_depth_mm, penguins$bill_length_mm)) #both numeric
})

test_that("GGplot is creating correct residuals and fitted values", {
  model.1 <- lm(lifeExp ~ gdpPercap, data = gapminder) #linear model
  gapminder$fitted_vals <- fitted(model.1) #fitted values to compare to graph values
  gapminder$resids <- residuals(model.1) # residual values to compare to graph values
  test1 <- residual_plot(gapminder, gapminder$lifeExp,gapminder$gdpPercap) #graph from function we are testing
  from_graph_y <- data.frame(y=test1$data$.resid) #y values from graph
  from_model_y <- data.frame(y=gapminder$resids) #y values we found through model
  expect_equal(from_graph_y$y, from_model_y$y) #they should be the same
  from_graph_x <- data.frame(x=test1$data$.fitted) #x values from graph
  from_model_x <- data.frame(x=gapminder$fitted_vals) #x values we found through model
  expect_equal(from_graph_y$y, from_model_y$y) #they should be the same
})
