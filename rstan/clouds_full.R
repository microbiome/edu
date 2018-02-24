library(HSAUR3)
data("clouds", package = "HSAUR3")
ols <- lm(rainfall ~ seeding * (sne + cloudcover + prewetness + echomotion) +
            time, data = clouds)

library(rstanarm)
post <- stan_lm(rainfall ~ seeding * (sne + cloudcover + prewetness + 
                                        echomotion) + time, data = clouds,
                prior = R2(location = 0.2), 
                chains = 3, cores = 1, seed = 342)
post



varnames <- names(coef(ols))
plot(colMeans(as.data.frame(post))[varnames], coef(ols)[varnames]); abline(0,1)

