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
head(subsetTwo)

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

#plot 1
hist(subsetted$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)") 

#plot 2
plot(subsetTwo$unixTime, subsetTwo$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab="")
lines(subsetTwo$unixTime, subsetTwo$Global_active_power, col="black", col.lab = "black", col.axis = "black")

#plot 3
plot(c(subsetTwo$unixTime,subsetTwo$unixTime,subsetTwo$unixTime), c(subsetTwo$Sub_metering_1,subsetTwo$Sub_metering_2,subsetTwo$Sub_metering_3), type = "n", ylab = "Global Active Power (kilowatts)", xlab="")
lines(subsetTwo$unixTime, subsetTwo$Sub_metering_1, col="black")
lines(subsetTwo$unixTime, subsetTwo$Sub_metering_2, col="red")
lines(subsetTwo$unixTime, subsetTwo$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black", "red", "blue"))

#plot 4
plot(subsetTwo$unixTime, subsetTwo$Global_reactive_power, type = "n", ylab = "Global_reactive_power", xlab="datetime")
lines(subsetTwo$unixTime, subsetTwo$Global_reactive_power, col="black")

dev.off()
