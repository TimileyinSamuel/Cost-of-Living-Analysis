############################## COST OF LIVING ANALYSIS ##############################

##### Importing Libraries
library(tidyverse)
library(tidylog)
library(countrycode)
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
##### 1. COST OF LIVING INDEX
### Histogram Distribution Showing Cost of Living Index
ggplot(data = df, mapping = aes(x = cost_of_living_index)) +
  geom_histogram(mapping = aes(y = stat(density)), fill = "#A9A9A9", colour = "#6D6968") +
  geom_density(colour = "blue") +
  scale_x_continuous(breaks = seq(0,200,20), name = "cost of living index") +
  theme(
    plot.background = element_rect(fill = "#FBFAF9"),
    panel.background = element_blank(),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(colour = "black")
  )
### Interpretation
# The histogram showed that the distribution is skewed to the left with the 
# cost of living for most countries falling between 20 and 60. This means that
# many countries are between 20% - 60% cheaper than New York.


### Top 10 countries with highest cost of living
df |> 
  arrange(desc(cost_of_living_index)) |> 
  slice(1:10) |> 
  ggplot(data = _, mapping = aes(x = fct_reorder(.f = country, .x = cost_of_living_index, 
                   .desc = FALSE), y = cost_of_living_index)) +
  geom_col(fill = "#504A4B") +
  geom_text(mapping = aes(x = country, y = cost_of_living_index, label = cost_of_living_index),
            nudge_y = 9, colour = "#000000", fontface = "bold", size = 4.0) +
  scale_y_continuous(name = "Cost of Living Index") +
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


### Bottom 10 countries with lowest cost of living
df |> 
  arrange(cost_of_living_index) |> 
  slice(1:10) |> 
  ggplot(data = _, mapping = aes(x = fct_reorder(.f = country, .x = cost_of_living_index, 
                                                 .desc = FALSE), y = cost_of_living_index)) +
  geom_col(fill = "#504A4B") +
  geom_text(mapping = aes(x = country, y = cost_of_living_index, label = cost_of_living_index),
            nudge_y = 1.5, colour = "#000000", fontface = "bold", size = 3.4) +
  scale_y_continuous(name = "Cost of Living Index") +
  coord_flip() +
  theme(plot.background = element_rect(fill = "#FBFAF9"),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(face = "bold"),
        axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text = element_text(colour = "#000000"),
        axis.text.y = element_text(size = 10, colour = "#000000", face = "bold"),
        text = element_text(colour = "#000000"))


##### 2. RENT INDEX
### Histogram Distribution
ggplot(data = df, mapping = aes(x = rent_index)) +
  geom_histogram(mapping = aes(y = stat(density)), fill = "#A9A9A9", colour = "#6D6968") +
  geom_density(colour = "blue") +
  scale_x_continuous(breaks = seq(0,200,20), name = "rent index") +
  theme(
    plot.background = element_rect(fill = "#FBFAF9"),
    panel.background = element_blank(),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(colour = "black")
  )

### Top 10 countries with highest rent
df |> 
  arrange(desc(rent_index)) |> 
  slice(1:10) |> 
  ggplot(data = _, mapping = aes(x = fct_reorder(.f = country, .x = rent_index, 
                                                 .desc = FALSE), y = rent_index)) +
  geom_col(fill = "#504A4B") +
  geom_text(mapping = aes(x = country, y = rent_index, label = rent_index),
            nudge_y = 6.5, colour = "#000000", fontface = "bold", size = 4.0) +
  scale_y_continuous(name = "Rent Index") +
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

### Bottom 10 countries with lowest rent
df |> 
  arrange(rent_index) |> 
  slice(1:10) |> 
  ggplot(data = _, mapping = aes(x = fct_reorder(.f = country, .x = rent_index, 
                                                 .desc = FALSE), y = rent_index)) +
  geom_col(fill = "#504A4B") +
  geom_text(mapping = aes(x = country, y = rent_index, label = rent_index),
            nudge_y = 0.2, colour = "#000000", fontface = "bold", size = 3.4) +
  scale_y_continuous(name = "Rent Index") +
  coord_flip() +
  theme(plot.background = element_rect(fill = "#FBFAF9"),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(face = "bold"),
        axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text = element_text(colour = "#000000"),
        axis.text.y = element_text(size = 10, colour = "#000000", face = "bold"),
        text = element_text(colour = "#000000"))


