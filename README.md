# How Expensive is Living in Your Country? An Evaluation of the Global Cost of Living in 2022.


1. Introduction

The year 2022 was a busy one for me in terms of travel due to a number of commitments. I was offered an internship in the bustling policy hub of Washington, and I was undecided as to whether to relocate to the United States or stay in Paris and complete the internship remotely. The thought of the disparity in living costs between the two countries caused me to pause. As a student, I was worried that the cost of living in the United States would be prohibitively expensive. Fortunately, I was able to estimate the monthly costs of renting a room, transportation, dining out, and groceries using various online resources. This influenced not only my final decision, but it also piqued my interest in the topic at hand — a comparison of the costs of living across countries.


2. Basis

For this assignment, I chose to conduct an exploratory analysis of the cost of living in different countries, and below are a few things I was interested in discovering:

1. The most expensive and least expensive countries to live in.

2. The countries with the highest and lowest restaurant, rent, and grocery prices.

3. The countries with the highest and lowest domestic purchasing power.

4. The relationship between living costs and purchasing power.

5. The impact of rent, restaurant prices, and grocery prices on the cost of living.



3. The Dataset

The data was collected by Numbeo in 2022, the largest provider of cost of living data in the world. The data includes indices such as the cost of living (excluding rent), the rent index, groceries, restaurants, the cost of living (including rent), and the local purchasing power.

The indices used in the dataset are relative to New York City (NYC), which means that for New York City, each index should equal 100 (%). If, for instance, another country has a rent index of 120, it indicates that, on average, rents in that country are 20% higher than in New York City. A rent index of 70 indicates that the average rent in a country is 30% lower than in New York City.


3.1 Dataset Description

a) The Cost of Living Index (excluding rent) is a relative measure of the prices of consumer goods, such as groceries, restaurants, transportation, and utilities. It excludes housing costs such as rent or mortgage payments. It is estimated that a city with a Cost of Living Index of 120 is 20% more expensive than New York (excluding rent).

b) The Rent Index is an estimate of the cost of flat rentals across the country relative to New York City. If the rent index is 80, it indicates that, on average, the cost of renting in that country is 20% lower than in New York.

c) The Groceries Index is an estimate of national grocery prices relative to New York City.

d) The Restaurants Index compares the prices of meals and beverages in restaurants and bars across the nation to those in New York City.

e) The Cost of Living Plus Rent Index is a comparison of the prices of consumer goods, including rent, in New York City.

f) Local Purchasing Power Index illustrates the relative purchasing power of a city’s average net salary in a particular country. If domestic purchasing power is $40, then an average salary in that country can afford 60% fewer goods and services than an average salary in New York City.



4. Project Analysis

This project involves the following steps: data cleaning, analysis of individual indicators, examination of the relationship between cost of living and local purchasing power, and regression analysis of the impact of rent, grocery prices, and restaurant prices on cost of living. I then developed an interactive Tableau dashboard that allows users to select a country and view indices for its cost of living, rent, groceries, restaurants, and purchasing power. The R libraries used for regression analysis are the OLSR, jtools, and lmtest packages. To keep this report as short as possible, I will only list a few analysis codes. The complete source code can be found in the GitHub repository.

4.1 Data Cleaning

The data set was examined for missing values and duplicates, but neither were found, which means the data is complete. The column named “rank” was removed because it was unnecessary for the analysis. The column names were renamed to make it easier to identify the columns during the analysis.

Overall View of Dataset


Some general information regarding the dataset is displayed.

<img width="831" alt="Screenshot 2023-01-11 at 13 52 58" src="https://user-images.githubusercontent.com/119361599/224562060-59094028-a06a-4c56-a5dc-69f2062c2099.png">




From the above, there are 139 rows, each representing one of the 139 countries. The mean values for the cost of living, grocery, and restaurant indices range from 43 to 50, indicating that countries are 43–50% less expensive than New York City on average. The Rent Index has a mean value of 19.3, indicating that rent in other countries is 19.3% less expensive than in New York City.

The primary question is whether the mean accurately represents the data. As far as we know, outliers have a significant impact on the mean, which is to be expected in a dataset where some countries are anticipated to have a higher value than others. Examining the standard deviation can help you determine whether the mean adequately explains the data. The standard deviation of each variable ranges between 15 and 26. The standard deviations show how variable the data distribution is. For example, the “Cost of Living Index” has a minimum value of 19.92 and a maximum value of 146.04! The “local purchasing power index” has a range of 1.45 to 118.44. The mean clearly does not adequately describe the distribution.



4.2 Analysis of Individual Indicators
In this section, we will analyze the distribution of each indicator, as well as the most and least expensive countries for each metric.

