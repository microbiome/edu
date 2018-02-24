



# Fit probabilistic ANOVA model
post <- stan_aov(diversity ~ sex + nationality + bmi_group, data = df,
                 prior = R2(location = 0.5), adapt_delta = 0.999)


post




post2 <- stan_lmer(diversity ~ 1 + (1|sex) + (1|nationality) + (1|bmi_group),
                   data = df, prior_intercept = cauchy(),
                   prior_covariance = decov(shape = 2, scale = 2),
                   adapt_delta = 0.999)



 
# compare_models(rstanarm::loo(post, k_threshold = 0.7), rstanarm::loo(post2, k_threshold = 0.7))

# -----------------------------------------------------------------------

