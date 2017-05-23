library(ggplot2)
# return a frame of the deviance scores on the permuted data
permutation_test = function(dataf, ycol, nperm) {
  nrows = dim(dataf)[1]
  y = dataf[[ycol]]
  X = dataf[, setdiff(colnames(dataf), ycol), drop=FALSE]
  varnames = colnames(X)
  fmla = paste("y", paste(varnames, collapse=" + "), sep=" ~ ")
  deviances <- numeric(nperm)
  for(i in seq_len(nperm)) {
    # random order of rows
    ord = sample.int(nrows, size=nrows, replace=FALSE)
    model = glm(fmla, data=cbind(y=y[ord], X),
                family=binomial(link="logit"))
    #print(summary(model))
    deviances[[i]] =model$deviance
  }
  deviances
}

score_variable = function(dframe, ycol, var, nperm,
                          title='') {
  df=data.frame(y=dframe[[ycol]], x=dframe[[var]])
  
  mod = glm("y~x", data=df,
            family=binomial(link="logit"))
  vdev = mod$deviance
  vperm = permutation_test(df, "y", nperm)
  
  # count how many times vdev >= deviances from perm test
  num = sum(vperm <= vdev)
  vscore = num/nperm
  print(ggplot(data.frame(nullperm=vperm), aes(x=nullperm)) +
          geom_density() + geom_vline(xintercept=vdev, color='red') +
          ggtitle(paste(title, "left tail area ~", vscore)))}

variable_deviance_test <- function(variable, nperm=500) {
  dframe = data[c(variable, "died")]
  score_variable(dframe, "died", variable, nperm,
                 title=paste(variable, 'deviance:'))
  fname <- paste(variable,'_deviance.png')
  ggsave(fname)
}

likelihood_ratio_test <- function(variable) {
  model1 <- glm(died ~ 1, data, family = binomial)
  formula <- as.formula(paste("died ~", variable))
  model2 <- glm(formula, data, family = binomial)
  anova(model1, model2, test="LRT")
}

plot_proportions_by_category <- function(variable) {
  fname <- paste(variable,'_barplot.png')  
  num_categories <- length(data[[variable]])
  if (num_categories <= 4) w = 480
  else if (num_categories <= 10) {w = (480 + 100*(num_categories-4))}
  else w = 1200
  png(fname, width=w, height=480)
  formula <- as.formula(paste("died ~", variable))
  dframe = aggregate(formula, data, mean)
  barplot(dframe$died, names.arg = dframe[[variable]], 
          col = "cornflowerblue",
          main = paste("Death rate distribution:", variable),
          ylab = "Death Rate",
          xlab = paste(variable, "levels"))
  m = mean(data$died)
  sd = sd(data$died)
  abline(h = m, lty=2, col="red")
  dev.off()
}

chisquare <-function(variable) {
  tbl <- table(data[[variable]], data$died)
  test <- chisq.test(tbl)
  test$p.value
}

ttest <- function(variable) {
  mask <- data$died==0
  v1 <- data[[variable]][mask]
  v2 <- data[[variable]][(!mask)]
  t.test(v1, v2)$p.value
}