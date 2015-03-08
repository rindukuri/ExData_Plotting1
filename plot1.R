## set currenct directory as working directory
setwd("./")

## load following libraries
library(downloader)
library(data.table)

## get source file from provided URL and read into variable "data"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
url_file <- "household_power_consumption"
download(url, dest=url_file, mode="wb")
workdir <- getwd()
unzip (url_file, exdir = workdir)
data <- fread("household_power_consumption.txt")

## Identify the data for dates "2007-02-01" & "2007-02-02"
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data_needed <- data.frame(data[data$Date=="2007-02-01" | data$Date=="2007-02-02"])

## change columns 3 to 9 from character to numeric
for(i in c(3:9)) {data_needed[,i] <- as.numeric(as.character(data_needed[,i]))}

## Plot graph
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))
hist(data_needed$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
dev.off()