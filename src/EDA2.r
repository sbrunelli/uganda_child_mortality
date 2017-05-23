# require("RPostgreSQL")
# drv <- dbDriver("PostgreSQL")
# con <- dbConnect(drv, dbname = "lg",
#                 host = "localhost", port = 5432,
#                 user = "postgres")

# Read the data
#res <- dbSendQuery(con, "SELECT * from significance_test")
res <- dbSendQuery(con, "SELECT * from survey")
data <- fetch(res, n = -1)

# Cast variables to appropriate type
data$district_name <- as.factor(as.character(data$district_name))
data$subcounty_name <- as.factor(as.character(data$subcounty_name))
data$parish_name <- as.factor(as.character(data$parish_name))
data$village_name_old <- as.factor(as.character(data$village_name_old))
data$qn01_405 <- as.factor(as.character(data$qn01_405))
data$qn01_405_othr <- as.factor(as.character(data$qn01_405_othr))
data$qn01_103 <- as.numeric(as.character(data$qn01_103))
data$qn01_104 <- as.factor(as.character(data$qn01_104))
data$qn01_105 <- as.factor(as.character(data$qn01_105))
data$qn01_106 <- as.factor(as.character(data$qn01_106))
data$qn201_know <- as.factor(as.character(data$qn201_know))
data$qn202_know <- as.factor(as.character(data$qn202_know))
data$qn203_know <- as.factor(as.character(data$qn203_know))
data$qn204_know <- as.factor(as.character(data$qn204_know))
data$qn205_know <- as.factor(as.character(data$qn205_know))
data$qn206a_know <- as.factor(as.character(data$qn206a_know))
data$qn206b_know <- as.factor(as.character(data$qn206b_know))
data$qn206c_know <- as.factor(as.character(data$qn206c_know))
data$qn206d_know <- as.factor(as.character(data$qn206d_know))
data$qn207a_know <- as.factor(as.character(data$qn207a_know))
data$qn208_know <- as.factor(as.character(data$qn208_know))
data$qn209a_know <- as.factor(as.character(data$qn209a_know))
data$qn209b_know <- as.factor(as.character(data$qn209b_know))
data$qn209c_know <- as.factor(as.character(data$qn209c_know))
data$qn210_know <- as.factor(as.character(data$qn210_know))
data$qn211a_know <- as.factor(as.character(data$qn211a_know))
data$qn211b_know <- as.factor(as.character(data$qn211b_know))
data$qn211c_know <- as.factor(as.character(data$qn211c_know))
data$qn212_know <- as.factor(as.character(data$qn212_know))
data$qn213_know <- as.factor(as.character(data$qn213_know))
data$qn214_know <- as.factor(as.character(data$qn214_know))
data$qn215_know <- as.factor(as.character(data$qn215_know))
data$qn216_know <- as.factor(as.character(data$qn216_know))
data$qn217_know <- as.factor(as.character(data$qn217_know))
data$qn218_know <- as.factor(as.character(data$qn218_know))
data$qn219_know <- as.factor(as.character(data$qn219_know))
data$qn220_know <- as.factor(as.character(data$qn220_know))
data$qn221_know <- as.factor(as.character(data$qn221_know))
data$qn222_know <- as.factor(as.character(data$qn222_know))
data$qn223_know <- as.factor(as.character(data$qn223_know))
data$qn224_know <- as.factor(as.character(data$qn224_know))
data$qn225_know <- as.factor(as.character(data$qn225_know))
data$qn226_know <- as.factor(as.character(data$qn226_know))
data$qn227_know <- as.factor(as.character(data$qn227_know))
data$qn302c_mal <- as.factor(as.character(data$qn302c_mal))
data$qn303c_mal <- as.factor(as.character(data$qn303c_mal))
data$qn304c_mal <- as.factor(as.character(data$qn304c_mal))
data$qn305c_mal <- as.factor(as.character(data$qn305c_mal))
data$qn306c_mal <- as.factor(as.character(data$qn306c_mal))
data$qn307c_mal <- as.factor(as.character(data$qn307c_mal))
data$qn308c_mal <- as.factor(as.character(data$qn308c_mal))
data$qn309ac_mal <- as.factor(as.character(data$qn309ac_mal))
data$qn309bc_mal <- as.factor(as.character(data$qn309bc_mal))
data$qn310c_mal <- as.factor(as.character(data$qn310c_mal))
data$qn310bc_mal <- as.factor(as.character(data$qn310bc_mal))
data$qn311c_mal <- as.factor(as.character(data$qn311c_mal))
data$qn311bc_mal <- as.factor(as.character(data$qn311bc_mal))
data$qn312c_mal <- as.factor(as.character(data$qn312c_mal))
data$qn313c_mal <- as.factor(as.character(data$qn313c_mal))
data$qn313bc_mal <- as.factor(as.character(data$qn313bc_mal))
data$qn314c_mal <- as.factor(as.character(data$qn314c_mal))
data$qn314bc_mal <- as.factor(as.character(data$qn314bc_mal))
data$qn315c_mal <- as.factor(as.character(data$qn315c_mal))
data$qn315bc_mal <- as.factor(as.character(data$qn315bc_mal))
data$qn316c_mal <- as.factor(as.character(data$qn316c_mal))
data$qn317c_mal <- as.factor(as.character(data$qn317c_mal))
data$qn318c_mal <- as.factor(as.character(data$qn318c_mal))
data$qn319c_mal <- as.factor(as.character(data$qn319c_mal))
data$qn320c_mal <- as.factor(as.character(data$qn320c_mal))
data$qn502c_dia <- as.factor(as.character(data$qn502c_dia))
data$qn503c_dia <- as.factor(as.character(data$qn503c_dia))
data$qn504c_dia <- as.factor(as.character(data$qn504c_dia))
data$qn505ca_dia <- as.factor(as.character(data$qn505ca_dia))
data$qn505cb_dia <- as.factor(as.character(data$qn505cb_dia))
data$qn506c_dia <- as.factor(as.character(data$qn506c_dia))
data$qn506cb_dia <- as.factor(as.character(data$qn506cb_dia))
data$qn507c_dia <- as.factor(as.character(data$qn507c_dia))
data$qn508c_dia <- as.factor(as.character(data$qn508c_dia))
data$qn508cb_dia <- as.factor(as.character(data$qn508cb_dia))
data$qn509c_dia <- as.factor(as.character(data$qn509c_dia))
data$qn509cb_dia <- as.factor(as.character(data$qn509cb_dia))
data$qn510c_dia <- as.factor(as.character(data$qn510c_dia))
data$qn511c_dia <- as.factor(as.character(data$qn511c_dia))
data$qn512c_dia <- as.factor(as.character(data$qn512c_dia))
data$qn513c_dia <- as.factor(as.character(data$qn513c_dia))
data$qn602c_fort <- as.factor(as.character(data$qn602c_fort))
data$qn603c_fort <- as.factor(as.character(data$qn603c_fort))
data$qn604cb_fort <- as.factor(as.character(data$qn604cb_fort))
data$qn604c_fort <- as.factor(as.character(data$qn604c_fort))
data$qn605c_fort <- as.factor(as.character(data$qn605c_fort))
data$qn606c_fort <- as.factor(as.character(data$qn606c_fort))
data$qn607c_fort <- as.factor(as.character(data$qn607c_fort))
data$qn701_chp <- as.factor(as.character(data$qn701_chp))
data$qn702_chp <- as.factor(as.character(data$qn702_chp))
data$qn703_chp <- as.factor(as.character(data$qn703_chp))
data$qn704_chp <- as.factor(as.character(data$qn704_chp))
data$qn705_chp <- as.factor(as.character(data$qn705_chp))
data$qn706a_chp <- as.factor(as.character(data$qn706a_chp))
data$qn706b_chp <- as.factor(as.character(data$qn706b_chp))
data$qn707a_chp <- as.factor(as.character(data$qn707a_chp))
data$qn707b_chp <- as.factor(as.character(data$qn707b_chp))
data$qn708_chp <- as.factor(as.character(data$qn708_chp))
data$qn709_chp <- as.factor(as.character(data$qn709_chp))
data$qn710_chp <- as.factor(as.character(data$qn710_chp))
data$qn710b_chp <- as.factor(as.character(data$qn710b_chp))
data$qn711_chp <- as.factor(as.character(data$qn711_chp))
data$qn712_chp <- as.factor(as.character(data$qn712_chp))
data$qn713_chp <- as.factor(as.character(data$qn713_chp))
data$qn714_chp <- as.numeric(as.character(data$qn714_chp))
data$qn715_chp <- as.numeric(as.character(data$qn715_chp))
data$qn716_chp <- as.factor(as.character(data$qn716_chp))
data$qn717_chp <- as.factor(as.character(data$qn717_chp))
data$qn718_chp <- as.numeric(as.character(data$qn718_chp))
data$qn719_chp <- as.factor(as.character(data$qn719_chp))
data$qn720_chp <- as.factor(as.character(data$qn720_chp))
data$qn721_chp <- as.factor(as.character(data$qn721_chp))
data$qn722_chp <- as.numeric(as.character(data$qn722_chp))
data$qn723_chp <- as.factor(as.character(data$qn723_chp))
data$qn724_chp <- as.factor(as.character(data$qn724_chp))
data$qn725_chp <- as.factor(as.character(data$qn725_chp))
data$qn725a_chp <- as.factor(as.character(data$qn725a_chp))
data$qn725b_chp <- as.factor(as.character(data$qn725b_chp))
data$qn725c_chp <- as.factor(as.character(data$qn725c_chp))
data$qn726_chp <- as.factor(as.character(data$qn726_chp))
data$qn726a_chp <- as.factor(as.character(data$qn726a_chp))
data$qn726b_chp <- as.factor(as.character(data$qn726b_chp))
data$qn726c_chp <- as.factor(as.character(data$qn726c_chp))
data$qn727_chp <- as.factor(as.character(data$qn727_chp))
data$qn728_chp <- as.factor(as.character(data$qn728_chp))
data$qn729_chp <- as.factor(as.character(data$qn729_chp))
data$qn730_chp <- as.factor(as.character(data$qn730_chp))
data$qn731_chp <- as.factor(as.character(data$qn731_chp))
data$qn732_chp <- as.factor(as.character(data$qn732_chp))
data$qn733_chp <- as.factor(as.character(data$qn733_chp))
data$qn734_chp <- as.factor(as.character(data$qn734_chp))
data$qn735_chp <- as.factor(as.character(data$qn735_chp))
data$qn736_chp <- as.factor(as.character(data$qn736_chp))
data$qn737_chp <- as.factor(as.character(data$qn737_chp))
data$qn738_chp <- as.factor(as.character(data$qn738_chp))
data$qn739_chp <- as.numeric(as.character(data$qn739_chp))
data$qn740_chp <- as.factor(as.character(data$qn740_chp))
data$qn741_chp <- as.numeric(as.character(data$qn741_chp))
data$qn1001_hhw <- as.numeric(as.character(data$qn1001_hhw))
data$qn1002_hhw <- as.factor(as.character(data$qn1002_hhw))
data$qn1003_hhw <- as.factor(as.character(data$qn1003_hhw))
data$qn1004_hhw <- as.factor(as.character(data$qn1004_hhw))
data$qn1005_hhw <- as.factor(as.character(data$qn1005_hhw))
data$qn1006_hhw <- as.factor(as.character(data$qn1006_hhw))
data$qn1007_hhw <- as.factor(as.character(data$qn1007_hhw))
data$qn1008_hhw <- as.factor(as.character(data$qn1008_hhw))
data$qn1009_hhw <- as.numeric(as.character(data$qn1009_hhw))
data$qn1010_hhw <- as.factor(as.character(data$qn1010_hhw))
data$qn1011_hhw <- as.factor(as.character(data$qn1011_hhw))
data$qn1012_hhw <- as.factor(as.character(data$qn1012_hhw))
data$qn1013_hhw <- as.factor(as.character(data$qn1013_hhw))
data$qn1014_hhw <- as.factor(as.character(data$qn1014_hhw))
data$villagename_actual <- as.factor(as.character(data$villagename_actual))
data$subcounty_actual <- as.factor(as.character(data$subcounty_actual))
data$parish_actual <- as.factor(as.character(data$parish_actual))
data$totalshops_village <- as.numeric(as.character(data$totalshops_village))
data$shop_village <- as.factor(as.character(data$shop_village))
data$mchildren2008_village <- as.numeric(as.character(data$mchildren2008_village))
data$bednets_village <- as.factor(as.character(data$bednets_village))
data$childid <- as.factor(as.character(data$childid))
data$datebirth <- as.factor(as.character(data$datebirth))
data$female <- as.factor(as.character(data$female))
data$died <- as.numeric(as.character(data$died))
data$datedeath <- as.factor(as.character(data$datedeath))
data$qn801w <- as.numeric(as.character(data$qn801w))
data$qn8id <- as.factor(as.character(data$qn8id))
data$qn803w_pnc <- as.numeric(as.character(data$qn803w_pnc))
data$qn804w_pnc <- as.factor(as.character(data$qn804w_pnc))
data$qn805w_pnc <- as.numeric(as.character(data$qn805w_pnc))
data$qn806w_pnc <- as.factor(as.character(data$qn806w_pnc))
data$qn807w_pnc <- as.factor(as.character(data$qn807w_pnc))
data$qn808w_pnc <- as.factor(as.character(data$qn808w_pnc))
data$qn809w_pnc <- as.factor(as.character(data$qn809w_pnc))
data$qn810w_pnc <- as.factor(as.character(data$qn810w_pnc))
data$qn811w_pnc <- as.factor(as.character(data$qn811w_pnc))
data$qn812w_pnc <- as.factor(as.character(data$qn812w_pnc))
data$qn813w_pnc <- as.factor(as.character(data$qn813w_pnc))
data$qn814w_pnc <- as.factor(as.character(data$qn814w_pnc))
data$qn815w_pnc <- as.factor(as.character(data$qn815w_pnc))
data$qn816w_pnc <- as.numeric(as.character(data$qn816w_pnc))
data$qn817w_pnc <- as.factor(as.character(data$qn817w_pnc))
data$qn818w_pnc <- as.numeric(as.character(data$qn818w_pnc))
data$qn819w_pnc <- as.factor(as.character(data$qn819w_pnc))
data$qn820w_pnc <- as.factor(as.character(data$qn820w_pnc))
data$qn820aw_pnc <- as.factor(as.character(data$qn820aw_pnc))
data$qn821w_pnc <- as.factor(as.character(data$qn821w_pnc))
data$qn822w_pnc <- as.factor(as.character(data$qn822w_pnc))
data$qn822aw_pnc <- as.factor(as.character(data$qn822aw_pnc))
data$qn823w_pnc <- as.factor(as.character(data$qn823w_pnc))
data$qn824w_pnc <- as.factor(as.character(data$qn824w_pnc))
data$qn824aw_pnc <- as.factor(as.character(data$qn824aw_pnc))
data$qn825w_pnc <- as.factor(as.character(data$qn825w_pnc))
data$qn826w_pnc <- as.factor(as.character(data$qn826w_pnc))
data$qn826aw_pnc <- as.factor(as.character(data$qn826aw_pnc))
data$qn827w_pnc <- as.factor(as.character(data$qn827w_pnc))
data$qn828w_pnc <- as.factor(as.character(data$qn828w_pnc))
data$qn828aw_pnc <- as.factor(as.character(data$qn828aw_pnc))
data$qn829w_pnc <- as.factor(as.character(data$qn829w_pnc))
data$qn830w_pnc <- as.factor(as.character(data$qn830w_pnc))
data$qn830aw_pnc <- as.factor(as.character(data$qn830aw_pnc))
data$qn831w_pnc <- as.factor(as.character(data$qn831w_pnc))
data$qn832w_pnc <- as.factor(as.character(data$qn832w_pnc))
data$qn832aw_pnc <- as.factor(as.character(data$qn832aw_pnc))
data$qn833w_pnc <- as.factor(as.character(data$qn833w_pnc))
data$qn834w_pnc <- as.factor(as.character(data$qn834w_pnc))
data$qn834aw_pnc <- as.factor(as.character(data$qn834aw_pnc))
data$qn835w_pnc <- as.factor(as.character(data$qn835w_pnc))
data$qn836w_pnc <- as.factor(as.character(data$qn836w_pnc))
data$qn836aw_pnc <- as.factor(as.character(data$qn836aw_pnc))
data$qn837w_pnc <- as.factor(as.character(data$qn837w_pnc))
data$qn901w <- as.numeric(as.character(data$qn901w))
data$qn9id <- as.factor(as.character(data$qn9id))
data$qn903w_anc <- as.numeric(as.character(data$qn903w_anc))
data$qn904w_anc <- as.factor(as.character(data$qn904w_anc))
data$qn905w_anc <- as.numeric(as.character(data$qn905w_anc))
data$qn906w_anc <- as.factor(as.character(data$qn906w_anc))
data$qn907w_anc <- as.factor(as.character(data$qn907w_anc))
data$qn908w_anc <- as.factor(as.character(data$qn908w_anc))
data$qn909w_anc <- as.factor(as.character(data$qn909w_anc))
data$qn910w_anc <- as.factor(as.character(data$qn910w_anc))
data$qn911w_anc <- as.factor(as.character(data$qn911w_anc))
data$qn912w_anc <- as.factor(as.character(data$qn912w_anc))

