# Coursework - Yacht Pricing
In this analysis, we examined the factors influencing yacht and motorboat pricing, using the "yacht_pricing" dataset. The primary goal was to build a regression model in R to explain the prices of yachts (in euros) based on various characteristics, including boat type, year built, condition, length, displacement, number of cabins and beds, fuel capacity, and engine hours.

Our dataset contained 311 observations. After loading it into R, we transformed certain variables, such as boat type and condition, into factors due to their categorical nature. We removed some predictors, like boat width and depth, due to multicollinearity issues, as length sufficiently represented the boat’s dimensions.

Model diagnostics were conducted to evaluate the significance of each predictor. Key significant variables included yacht type (specifically "Mega Yacht"), year built, condition (e.g., "very good" or "good" relative to "as new"), length, number of cabins, and fuel capacity. The model's goodness-of-fit was assessed using the R² and adjusted R², where the initial R² was 84.12%, suggesting a strong explanatory power.

Further tests, including the global F-test and the Ramsey-RESET test, helped assess model specification and the necessity for additional transformations. To address specification issues, we log-transformed the price variable, which improved the model fit and reduced skewness in the price distribution.

Our final model was a refined version that accounted for multicollinearity and specification errors, enabling a more accurate and interpretable analysis of the factors influencing yacht pricing.

**Disclaimer**: This analysis was conducted as part of a team project for the university course *Econometrics I*. Please note that, due to academic integrity policies, the full documentation for this project cannot be uploaded or shared.