##### 3. GROCERIES INDEX
### Histogram Distribution
ggplot(data = df, mapping = aes(x = groceries_index)) +
  geom_histogram(mapping = aes(y = stat(density)), fill = "#A9A9A9", colour = "#6D6968") +
  geom_density(colour = "blue") +
  scale_x_continuous(breaks = seq(0,200,20), name = "groceries index") +
  theme(
    plot.background = element_rect(fill = "#FBFAF9"),
    panel.background = element_blank(),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(colour = "black")
  )

### Top 10 countries with highest groceries
df |> 
  arrange(desc(groceries_index)) |> 
  slice(1:10) |> 
  ggplot(data = _, mapping = aes(x = fct_reorder(.f = country, .x = groceries_index, 
                                                 .desc = FALSE), y = groceries_index)) +
  geom_col(fill = "#504A4B") +
  geom_text(mapping = aes(x = country, y = groceries_index, label = groceries_index),
            nudge_y = 7.7, colour = "#000000", fontface = "bold", size = 4.0) +
  scale_y_continuous(name = "Groceries Index") +
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


### Bottom 10 countries with lowest groceries
df |> 
  arrange(groceries_index) |> 
  slice(1:10) |> 
  ggplot(data = _, mapping = aes(x = fct_reorder(.f = country, .x = groceries_index, 
                                                 .desc = FALSE), y = groceries_index)) +
  geom_col(fill = "#504A4B") +
  geom_text(mapping = aes(x = country, y = groceries_index, label = groceries_index),
            nudge_y = 1.4, colour = "#000000", fontface = "bold", size = 3.4) +
  scale_y_continuous(name = "Groceries Index") +
  coord_flip() +
  theme(plot.background = element_rect(fill = "#FBFAF9"),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(face = "bold"),
        axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text = element_text(colour = "#000000"),
        axis.text.y = element_text(size = 10, colour = "#000000", face = "bold"),
        text = element_text(colour = "#000000"))


##### 4. RESTAURANT PRICE INDEX
### Histogram Distribution
ggplot(data = df, mapping = aes(x = restaurant_price_index)) +
  geom_histogram(mapping = aes(y = stat(density)), fill = "#A9A9A9", colour = "#6D6968") +
  geom_density(colour = "blue") +
  scale_x_continuous(breaks = seq(0,200,20), name = "restaurant price index") +
  theme(
    plot.background = element_rect(fill = "#FBFAF9"),
    panel.background = element_blank(),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(colour = "black")
  )

### Top 10 countries with highest restaurant
df |> 
  arrange(desc(restaurant_price_index)) |> 
  slice(1:10) |> 
  ggplot(data = _, mapping = aes(x = fct_reorder(.f = country, .x = restaurant_price_index, 
                                                 .desc = FALSE), y = restaurant_price_index)) +
  geom_col(fill = "#504A4B") +
  geom_text(mapping = aes(x = country, y = restaurant_price_index, label = restaurant_price_index),
            nudge_y = 7.9, colour = "#000000", fontface = "bold", size = 4.0) +
  scale_y_continuous(name = "Restaurant Price Index") +
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


### Bottom 10 countries with lowest restaurant
df |> 
  arrange(restaurant_price_index) |> 
  slice(1:10) |> 
  ggplot(data = _, mapping = aes(x = fct_reorder(.f = country, .x = restaurant_price_index, 
                                                 .desc = FALSE), y = restaurant_price_index)) +
  geom_col(fill = "#504A4B") +
  geom_text(mapping = aes(x = country, y = restaurant_price_index, label = restaurant_price_index),
            nudge_y = 0.8, colour = "#000000", fontface = "bold", size = 3.4) +
  scale_y_continuous(name = "Restaurant Price Index") +
  coord_flip() +
  theme(plot.background = element_rect(fill = "#FBFAF9"),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(face = "bold"),
        axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text = element_text(colour = "#000000"),
        axis.text.y = element_text(size = 10, colour = "#000000", face = "bold"),
        text = element_text(colour = "#000000"))