# # Impute mean for NAs 
# data[is.na(data$qn1009_hhw),]$qn1009_hhw <- mean(data$qn1009_hhw, na.rm = T)
# 
# # Variable analysis
library(dplyr)
source("/Users/stefanobrunelli//Galvanize/Capstone/src/functions.r")

setwd("/Users/stefanobrunelli/Galvanize/Capstone/images")

# Split categorical and quantitative variables as they'll have 2 different categories
# of tests
# cols <- setdiff(colnames(data), "died")
classes <- sapply(data, class)
categorical_vars <- names(classes[classes == "factor"])
quantitative_vars <- setdiff(names(classes[classes != "factor"]), "died")

significance_threshold <- 0.01
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

# #########################################################
# # Run t-tests against quantitative variables
# #########################################################
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

# #########################################################
# # Run deviance tests
# #########################################################
# lapply(chosen_variables, variable_deviance_test)
# 
# #########################################################
# # Run likelihood ratio test
# #########################################################
# likelihood_ratio_test("district_name")
# likelihood_ratio_test("subcounty_name")
# likelihood_ratio_test("parish_name")
# likelihood_ratio_test("qn204_know")
# likelihood_ratio_test("qn209b_know")
# likelihood_ratio_test("qn210_know")
# likelihood_ratio_test("qn211a_know")
# likelihood_ratio_test("qn216_know")
# likelihood_ratio_test("qn217_know")
# likelihood_ratio_test("qn1002_hhw")
# likelihood_ratio_test("shop_village")
# likelihood_ratio_test("qn1009_hhw")
# likelihood_ratio_test("totalshops_village")
# 
# #########################################################
# # Build plots
# #########################################################
# plot_proportions_by_category("district_name")
# plot_proportions_by_category("subcounty_name")
# plot_proportions_by_category("parish_name")
# plot_proportions_by_category("qn204_know")
# plot_proportions_by_category("qn209b_know")
# plot_proportions_by_category("qn210_know")
# plot_proportions_by_category("qn211a_know")
# plot_proportions_by_category("qn216_know")
# plot_proportions_by_category("qn217_know")
# plot_proportions_by_category("qn1002_hhw")
# plot_proportions_by_category("shop_village")
# boxplot(qn1009_hhw ~ as.factor(died), data, col = "cornflowerblue",
#         main = "Death rate distribution: qn1009_hhw",
#         ylab = "Death Rate",
#         xlab = "qn1009_hhw levels")
# boxplot(totalshops_village ~ as.factor(died), data, col = "cornflowerblue",
#         main = "Death rate distribution: qn1009_hhw",
#         ylab = "Death Rate",
#         xlab = "qn1009_hhw levels")


