
library(HSAUR3)
data("clouds", package = "HSAUR3")
ols <- lm(rainfall ~ sne + cloudcover + time, data = clouds)

library(rstanarm)
post <- stan_lm(rainfall ~ sne + cloudcover + time, data = clouds,
                   prior = R2(location = 0.5))
post



varnames <- names(coef(ols))
plot(colMeans(as.data.frame(post))[varnames], coef(ols)[varnames]); abline(0,1)

