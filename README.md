# Predicting Mortality of Children under 5 years of age

In this project we set 2 goals:

1. **Inference**: Identifying factors that are predictive in nature of child mortality

2. **Predictive**: Build a model that would allow to classify households on the field and assign them a child mortality risk score

I worked in collaboration with [Living Goods](https://livinggoods.org), a San Francisco based NGO, already operative on the field since many year, specifically in Uganda and Kenya. Community Health Providers (CHPs) are identified in each village, they are given a basic education and the tools to visit families in their parishes and provide them with basic health assistance. Using a web application developed by Living Goods and deployed on Android phones, each CHP can answer basic questions and gather data as they visit households, but for legal reasons, they cannot record deaths.

Our problem was to find a proxy of information that contained both general characteristics of households and mortality data. For that purpose we used data from a Randomized Controlled Trial (RCT) in the form of surveys that targeted the exact same population.

The first phase of the project was inferential in nature: identify questions that relate to child mortality.
The main challenge of the project lied in the data:

* pretty **small data** (6700 data points, one data point being a survey)
* pretty **fat data** (361 base features, one feature being one question)
* extremely **unbalanced classes** (5.33% minority class, minority class being child death)
* very **low signal** (almost all questions were categorical in nature, yes/no kind of question, Likert scales when we were lucky)

We run each single feature through a separate statistical test: Chi-squared vs ANOVA depending upon the nature of the feature (categorical vs quantitative), and reported the resulting p-values. We chose to set significance at 0.1, which is pretty common in these kind of low signal scenarios, but corrected for the number of tests we run using a simple Bonferroni correction.

The resulting set of 40 some features were further passes through:

* sanity check: do the results make sense?
* reality check: if the results make sense, can Living Goods collect these data on the field?
* double check for statistical significance: deviance analysis, where we basically fit as many simple logistic regression as there are significant features that survived the sanity and reality check and compared the resulting deviance to the one of the same model only after shuffling the predictor variable. That was aimed at answering the question: apart from the statistical significance, do we see some real predictive power in the feature?

The second phase of the project was the model fitting. We had to deal with the very high unbalance and tried the following approaches for that:

* **oversample** the minority class: that has the drawback that we are basically duplicating our positive outcomes, and thus reducing the variance of that population. And the variance is our signal.
* **undersample** the majority class: It preserves all the signal in the minority class, but it throws away data, and we don't have many of it in the first place.

We fit Random Forests, Ada- and Gradient-Boosting, SVM. We also extended the Bagging algorithm to implement a Balanced Bagging version of it, where basically between the bootstrap sampling and the actual model fitting, an over-/undersampling of the bootstrapped data set takes place.

Not surprisingly at the end Gradient Boosting was the best performer.
With it we were able to achieve 0.75 AUC ROC score.
Our recall was 0.82, with a False Positive Rate of 0.43. We weren't so much concerned with the high FPR, because Living Goods is going to still visit all households even if a scoring model will classify them as low risk. What we were focused on was achieving high specifity, and 0.82, compared to the 0.053 baseline without any predictor is very satisfactory to begin with.
Back to the was not surprisingly: with a very low signal data set, any algorithm that is able to learn slowly and progressively correct prediction errors step-by-step, sounds very much like one that has a better chance at performing well among those tried, as opposed to algorithms that fit very deep decision trees, like random forests.

Future work would imply trying to use an anomaly detection framework to handle the very high unbalance: in the literature there are very interesting references to isolation forests, where many random forest are fitted and the output one's interested in is the average number of branches that are necessary to perfectly isolate any data point. The hope is that minority class instances will have a significantly higher average path length.
