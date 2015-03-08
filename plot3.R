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

## change columns 3 - 9 into numeric
for(i in c(3:9)) {data_needed[,i] <- as.numeric(as.character(data_needed[,i]))}

## Combine columns 1 & 2 and form Date_Time
data_needed$Date_Time <- paste(data_needed$Date, data_needed$Time)
data_needed$Date_Time <- strptime(data_needed$Date_Time, format="%Y-%m-%d %H:%M:%S")

## Plot the graph
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(7, 6, 5, 4))
plot(data_needed$Date_Time, data_needed$Sub_metering_1, main = "Plot 3", xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
lines(data_needed$Date_Time, data_needed$Sub_metering_1, col = "black", type = "S")
lines(data_needed$Date_Time, data_needed$Sub_metering_2, col = "red", type = "S")
lines(data_needed$Date_Time, data_needed$Sub_metering_3, col = "blue", type = "S")

## 3 legends on the topright corner of graph
legend("topright", lty = c(1,1), lwd = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()