##### 5. LOCAL PURCHASING POWER INDEX
### Histogram Distribution
ggplot(data = df, mapping = aes(x = local_purchasing_power_index)) +
  geom_histogram(mapping = aes(y = stat(density)), fill = "#A9A9A9", colour = "#6D6968") +
  geom_density(colour = "blue") +
  scale_x_continuous(breaks = seq(0,200,20), name = "local purchasing power index") +
  theme(
    plot.background = element_rect(fill = "#FBFAF9"),
    panel.background = element_blank(),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(colour = "black")
  )

### Top 10 countries with highest purchasing power
df |> 
  arrange(desc(local_purchasing_power_index)) |> 
  slice(1:10) |> 
  ggplot(data = _, mapping = aes(x = fct_reorder(.f = country, .x = local_purchasing_power_index, 
                                                 .desc = FALSE), y = local_purchasing_power_index)) +
  geom_col(fill = "#504A4B") +
  geom_text(mapping = aes(x = country, y = local_purchasing_power_index, label = local_purchasing_power_index),
            nudge_y = 7.9, colour = "#000000", fontface = "bold", size = 4.0) +
  scale_y_continuous(name = "Local Purchasing Power Index") +
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

### Bottom 10 countries with lowest purchasing power
df |> 
  arrange(local_purchasing_power_index) |> 
  slice(1:10) |> 
  ggplot(data = _, mapping = aes(x = fct_reorder(.f = country, .x = local_purchasing_power_index, 
                                                 .desc = FALSE), y = local_purchasing_power_index)) +
  geom_col(fill = "#504A4B") +
  geom_text(mapping = aes(x = country, y = local_purchasing_power_index, label = local_purchasing_power_index),
            nudge_y = 0.6, colour = "#000000", fontface = "bold", size = 3.4) +
  scale_y_continuous(name = "Local Purchasing Power Index") +
  coord_flip() +
  theme(plot.background = element_rect(fill = "#FBFAF9"),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(face = "bold"),
        axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text = element_text(colour = "#000000"),
        axis.text.y = element_text(size = 10, colour = "#000000", face = "bold"),
        text = element_text(colour = "#000000"))


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

## Spearman rank correlation
cor.test(df$cost_of_living_index, df$local_purchasing_power_index,
         method = "spearman")

###
font_add_google("roboto", family = "roboto")
showtext_auto()


df1 <- df |> 
  select(country, cost_of_living_index, local_purchasing_power_index) |> 
  arrange(desc(cost_of_living_index)) |> 
  slice(1:10)

##
image <- c("https://raw.githubusercontent.com/TimileyinSamuel/Cost-of-Living-and-Purchasing-Power/main/Country/Bermuda.png",
           "https://raw.githubusercontent.com/TimileyinSamuel/Cost-of-Living-and-Purchasing-Power/main/Country/Switzerland.png",
           "https://raw.githubusercontent.com/TimileyinSamuel/Cost-of-Living-and-Purchasing-Power/main/Country/Norway.png",
           "https://raw.githubusercontent.com/TimileyinSamuel/Cost-of-Living-and-Purchasing-Power/main/Country/Iceland.png",
           "https://raw.githubusercontent.com/TimileyinSamuel/Cost-of-Living-and-Purchasing-Power/main/Country/Barbados.png",
           "https://raw.githubusercontent.com/TimileyinSamuel/Cost-of-Living-and-Purchasing-Power/main/Country/Jersey.png",
           "https://raw.githubusercontent.com/TimileyinSamuel/Cost-of-Living-and-Purchasing-Power/main/Country/Israel.png",
           "https://raw.githubusercontent.com/TimileyinSamuel/Cost-of-Living-and-Purchasing-Power/main/Country/Denmark.png",
           "https://raw.githubusercontent.com/TimileyinSamuel/Cost-of-Living-and-Purchasing-Power/main/Country/Bahamas.png",
           "https://raw.githubusercontent.com/TimileyinSamuel/Cost-of-Living-and-Purchasing-Power/main/Country/Singapore.png"
           )