I. Cost of Living Index (excl. Rent)

a. Cost-of-living Index Distribution Across Countries

To understand how the data for this variable are distributed, the histogram was used to visualize the distribution.

![cost of living](https://user-images.githubusercontent.com/119361599/224562112-8b0e86a2-708b-4a1b-8b7b-bde75ab969c5.png)



The graph depicts a distribution that is skewed to the left. This indicates that the cost of living index (excluding rent) for the majority of countries in the distribution fell between 20 and 80, indicating that the cost of living in the majority of countries was between 20% and 80% lower than in New York.

b. Countries with the highest cost of living (excluding rent)


![top cost of living](https://user-images.githubusercontent.com/119361599/224562138-4d0e5285-a701-4b94-a6e6-526edeb6ec20.png)


The countries with the highest cost of living are Bermuda (46% more expensive than New York City), Switzerland (23% more expensive than New York City), Norway, Iceland, Barbados, Jersey, Israel, Denmark, the Bahamas, and Singapore.

c. Countries with the lowest cost of living

![bottom cost of living](https://user-images.githubusercontent.com/119361599/224562177-a03f1d5b-bab5-4c34-8771-99631fd6e5c4.png)


The cheapest places to live are Pakistan (which is 80% cheaper than New York City), Afghanistan, India, Colombia, Algeria, Kosovo, Uzbekistan, Tunisia, Nepal, and Turkey. Each of the top 10 countries is at least 70% less expensive than New York.

II. Which countries offer the cheapest and most expensive rental rates?

![rent index](https://user-images.githubusercontent.com/119361599/224562272-2db7eeae-de51-4418-8d52-be4e76105cad.png)


Many countries have rent prices that are less than 40, implying that they are at least 40% less expensive than New York.

a. Countries with the highest rent

![top rent](https://user-images.githubusercontent.com/119361599/224562224-b46a9309-70de-46f9-a3bd-6a2efe17061d.png)


The countries with the highest rental costs are Bermuda, Hong Kong, Singapore, Jersey, Luxembourg, Guernsey, Switzerland, Qatar, the United Arab Emirates, and Macao.

b. Countries with the lowest rent


![bottom rent](https://user-images.githubusercontent.com/119361599/224562233-cc013a55-8df7-4ecf-929c-4fe6d8dab3a5.png)



Afghanistan, Pakistan, Nepal, Bangladesh, Algeria, Somalia, Syria, India, Tunisia, and Egypt have the lowest rental costs. These countries offer accommodations that are at least 94% less expensive than New York.

III. Where are the most and least expensive places to buy groceries?

![groceries index](https://user-images.githubusercontent.com/119361599/224562299-d703a4af-4c3a-4e3e-aec6-b43abb4db5ab.png)



In many countries, food prices are typically approximately 20% to 80% less expensive than in New York.

a. Countries with the highest grocery prices

![top groceries](https://user-images.githubusercontent.com/119361599/224562313-f9d72137-7edf-4ee3-9aa1-0b5b4fbbb155.png)


The countries with the highest food and beverage prices are Bermuda, Switzerland, Norway, South Korea, Iceland, Barbados, Hong Kong, Japan, Australia, and Singapore.

b. Countries with the lowest grocery prices

![Bottom groceries](https://user-images.githubusercontent.com/119361599/224562318-766aa781-56f0-432e-b7d3-d6ff4724d4fc.png)


The countries with the cheapest food prices are Afghanistan, Pakistan, Turkey, Colombia, Kosovo, Moldova, Kazakhstan, Paraguay, and Ukraine.

IV. In which countries are restaurant meals the most and least expensive?

![restaurant_price_index](https://user-images.githubusercontent.com/119361599/224562346-ac1cc82c-668f-4bc0-be3a-d254861296a7.png)


The distribution is skewed to the left, with the majority of countries falling between 20 and 60.

a. Countries with the highest restaurant price

![top restaurant](https://user-images.githubusercontent.com/119361599/224562362-80ad2c81-4d1c-42df-bda7-d5b83461aaa8.png)


Bermuda, Switzerland, Norway, Iceland, Denmark, Israel, Jersey, Guernsey, the Bahamas, and Luxembourg are among the ten countries with the priciest restaurants.

b. Countries with the lowest restaurant price

![Bottom restaurant](https://user-images.githubusercontent.com/119361599/224562378-1d38d21b-ab02-41a4-844d-9f7a4224db14.png)


Afghanistan, Algeria, Pakistan, Tunisia, Sri Lanka, India, Indonesia, Ethiopia, Turkey, and Colombia have among the lowest restaurant prices in the world.

V. Local Purchasing Power Index

![local_purchasing_power_index](https://user-images.githubusercontent.com/119361599/224562385-9ded4b0b-9b61-4417-a48c-b030ae88c4ed.png)


a. Countries with the highest purchasing power

![top purchasing power](https://user-images.githubusercontent.com/119361599/224562402-9a7608c8-903e-46d1-aab4-ff50d0374b4b.png)



In terms of purchasing power, the United States, Switzerland, Australia, Germany, Denmark, Luxembourg, Sweden, Qatar, the United Arab Emirates, and Saudi Arabia are among the top ten countries.

b. Countries with the lowest purchasing power

![Bottom purchasing power](https://user-images.githubusercontent.com/119361599/224562406-a48dac01-4186-46f9-b1cc-1b00979ecefc.png)


Cuba, Syria, the Ivory Coast, Nigeria, Ethiopia, Uganda, Cambodia, Suriname, Myanmar, and Yemen have the world’s highest and lowest prices, respectively.

4.3 Cost of Living and Local Purchasing Power Indicator
Examining only the cost of living in different countries can create the false impression that some are more or less expensive than others. However, this does not tell the whole story unless the purchasing power of the country in question is considered. A country may have a high cost of living but a high purchasing power, giving the impression that it is less expensive than it actually is. Similarly, a country may appear to have a low cost of living, but it may also have a low purchasing power, making it less affordable to live in than was previously believed. Therefore, let’s investigate the relationship between these two factors using a correlation analysis.

Correlation Analysis between Cost of Living and Purchasing Power

To achieve this, the Pearson correlation is my preferred method. However, this is contingent on meeting certain assumptions. These assumptions include the normal distribution of variables and the absence of outliers.

The local cost of living and purchasing power are both skewed to the left based on a preliminary examination of the variables using the previously displayed histogram. In other words, their distribution is not normal, which is necessary for the Pearson correlation analysis. The Shapiro-Wilk test could be used to provide additional evidence.


<img width="437" alt="Screenshot 2023-01-16 at 14 38 59" src="https://user-images.githubusercontent.com/119361599/224562449-f80cd178-b6e5-4746-abf4-f50d3637fa15.png">



Neither of the two variables is normally distributed. The Pearson correlation, however, can still be used for this purpose due to the central limit theorem. Spearman’s rank correlation can also be used if normality is not assumed. For this, I used the Pearson correlation and the central limit theorem. I also ran a Spearman rank correlation to see if there were any differences.

<img width="593" alt="Screenshot 2023-01-16 at 14 42 57" src="https://user-images.githubusercontent.com/119361599/224562489-b73b2505-9301-4e29-a6bf-47a513cee7bf.png">


As a result, the local cost of living and purchasing power have a strong positive correlation. When one variable rises, the other tends to rise as well. Countries with high living costs typically have high purchasing power, and vice versa.

The Spearman correlation coefficient yields a similar result.

4.4 How do specific variables contribute to the cost of living? What is the relationship between the cost of living and factors like rent, restaurants, and groceries?

How do indicators such as rent, restaurant prices, and grocery prices affect the overall cost of living? To investigate this, I used multiple linear regression to determine the contribution of each variable to the cost of living. Prior to performing the regression analysis, the assumptions of multicollinearity, homoscedasticity, linearity, and normality were validated using the appropriate tests.


As expected, the rent index, the grocery index, and the restaurant price index all have a statistically significant impact on the cost of living. The rent index has the greatest impact on the cost of living (51% of the total contribution to the cost of living index). As rent increases by a factor of 1, the cost of living changes by a factor of 0.5. Following this is the grocery index (31% contribution). The restaurant price index contributes the remaining 17%.

Summary of Findings
1. In terms of overall cost of living, Bermuda, Switzerland, Norway, Iceland, Barbados, Jersey, Israel, Denmark, the Bahamas, and Singapore are the most expensive places to live.

2. Bermuda has the highest overall cost of living index, which includes rent, grocery, and restaurant prices. The country’s heavy reliance on imports may be a contributing factor. The country imports gasoline, groceries, and clothing. The island is also renowned for not taxing anything other than imports.

3. In terms of overall cost of living, Pakistan, Afghanistan, India, Colombia, Algeria, Kosovo, Uzbekistan, Tunisia, Nepal, and Turkey were the cheapest countries to live in.

4. The relationship between the cost of living and local purchasing power is strong. In general, countries with high living costs have high purchasing power, and vice versa.

5. The rent contributed the most to the overall cost of living, followed by grocery and restaurant prices.



