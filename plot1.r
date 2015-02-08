
# Working directory
setwd("C:/Users/Graham/Documents/exdata_data_household_power_consumption")

# File Name is:
# Fields in file are: (sep = ;)
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# PART 1:
# The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate 
# of how much memory the dataset will require in memory before reading into R. 
# Make sure your computer has enough memory (most modern computers should be fine).
# Calculate memory to be used
# File size = 126 mb - I approx it will be 315 mb to be held in memory - (file size * 2.5)
# My computer will be fine.

# Reads in file - household_power_consumption.txt
mydata = read.table("household_power_consumption.txt", header = TRUE,sep=';',)  
object.size(mydata)

#Result: 258083544 bytes = 258 mb


#PART 2
# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# I will re-read in only those dates
library(lubridate)

mydata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE,  as.is=TRUE)  
object.size(mydata)
head(mydata)

## Create a new object for date
mydata <- transform(mydata, Date = as.Date(Date, "%d/%m/%Y"))
head(mydata)

# Filter the dates
library(dplyr)
subsetted <- filter(mydata, Date >= as.Date("2007-02-01"), Date < as.Date("2007-02-03"))

remove(mydata)

hist(subsetted$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)") 