## join to the data
df2 <- cbind(df1, image)
df2

### ggplot
ggplot(data = df2, mapping = aes(y = reorder(country, cost_of_living_index), x = cost_of_living_index)) +
  geom_col(fill = "#A70000", width = 0.4) +
  geom_col(mapping = aes(x = local_purchasing_power_index), fill='#600000', width=0.2) +
  geom_text(mapping=aes(x=cost_of_living_index, label=cost_of_living_index), 
            color = "white", size=3.5, hjust = 0.01) +
  geom_text(mapping=aes(x=0, y=country, label= country), 
            color="white", vjust=-1.4, hjust=0) +
  theme(
    #change background color
    plot.background =element_rect(fill="#191919", color="#191919"),
    panel.background =element_rect(fill="#191919", color="#191919"),
    #modify text font
    text = element_text(color="white", family="Roboto"),
    axis.text = element_text(color="white"),
    axis.title.x = element_text(margin=margin(t=10)),
    axis.text.y = element_blank(),
    plot.subtitle = element_text(color="#DFDFDF", size=12),
    plot.caption = element_text(color="#DFDFDF", size=10),
    plot.title=element_text(family="Roboto", size=30, color="white"),
    #adjust lines for ticks and grid
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    panel.grid.major.x= element_line(color="grey30", size=0.2),
    #add padding around plot
    plot.margin = margin(t=20, b=20, l=20, r=20)
  )

######################################## END ######################################## 


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
######################################## END ######################################## 



######################################### JUNKS ###########################################
### Creating a function to get top 10 countries for each index
## The top and bottom 10 countries is something we will find for all indicators
## Following a key principle of programming "DRY (Do not Repeat), I will create
## a function for this purpose instead of writing the same code every time we 
## need the top or bottom 10
top10 <- function(x) {
  one <- sort(x, decreasing = TRUE)
  one
}

top10(df$cost_of_living_index)


################################## REGIONAL ANALYSIS ##################################
### Add a continent column
df1 <- df |>  
  mutate(region = 
           countrycode(sourcevar = df$country, origin = "country.name", destination = "region")) |>
  select(country, region, everything())

##### ANALYSIS
ggplot(data = df1, mapping = aes(x = region, y = cost_of_living_index, group = region)) +
  geom_col() +
  stat_summary(fun = mean)
### Cost of Living Index, rent_index,cost_of_living_plus_rent_index, groceries_index, 
### restaurant_price_index, local_purchasing_power_index in EACH CONTINENT


df |> 
mutate(across(c(rent_index, groceries_index), round, digits = 1))

mutate(across(c(Sepal.Length, Sepal.Width), round))

colnames(df)

?round


#### Round digits
df2 <- df |> 
  mutate(across(c(cost_of_living_index, rent_index, cost_of_living_plus_rent_index,
                  groceries_index, restaurant_price_index, local_purchasing_power_index), 
                round, digits = 1))


################################ FUNCTIONS ##############################
repeat_plot <- function(x, name) {
  ggplot(data = df, mapping = aes(x = x)) +
    geom_histogram(mapping = aes(y = stat(density)), fill = "#A9A9A9", colour = "#6D6968") +
    geom_density(colour = "blue") +
    scale_x_continuous(breaks = seq(0,200,20), name = "restaurant price index") +
    theme(
      plot.background = element_rect(fill = "#FBFAF9"),
      panel.background = element_blank(),
      panel.grid = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_text(colour = "black")
    )
}
repeat_plot(x = df$rent_index, name = "rent_index")



