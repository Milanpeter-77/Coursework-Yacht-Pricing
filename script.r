# Econometrics I. - Teamwork
library(readr)
library(broom)
library(lmtest)
library(ggplot2)
library(car)

rm(list=ls())


yacht_pricing <- read_delim("yacht_pricing.csv", delim = ";", 
                              quote = "\\\"", escape_double = FALSE, 
                              locale = locale(decimal_mark = ",", grouping_mark = ".", 
                                              encoding = "ISO-8859-2"), trim_ws = TRUE)


View(yacht_pricing) #removed width and depth variables because of multicollinearity

summary(yacht_pricing)

yacht_pricing$boat_type <- as.factor(yacht_pricing$boat_type)
yacht_pricing$condition <- as.factor(yacht_pricing$condition)

# remove outlier values out of condition
yacht_pricing <- subset(yacht_pricing, condition!="for tinkers" & condition!="to be done up")
yacht_pricing <- subset(yacht_pricing, condition!="for tinkers" & condition!="to be done up" & condition!="used" )
yacht_pricing$condition <- as.factor(yacht_pricing$condition)

model1 <- lm(price_eur ~., data=yacht_pricing) #first, full model
summary(model1) #model diagnostics: R^2, Adj R^2, F-test

write.csv(tidy(model1), "coefs.csv")

resettest(model1) #Reset test
hist(yacht_pricing$price_eur) #transform to be logarithmic

model2 <- lm(log(price_eur) ~., data=yacht_pricing)
summary(model2)
AIC(model1,model2)
resettest(model2)

ggplot(data = yacht_pricing, aes(x = length_m, y = log(price_eur))) +
  geom_point() +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) + 
  labs(title = "Fit", x = "Yacht length (m)", y = "Price (log euro)") +
  stat_smooth(color="red") 

model3 <- lm(log(price_eur)~.+ I(length_m^2),data=yacht_pricing)
summary(model3)
AIC(model2, model3)
resettest(model3)

ggplot(data = yacht_pricing, aes(x = displacement_kg, y = log(price_eur), color = condition)) +
  geom_point() +
  stat_smooth(method=lm) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) + 
  labs(title = "Interaction", x = "Displacement (kg)", y = "Price (log euro)") +
  scale_fill_brewer("Condition")

modeli <- lm(log(price_eur)~.+ I(length_m^2) + condition*displacement_kg,data = yacht_pricing)
summary(modeli)
AIC(model3, modeli)
BIC(model3, modeli)
resettest(modeli)

vif(model3)
summary(model3)

model5 <- lm(log(price_eur)~.+ I(length_m^2) + condition*displacement_kg - boat_type,data=yacht_pricing)
summary(model5)

model6 <- lm(log(price_eur)~.+ I(length_m^2) + condition*displacement_kg - boat_type - displacement_kg - certified_number_of_people - number_of_beds - number_of_cabins  - engine_hours_h,data = yacht_pricing)
summary(model6)

AIC(model5,model6)
BIC(model5,model6)
anova(model5, model6)

model7 <- lm(log(price_eur)~.+ I(length_m^2) + condition*displacement_kg - boat_type - displacement_kg - number_of_beds - certified_number_of_people -number_of_cabins -engine_hours_h - condition,data=yacht_pricing)
summary(model7)
AIC(model6,model7)
BIC(model6,model7)
anova(model6,model7)


resettest(model6)
vif(model7)


modelj <- lm(log(price_eur)~.+ I(length_m^2)- boat_type - displacement_kg - number_of_beds - engine_hours_h + I(year_built^2) + I(fuel_capacity_l^2) + condition*displacement_kg,data = yacht_pricing)
summary(modelj)
resettest(modelj)
AIC(model6, modelj)
BIC(model6,modelj)

vif(model6)
