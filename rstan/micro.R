
library(microbiome)
data(atlas1006)
x <- subset_samples(baseline(atlas1006), DNA_extraction_method == "p")
df <- meta(x)
df$diversity <- diversities(x, "shannon")$shannon



ols <- lm(diversity ~ age + gender + 
                   bmi_group, data = df)

library(rstanarm)
post <- stan_lm(diversity ~ age + gender + 
                   bmi_group, data = df,
                   prior = R2(location = 0.5))
post



varnames <- names(coef(ols))
plot(colMeans(as.data.frame(post))[varnames], coef(ols)[varnames]); abline(0,1)

