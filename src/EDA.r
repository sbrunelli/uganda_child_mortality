#require("RPostgreSQL")
#drv <- dbDriver("PostgreSQL")
#con <- dbConnect(drv, dbname = "lg",
#                 host = "localhost", port = 5432,
#                 user = "postgres")

# Read the data
#res <- dbSendQuery(con, "SELECT * from significance_test")
res <- dbSendQuery(con, "SELECT * from survey")
data <- fetch(res, n = -1)

# Cast variables to appropriate type
data$district_name <- as.factor(data$district_name)
data$subcounty_name <- as.factor(data$subcounty_name)
data$parish_name <- as.factor(data$parish_name)
#data$village_name_old <- as.factor(data$village_name_old)
data$died <- as.numeric(data$died)
data$qn201_know <- as.factor(data$qn201_know)
data$qn202_know <- as.factor(data$qn202_know)
data$qn203_know <- as.factor(data$qn203_know)
data$qn204_know <- as.factor(data$qn204_know)
data$qn205_know <- as.factor(data$qn205_know)
data$qn206a_know <- as.factor(data$qn206a_know)
data$qn206b_know <- as.factor(data$qn206b_know)
data$qn206c_know <- as.factor(data$qn206c_know)
data$qn206d_know <- as.factor(data$qn206d_know)
data$qn206_totmalflag5 <- as.numeric(data$qn206_totmalflag5)
data$qn207a_know <- as.factor(data$qn207a_know)
data$qn208_know <- as.factor(data$qn208_know)
data$qn209a_know <- as.factor(data$qn209a_know)
data$qn209b_know <- as.factor(data$qn209b_know)
data$qn209c_know <- as.factor(data$qn209c_know)
data$qn210_know <- as.factor(data$qn210_know)
data$qn211a_know <- as.factor(data$qn211a_know)
data$qn211b_know <- as.factor(data$qn211b_know)
data$qn211c_know <- as.factor(data$qn211c_know)
data$qn212_know <- as.factor(data$qn212_know)
data$qn213_know <- as.factor(data$qn213_know)
data$qn214_know <- as.factor(data$qn214_know)
data$qn215_know <- as.factor(data$qn215_know)
data$qn216_know <- as.factor(data$qn216_know)
data$qn217_know <- as.factor(data$qn217_know)
data$qn218_know <- as.factor(data$qn218_know)
data$qn219_know <- as.factor(data$qn219_know)
data$qn220_know <- as.factor(data$qn220_know)
data$qn221_know <- as.factor(data$qn221_know)
data$qn222_know <- as.factor(data$qn222_know)
data$qn223_know <- as.factor(data$qn223_know)
data$qn224_know <- as.factor(data$qn224_know)
data$qn225_know <- as.factor(data$qn225_know)
data$qn226_know <- as.factor(data$qn226_know)
data$qn227_know <- as.factor(data$qn227_know)
data$qn1001_hhw <- as.numeric(data$qn1001_hhw)
data$qn1002_hhw <- as.factor(data$qn1002_hhw)
data$qn1003_hhw <- as.factor(data$qn1003_hhw)
data$qn1004_hhw <- as.factor(data$qn1004_hhw)
data$qn1005_hhw <- as.factor(data$qn1005_hhw)
data$qn1006_hhw <- as.factor(data$qn1006_hhw)
data$qn1007_hhw <- as.factor(data$qn1007_hhw)
data$qn1008_hhw <- as.factor(data$qn1008_hhw)
data$qn1009_hhw <- as.numeric(data$qn1009_hhw)
data$qn1010_hhw <- as.factor(data$qn1010_hhw)
data$qn1011_hhw <- as.factor(data$qn1011_hhw)
data$qn1012_hhw <- as.factor(data$qn1012_hhw)
data$qn1013_hhw <- as.factor(data$qn1013_hhw)
data$qn1014_hhw <- as.factor(data$qn1014_hhw)
data$qn01_103 <- as.numeric(data$qn01_103)
data$qn01_104 <- as.factor(data$qn01_104)
data$qn01_105 <- as.factor(data$qn01_105)
data$qn01_106 <- as.factor(data$qn01_106)
data$totalshops_village <- as.numeric(data$totalshops_village)
data$shop_village <- as.factor(data$shop_village)

