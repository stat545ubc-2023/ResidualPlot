#' Residual Plot for Simple Linear Models
#'
#' This model creates a residual plot for a linear model with 1 explanatory variable. This can be used to test if the model meets the linearity and equal variance assumptions
#'
#'
#' @param df Data frame being used, hence df
#' @param y Numeric vector from df, which is the response variable, or "y" variable, need to be in df$column_name
#' @param b1 Numeric Vector from df, which is the explanatory variable. In simple linear regression, the slope associated with the first x variable would be b1, need to be in ""
#'
#' @return A graph
#' @export
#'
#' @examples
#' residual_plot(mtcars, mtcars$mpg, mtcars$wt) #it plots
#'
#' @import ggplot2
#' @importFrom stats lm


residual_plot <- function(df,y,b1){
  if(!is.numeric({{b1}})){ #must be numeric
    stop()
  }
  if(!is.numeric({{y}})){ #must be numeric
    stop()
  }
  model <- stats::lm({{y}} ~ {{b1}}, data=df) #creating linear model
  ggplot2::ggplot(model, aes(x = .fitted, y = .resid)) + #plotting
    ggplot2::geom_point() +
    ggplot2::geom_hline(yintercept = 0, color="red") +
    ggplot2::labs(title='Residual Plot', x='Fitted Values', y='Residuals')
}