library(scales)
setwd("/Users/stefanobrunelli/Galvanize/Capstone/images")
############################################################
# Plot significant questions at chosen significance level
############################################################
significance_threshold <- 0.1
# Bonferroni correction
# significance_threshold <- significance_threshold / (dim(data)[2]-1)
categorical_tests <- sapply(categorical_vars, chisquare)
quantitative_tests <- sapply(quantitative_vars, ttest)
plt <- rep(0, length(data))
names(plt) <- colnames(data)
colkeepers <- setdiff(names(plt), "died")
plt <- plt[colkeepers]
for (v in names(categorical_tests)) {
plt[v] <- categorical_tests[v]
}
for (v in names(quantitative_tests)) {
plt[v] <- quantitative_tests[v]
}

#png("survey_significance_001.png", res=72)
plot(plt, 
     xlim = c(-5,231), 
     ylim = c(-0.1, 1.05), 
     xaxt = "n", 
     type = "n",
     xlab = "Survey questions (index)",
     ylab = "p-value",
     main = paste("Statistical significance of survey questions to death rate (", 
              round(significance_threshold, digits = 6), " p-value)", sep=""))
points(plt, 
       pch = 20,
       col = alpha(ifelse(plt < significance_threshold, "aquamarine4", "chocolate"), (1-plt)),
       cex = max((3 - 4*plt), 0.5)
       #    cex = ifelse(plt < significance_threshold, 2, .8)
)

abline(h = significance_threshold, lty = 2, col = alpha("red", 0.5))
abline(v = c(5,11,45,70,80,93,143,189,201,215), lty=3, col="grey")
text(-3, -0.1, "Coding", cex=0.5)
text(8, -0.1, "HH", cex=0.5)
text(30, -0.1, "Belief about Health", cex=0.5)
text(50, -0.1, "Malaria", cex=0.5)
text(75, -0.1, "Diarrhea", cex=0.5)
text(86, -0.1, "Food\nFortification", cex=0.5)
text(115, -0.1, "CHP interaction", cex=0.5)
text(160, -0.1, "Post Natal", cex=0.5)
text(195, -0.1, "Ante Natal", cex=0.5)
text(208, -0.1, "HH character.", cex=0.5)
text(225, -0.1, "Village", cex=0.5)
#dev.off()

lapply(chosen_variables, plot_proportions_by_category)
chosen_variables
