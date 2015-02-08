# Working directory
setwd("C:/Users/Graham/Documents/exdata_data_household_power_consumption")

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# I will re-read in only those dates
library(lubridate)
mydata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE,  as.is=TRUE)  

## Create a new object for date and hold the value
mydata$newDate <- mydata$Date
mydata <- transform(mydata, newDate = as.Date(newDate, "%d/%m/%Y"))

# Filter the dates into another object
library(dplyr)
subsetted <- filter(mydata, newDate >= as.Date("2007-02-01"), newDate < as.Date("2007-02-03"))
remove(mydata)

#plot 2 - freq using days
subsetTwo <- subsetted
subsetTwo$unixTime = strptime(paste(subsetTwo$Date, subsetTwo$Time), "%d/%m/%Y %H:%M:%S")


plot(subsetTwo$unixTime, subsetTwo$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab="")
lines(subsetTwo$unixTime, subsetTwo$Global_active_power, col="black", col.lab = "black", col.axis = "black")

dev.copy(png,'plot2.png', width = 480, height = 480)
dev.off()
