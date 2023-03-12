############################## COST OF LIVING ANALYSIS ##############################

##### Importing Libraries
library(tidyverse)
library(tidylog)
library(showtext)

##### adding fonts
font_add_google("Montserrat", family = "Montserrat")
showtext_auto()

##### Importing Data set
df <- read_csv("./Cost_of_Living_Index_2022.csv") |> 
  janitor::clean_names()

##### Data Checking and Cleaning
### Removing unnecessary column (the rank column is removed as it just numbers the country in
##  alphabetical order)
df <- df |> 
  select(-rank)
# The variable 'rank' has been dropped

##### Checking the data set
skimr::skim(df)
### There are 7 variables: country, cost_of_living_index, rent_index, 
### cost_of_living_plus_rent_index, groceries_index, restaurant_price_index,
### local_purchasing_power_index. There are 139 countries. There are no missing
### values for any variable. The data is in good shape.

#### Finding basic descriptive statistics
### The standard deviation varies which shows that the scores are spread out from the mean
summary(df)
### For 'Cost of Living Index', 'Groceries Index', and 'Restaurant Price Index' 
##  mean value is between 43 and 50, so on average world 
## countries are 43-50% cheaper to live than the city of New York.

### 'Rent Index' mean value, however, is 19.2, so on average rent in New York 
## is 80% more expensive than in many countries;

### Data is varied greatly. For example, 'Cost of Living Index' minimum value is 
## just 19.92,while its maximum is 146.04! And for 'Local Purchasing Power Index' 
## values vary from 1.45 to 118.44. A look at the standard deviation can help get a 
## better look at this.


###################################### ANALYSIS ######################################

################################## INDIVIDUAL INDICATORS ##################################
#################################### ## CREATING FUNCTIONS ##################################
### A lot of the plots here will be repeated for every indicator. 
## In order to avoid repeating the same sets of code, 
## I create functions for these purposes

### Function 1
### Creating a function that plots histogram for every indicator
histogram_plot_function <- function(x, axis_name) {
  ggplot(data = df, mapping = aes(x = x)) +
    geom_histogram(mapping = aes(y = stat(density)), fill = "#A9A9A9", colour = "#6D6968") +
    geom_density(colour = "blue") +
    scale_x_continuous(breaks = seq(0,200,20), name = axis_name) +
    theme(
      plot.background = element_rect(fill = "#FBFAF9"),
      panel.background = element_blank(),
      panel.grid = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_text(colour = "black")
    )
}

### Function 2
### Creating a function that extracts the top 10 countries based on the indicator provided
top10 <- function(data, var) {
  slice(arrange(df, desc(cost_of_living_index)),1:10)
}
top10(df, df$cost_of_living_index)

### Function 3
### Creating a function that extracts the bottom 10 countries based on the indicator provided
bottom10 <- function(data, var) {
  slice(arrange(df, cost_of_living_index),1:10)
}
bottom10(df, df$cost_of_living_index)

### Function 4
### Creating a function that plots bar chart for top 10 countries
bar_chart_function <- function(data, y, axis_name) {
  ggplot(data = data, mapping = aes(x = country, y = y)) +
    geom_col(fill = "#504A4B") +
    geom_text(mapping = aes(x = country, y = y, label = y),
              nudge_y = 9, colour = "#000000", fontface = "bold", size = 4.0) +
    scale_y_continuous(name = axis_name) +
    coord_flip() +
    theme(plot.background = element_rect(fill = "#FBFAF9"),
          panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.title.y = element_blank(),
          axis.title.x = element_text(face = "bold"),
          axis.ticks.y = element_blank(),
          axis.ticks.x = element_blank(),
          axis.text = element_text(colour = "#000000"),
          axis.text.y = element_text(size = 11, colour = "#000000", face = "bold"),
          text = element_text(colour = "#000000"))
}

bar_chart_function(data = dt, y = dt$cost_of_living_index, axis_name = "cost of living")


### These functions will now be used in the analysis

#### 1. COST OF LIVING INDEX

### Histogram Distribution Showing Cost of Living Index
histogram_plot_function(x = df$rent_index, axis_name = "cost of living index")

### Interpretation
# The histogram showed that the distribution is skewed to the left with the 
# cost of living for most countries falling between 20 and 60. This means that
# many countries are between 20% - 60% cheaper than New York.

### Top 10 countries with highest cost of living
topcli <- top_10(df, df$cost_of_living_index) 

bar_chart_function(data = topcli, x = topcli$country, y = topcli$cost_of_living_index, 
                   axis_name = "cost of living")

### Bottom 10 countries with lowest cost of living
bottomcli <- bottom10(df, df$cost_of_living_index) 

bar_chart_function(data = bottomcli, x = bottomcli$country, y = bottomcli$cost_of_living_index, 
                   axis_name = "cost of living index")


##### 2. RENT INDEX
### Histogram Distribution using the function created earlier
histogram_plot_function(x = df$rent_index, axis_name = "rent index")



##### 3. GROCERIES INDEX
### Histogram Distribution
histogram_plot_function(x = df$rent_index, axis_name = "groceries index")



##### 4. RESTAURANT PRICE INDEX
### Histogram Distribution
histogram_plot_function(x = df$rent_index, axis_name = "restaurant price index")




##### 5. LOCAL PURCHASING POWER INDEX
### Histogram Distribution
histogram_plot_function(x = df$rent_index, axis_name = "local purchasing power index")

### Top 10 countries with highest purchasing power

### Bottom 10 countries with lowest purchasing power


###################### COST OF LIVING AND LOCAL PURCHASING POWER INDEX COMPARISON
### The big question is: how do the top and bottom countries compare when the 
## local purchasing power is considered together with the cost of living

##### correlation between cost of living and local purchasing power 
#### checking assumptions of a Pearson Correlation 
## Normality Test
shapiro.test(df$cost_of_living_index)
shapiro.test(df$local_purchasing_power_index)

## Both figures are less than 0.05 which means they are not normally distributed
## Nevertheless, the central limit theorem (CLM) still permits the use of Pearson Correlation

## Pearson correlation
cor.test(df$cost_of_living_index, df$local_purchasing_power_index)

## Spearman rank correlation (for comparison with Pearson correlation)
cor.test(df$cost_of_living_index, df$local_purchasing_power_index,
         method = "spearman")


################################## INFERENTIAL ANALYSIS ##################################
### What factors tend to contribute to cost of living?
### Relationship between cost of living and factors like rent, restaurant, groceries?
### Linear regression (What factors can explain the cost of living? rent, 
# groceries, restaurant?)

#### Testing Assumptions
library(olsrr)
library(jtools)
library(moments)
library(lmtest)

### ASSUMPTIONS
### Homoscedasticity
### Using Breusch Pagan Test
ols_test_breusch_pagan(reg_output)
## Assumption not met

### Normality of Residuals
## Using Shapiro-Wilk
shapiro.test(reg_output$residuals)
## Assumption met

### Linearity  between DV and IV
## Using Rainbow Test
raintest(reg_output)
## assumption met

### Absence of strong multicolinearity
ols_vif_tol(reg_output)
## no values above ten, so assumption met

### Outliers
## Using Cook's Distance
ols_plot_cooksd_chart(reg_output)


#### Regression
reg_output <- lm(cost_of_living_plus_rent_index ~ rent_index + groceries_index 
                 + restaurant_price_index, data = df)

reg_output

summ(reg_output, confint = TRUE, ci.width = 0.95, digits = 3)

########################################## END ############################################## 