# Impute mean for NAs 
data[is.na(data$qn1009_hhw),]$qn1009_hhw <- mean(data$qn1009_hhw, na.rm = T)

# Variable analysis
library(dplyr)
source("/Users/stefanobrunelli//Galvanize/Capstone/src/functions.r")

setwd("/Users/stefanobrunelli/Galvanize/Capstone/images")

# Split categorical and quantitative variables as they'll have 2 different categories
# of tests
#cols <- setdiff(colnames(data), "died")
classes <- sapply(data, class)
categorical_vars <- names(classes[classes == "factor"])
quantitative_vars <- setdiff(names(classes[classes != "factor"]), "died")

significance_threshold <- 0.1
#########################################################
# Run Chi-squared tests against categorical variables
#########################################################
categorical_tests <- sapply(categorical_vars, chisquare)
ct <- as.vector(categorical_tests)
plot(as.vector(categorical_tests), pch = 19, 
     xlab = "Question index", ylab="p_value", 
     main = "Test of significance for categorical questions", 
     ylim = c(-0.05,1.05), 
     col=ifelse((0 < ct) & (ct < significance_threshold),"green","red"))
abline(h=significance_threshold, col="darkgrey", lty=2)

mask <- (0 < categorical_tests) & (categorical_tests < significance_threshold)
chosen_variables <- names(categorical_tests[mask])

#########################################################
# Run t-tests against quantitative variables
#########################################################
quantitative_tests <- sapply(quantitative_vars, ttest)
qt <- as.vector(quantitative_tests)
plot(as.vector(quantitative_tests), pch = 19, 
     xlab = "Question index", ylab="p_value", 
     main = "Test of significance for quantitative questions", 
     ylim = c(-0.05,1.05), 
     col=ifelse((0 < qt) & (qt < significance_threshold),"green","red"))
abline(h=significance_threshold, col="darkgrey", lty=2)

mask <- (0 < quantitative_tests) & (quantitative_tests < significance_threshold)
chosen_variables <- c(chosen_variables, names(quantitative_tests[mask]))


#########################################################
# Run deviance tests
#########################################################
lapply(chosen_variables, variable_deviance_test)

#########################################################
# Run likelihood ratio test
#########################################################
likelihood_ratio_test("district_name")
likelihood_ratio_test("subcounty_name")
likelihood_ratio_test("parish_name")
likelihood_ratio_test("qn204_know")
likelihood_ratio_test("qn209b_know")
likelihood_ratio_test("qn210_know")
likelihood_ratio_test("qn211a_know")
likelihood_ratio_test("qn216_know")
likelihood_ratio_test("qn217_know")
likelihood_ratio_test("qn1002_hhw")
likelihood_ratio_test("shop_village")
likelihood_ratio_test("qn1009_hhw")
likelihood_ratio_test("totalshops_village")

#########################################################
# Build plots
#########################################################
plot_proportions_by_category("district_name")
plot_proportions_by_category("subcounty_name")
plot_proportions_by_category("parish_name")
plot_proportions_by_category("qn204_know")
plot_proportions_by_category("qn209b_know")
plot_proportions_by_category("qn210_know")
plot_proportions_by_category("qn211a_know")
plot_proportions_by_category("qn216_know")
plot_proportions_by_category("qn217_know")
plot_proportions_by_category("qn1002_hhw")
plot_proportions_by_category("shop_village")
boxplot(qn1009_hhw ~ as.factor(died), data, col = "cornflowerblue",
        main = "Death rate distribution: qn1009_hhw",
        ylab = "Death Rate",
        xlab = "qn1009_hhw levels")
boxplot(totalshops_village ~ as.factor(died), data, col = "cornflowerblue",
        main = "Death rate distribution: qn1009_hhw",
        ylab = "Death Rate",
        xlab = "qn1009_hhw levels")
