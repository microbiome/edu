library(microbiome)
#data(atlas1006)
#x <- subset_samples(baseline(atlas1006), DNA_extraction_method == "p")
data(dietswap)
x <- baseline(atlas1006)
df <- meta(x)
df$diversity <- diversities(x, "shannon")$shannon

# -------------------------

# ANOVA
post_aov <- stan_aov(diversity ~ age + gender + bmi_group,
                  data = df,
                  prior = R2(location = 0.5), adapt_delta = 0.999)

post_aov2 <- stan_aov(diversity ~ nationality,
                  data = df,
                  prior = R2(location = 0.5),
		  adapt_delta = 0.999)



# ----------------------------------

print("LM")

library(rstanarm)
post_lm <- stan_lm(diversity ~ age + gender + bmi_group,
                   data = df,
                   prior = R2(location = 0.5))
post_lm

# -------------------------

print("LMER")

post_lmer <- stan_lmer(diversity ~ 1 + (1|age) + (1|gender) + (1|bmi_group),
                   data = df, prior_intercept = cauchy(),
                   prior_covariance = decov(shape = 2, scale = 2),
                   adapt_delta = 0.999)

# -------------------------

# Classical model
ols <- lm(diversity ~ age + gender + 
                   bmi_group, data = df)

# ----------------------------------------------------------

# Compare the models
post <- post_aov
varnames <- names(coef(ols))
plot(colMeans(as.data.frame(post))[varnames], coef(ols)[varnames]); abline(0,1)

# ----------------------------------------------------------

# MOdel comparison
library(loo)
#print(compare_models(loo(post_aov), loo(post_lm)))
#barplot(c(ANOVA = waic(post_aov), LM = waic(post_lm), LMER = waic(post_lmer)))

# ------------------------------------------------------------

# Shiny stan
# launch_shinystan(post)



