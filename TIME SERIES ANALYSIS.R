# Install packages if you don't have them
	

# Load the necessary libraries
library(quantmod)  
library(forecast)  
library(tseries)   
library(ggplot2) 
# Get stock price data for Apple (AAPL) from Yahoo Finance
getSymbols("AAPL", src = "yahoo", from = "2015-01-01", to = "2024-01-01")

# Extract the closing price of the stock
stock_data <- AAPL$AAPL.Adjusted

# Plot the stock price
autoplot(stock_data) + ggtitle("Apple Stock Prices (Adjusted Close)") + 
  ylab("Price") + xlab("Date")

# Check the structure of the data
head(stock_data)

# Summary statistics of stock price
summary(stock_data)

# Plot the stock data to see the trend
plot(stock_data, main="AAPL Stock Price", col="blue", ylab="Price", xlab="Date")

# Decompose the time series
decomposed <- decompose(stock_data)
plot(decomposed)

# Perform Augmented Dickey-Fuller test
adf_test <- adf.test(stock_data, alternative = "stationary")

# Check if the series is stationary
print(adf_test)
# Difference the time series to make it stationary
diff_stock <- diff(stock_data, differences = 1)
plot(diff_stock, main="Differenced Stock Price", col="red")

# Fit the ARIMA model
fit <- auto.arima(stock_data)

# Summary of the model
summary(fit)

# Check residuals of the model
checkresiduals(fit)
# Forecast the next 30 days
forecasted_values <- forecast(fit, h = 30)

# Plot the forecasted values
autoplot(forecasted_values) + ggtitle("AAPL Stock Price Forecast") +
  ylab("Price") + xlab("Date")
# Plot the forecast along with historical data
plot(forecasted_values, main="AAPL Stock Price Forecast", col="green")

# Print forecasted values
print(forecasted_values)
# Calculate accuracy of the model
accuracy(forecasted_values)

  
