---
title: "Linear models and probabilistic programming"
author: "Leo Lahti and Ville Laitinen | VIB / KU Leuven, Belgium - Feb 27, 2018"
date: "2018-02-25"
output:
  bookdown::html_document2:
    fig_caption: yes
---





# Introduction

**Target group**: those who are willing to have their first encounters with Bayesian modeling and inference 

**Learning goals** This tutorial gets you started in probabilistic programming. The aim is to learn how basic linear models can be implemented and extended using probabilistic programming tools, and understanding the underlying motivations and challenges.

**Teaching method** This material provides pointers for experimentation and online resources. The material is intended to be used in combination with lectures and hands-on instruction. 

## Probabilistic versus frequentist models

Probabilistic programming provides alternatives to classical models. Often, the models are identical under particular modeling assumptions. The probabilistic framework provides expanded opportunities to modify the model structure, distributional assumptions, and prior information.

This is particularly useful in cases where analytical solutions are not available, and classical counterparts may not exist. When both alternatives are available, incorporation of prior information can help to avoid overfitting and deal with small sample sizes, adding robustness in probabilistic models.

In standard cases, the Bayesian and frequentist versions give mostly similar estimates for the model parameters. This is not always the case, however. An example is given in the [stan_lm](http://mc-stan.org/rstanarm/articles/lm.html) page. In that example, the use of Bayesian prior helps to avoid overfitting and finds a more accurate solution when the sample size is small compared to the model complexity.

Due to time limitations, comparisons to the classical/frequentist models are not considered in this workshop. Instead, we focus on the use and interpretation of the probabilistic version.


# The tools: rstanarm

The [rstanarm R package](http://mc-stan.org/rstanarm/) is based on the Stan probabilistic programming language, but uses syntax that is familiar to R users who are familiar with traditional linear models.

For a more comprehensive introduction, check the [rstanarm tutorial](http://mc-stan.org/rstanarm/articles/aov.html).

Let us load the necessary libraries in R:



# Example data

Let us load example data. This data set from [Lahti et al. Nat. Comm. 5:4344, 2014](http://www.nature.com/ncomms/2014/140708/ncomms5344/full/ncomms5344.html) has microbiota profiles for 130 genus-like taxa across 1006 normal western adults from [Data Dryad](http://doi.org/10.5061/dryad.pk75d). Load the data in R:


```r
# Load example data
library(microbiome)
data(dietswap)

# Some necessary data preparations
sample_data(dietswap)$time <- sample_data(dietswap)$timepoint
x <- baseline(dietswap)
df <- meta(x)
df$diversity <- diversities(x, "shannon")$shannon
```



# Analysis steps

## Constructing the model

Let us fit [probabilistic ANOVA model](http://mc-stan.org/rstanarm/articles/aov.html).



```
## 
## SAMPLING FOR MODEL 'lm' NOW (CHAIN 1).
## 
## Gradient evaluation took 1.7e-05 seconds
## 1000 transitions using 10 leapfrog steps per transition would take 0.17 seconds.
## Adjust your expectations accordingly!
## 
## 
## Iteration:    1 / 2000 [  0%]  (Warmup)
## Iteration:  200 / 2000 [ 10%]  (Warmup)
## Iteration:  400 / 2000 [ 20%]  (Warmup)
## Iteration:  600 / 2000 [ 30%]  (Warmup)
## Iteration:  800 / 2000 [ 40%]  (Warmup)
## Iteration: 1000 / 2000 [ 50%]  (Warmup)
## Iteration: 1001 / 2000 [ 50%]  (Sampling)
## Iteration: 1200 / 2000 [ 60%]  (Sampling)
## Iteration: 1400 / 2000 [ 70%]  (Sampling)
## Iteration: 1600 / 2000 [ 80%]  (Sampling)
## Iteration: 1800 / 2000 [ 90%]  (Sampling)
## Iteration: 2000 / 2000 [100%]  (Sampling)
## 
##  Elapsed Time: 0.180378 seconds (Warm-up)
##                0.146166 seconds (Sampling)
##                0.326544 seconds (Total)
## 
## 
## SAMPLING FOR MODEL 'lm' NOW (CHAIN 2).
## 
## Gradient evaluation took 7e-06 seconds
## 1000 transitions using 10 leapfrog steps per transition would take 0.07 seconds.
## Adjust your expectations accordingly!
## 
## 
## Iteration:    1 / 2000 [  0%]  (Warmup)
## Iteration:  200 / 2000 [ 10%]  (Warmup)
## Iteration:  400 / 2000 [ 20%]  (Warmup)
## Iteration:  600 / 2000 [ 30%]  (Warmup)
## Iteration:  800 / 2000 [ 40%]  (Warmup)
## Iteration: 1000 / 2000 [ 50%]  (Warmup)
## Iteration: 1001 / 2000 [ 50%]  (Sampling)
## Iteration: 1200 / 2000 [ 60%]  (Sampling)
## Iteration: 1400 / 2000 [ 70%]  (Sampling)
## Iteration: 1600 / 2000 [ 80%]  (Sampling)
## Iteration: 1800 / 2000 [ 90%]  (Sampling)
## Iteration: 2000 / 2000 [100%]  (Sampling)
## 
##  Elapsed Time: 0.154002 seconds (Warm-up)
##                0.14468 seconds (Sampling)
##                0.298682 seconds (Total)
## 
## 
## SAMPLING FOR MODEL 'lm' NOW (CHAIN 3).
## 
## Gradient evaluation took 8e-06 seconds
## 1000 transitions using 10 leapfrog steps per transition would take 0.08 seconds.
## Adjust your expectations accordingly!
## 
## 
## Iteration:    1 / 2000 [  0%]  (Warmup)
## Iteration:  200 / 2000 [ 10%]  (Warmup)
## Iteration:  400 / 2000 [ 20%]  (Warmup)
## Iteration:  600 / 2000 [ 30%]  (Warmup)
## Iteration:  800 / 2000 [ 40%]  (Warmup)
## Iteration: 1000 / 2000 [ 50%]  (Warmup)
## Iteration: 1001 / 2000 [ 50%]  (Sampling)
## Iteration: 1200 / 2000 [ 60%]  (Sampling)
## Iteration: 1400 / 2000 [ 70%]  (Sampling)
## Iteration: 1600 / 2000 [ 80%]  (Sampling)
## Iteration: 1800 / 2000 [ 90%]  (Sampling)
## Iteration: 2000 / 2000 [100%]  (Sampling)
## 
##  Elapsed Time: 0.150698 seconds (Warm-up)
##                0.169142 seconds (Sampling)
##                0.31984 seconds (Total)
## 
## 
## SAMPLING FOR MODEL 'lm' NOW (CHAIN 4).
## 
## Gradient evaluation took 7e-06 seconds
## 1000 transitions using 10 leapfrog steps per transition would take 0.07 seconds.
## Adjust your expectations accordingly!
## 
## 
## Iteration:    1 / 2000 [  0%]  (Warmup)
## Iteration:  200 / 2000 [ 10%]  (Warmup)
## Iteration:  400 / 2000 [ 20%]  (Warmup)
## Iteration:  600 / 2000 [ 30%]  (Warmup)
## Iteration:  800 / 2000 [ 40%]  (Warmup)
## Iteration: 1000 / 2000 [ 50%]  (Warmup)
## Iteration: 1001 / 2000 [ 50%]  (Sampling)
## Iteration: 1200 / 2000 [ 60%]  (Sampling)
## Iteration: 1400 / 2000 [ 70%]  (Sampling)
## Iteration: 1600 / 2000 [ 80%]  (Sampling)
## Iteration: 1800 / 2000 [ 90%]  (Sampling)
## Iteration: 2000 / 2000 [100%]  (Sampling)
## 
##  Elapsed Time: 0.175245 seconds (Warm-up)
##                0.146739 seconds (Sampling)
##                0.321984 seconds (Total)
```


Investigate the fitted model:


```
## stan_aov
##  family:       gaussian [identity]
##  formula:      diversity ~ sex + nationality + bmi_group
##  observations: 38
## ------
##                     Median MAD_SD
## (Intercept)          3.0    0.3  
## sexMale             -0.2    0.2  
## nationalityAFR      -0.6    0.2  
## bmi_groupoverweight -0.1    0.3  
## bmi_groupobese      -0.4    0.3  
## sigma                0.6    0.1  
## log-fit_ratio        0.0    0.1  
## R2                   0.3    0.1  
## 
## Sample avg. posterior predictive distribution of y:
##          Median MAD_SD
## mean_PPD 2.4    0.1   
## 
## ANOVA-like table:
##                     Median MAD_SD
## Mean Sq sex         0.1    0.2   
## Mean Sq nationality 3.0    1.8   
## Mean Sq bmi_group   0.6    0.5   
## 
## ------
## For info on the priors used see help('prior_summary.stanreg').
```


Investigate the posterior samples:


```
##   (Intercept)     sexMale nationalityAFR bmi_groupoverweight
## 1    2.683323 -0.17207208     -0.3241046         -0.01748698
## 2    2.913006 -0.10173861     -0.6053699         -0.16664293
## 3    3.344086 -0.29229176     -0.5178681         -0.44801768
## 4    2.711193 -0.14067112     -0.2360834          0.10085647
## 5    2.588782 -0.04265028     -0.3080736          0.30595890
## 6    2.142272 -0.16689869     -0.2498702          0.71472661
##   bmi_groupobese     sigma log-fit_ratio         R2
## 1   -0.202375734 0.5101767   -0.18618142 0.11154696
## 2   -0.370665075 0.5071771   -0.09969045 0.26143719
## 3   -0.581318555 0.5323261   -0.09144159 0.19968903
## 4   -0.174963108 0.7108176    0.11565422 0.05694196
## 5    0.008740636 0.6686634    0.08366242 0.11033833
## 6   -0.012429354 0.5303461    0.02682531 0.37295806
```


Investigate the posterior samples for a selected parameter:

![plot of chunk posterior2](figs/posterior2-1.png)



### Bayesian priors

Find out more about Bayesian priors in linear models (including ANOVA):

 - [Priors in linear models](http://mc-stan.org/rstanarm/articles/lm.html)

 - [More on priors in rstanarm](http://mc-stan.org/rstanarm/articles/priors.html)



## Draw from posterior distribution




## Assess the model fit and criticize the model


### Interactive ShinyStan 

Explore the use of [shinystan R package](http://mc-stan.org/users/interfaces/shinystan). This provides tools to diagnose stan models visually and numerically, including model parameters and convergence diagnostics for MCMC simulations.



ShinyStan is widely applicable to MCMC outputs from Stan, JAGS, BUGS, MCMCPack, NIMBLE, emcee, SAS, and others.

### Further model diagnostics

* Posterior predictive checks
* Leave-one-out cross-validation




# Assess changes in the model






# Tasks: extend and vary the linear model

For standard group-wise comparisons and random effects, see the tutorial on [ANOVA and mixed linear models](http://mc-stan.org/rstanarm/articles/aov.html). Experiment with the different options using either the provided example data, or a data set of your own.




# Troubleshooting

Ask the instructors, or see the [rstanarm tutorial](http://mc-stan.org/rstanarm/articles/rstanarm.html) for tips on common problems that may arise when altering the model.

# Other examples

You can also change modeling assumptions, or construct more complex models. See the [rstanarm tutorials](http://mc-stan.org/rstanarm/articles/index.html) for more examples. You can try these out, and we aim to support in the process!


# Further Resources and  literature

[R users will now inevitably become Bayesians](https://thinkinator.com/2016/01/12/r-users-will-now-inevitably-become-bayesians/)

[Online manual for rstanarm](http://mc-stan.org/rstanarm/)

[Video tutorial on rstanarm](https://www.youtube.com/watch?v=z7zOzL9Rrzs)




# Contact and acknowledgement

Regarding the course content, you can contact [Leo Lahti](http://www.iki.fi/Leo.Lahti).

We are grateful for the developers of rstan, rstanarm, and shinystan. Regarding the external tutorials used in this assignment, contact the respective authors.



