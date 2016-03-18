######################################################
## Coursera: Exploratory Data Analysis, wk 1 Assignment
##
## The overall goal here is simply to examine how household energy usage 
## varies over a 2-day period in February, 2007. Your task is to reconstruct 
## plots as defined in the full instructions, all of which were constructed 
## using the base plotting system.

## This assignment uses data from the UC Irvine Machine Learning Repository, 
## a popular repository for machine learning datasets. In particular, we will 
## be using the "Individual household electric power consumption Data Set" which 
## I have made available on the course web site:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip [20Mb]
## 
## Description: Measurements of electric power consumption in one household with a 
## one-minute sampling rate over a period of almost 4 years. Different electrical 
## quantities and some sub-metering values are available.
## The following descriptions of the 9 variables in the dataset are taken from the 
## UCI web site:
## 1.	Date: Date in format dd/mm/yyyy
## 2.	Time: time in format hh:mm:ss
## 3.	Global_active_power: household global minute-averaged active power (in kilowatt)
## 4.	Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
## 5.	Voltage: minute-averaged voltage (in volt)
## 6.	Global_intensity: household global minute-averaged current intensity (in ampere)
## 7.	Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds 
##    to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are 
##    not electric but gas powered).
#  8.	Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds 
##    to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and 
##    a light.
## 9.	Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds
##    to an electric water-heater and an air-conditioner.



## setting up a variable for the original working directory 
owd <- getwd()

## Settint up a data directory under the Working directory
if(!file.exists("power")) {
      dir.create("power")
}
setwd("./power")
## setwd("C:/Users/Austin/Desktop/Analytics Programs/Coursera/EDA/Week 1/power")

## setting an internet file path variable and downloading the COmmunity Survet data
## to the new working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./power.zip", 
              method = "auto")
list.files()

datedownloaded <- date() ## [1] "Wed Mar 16 20:33:37 2016"
datedownloaded



## collecting a sample of the data to establish the column classes to speed up loading
## however, this does not seem to work for the read.csv.sql() function so really not used here
sample_data <- read.table(unzip("power.zip"), nrows=10, 
                          header=T, quote="\"", sep=";")
str(sample_data)
col_class <- lapply(sample_data, class)
unlink(col_class)

## unzipping the entire file to prepare for extracting the defined date subset

## would be best to extract the .txt file name into a variable and used in the 
## read.csv function
unzip("power.zip")
list.files()

## extracting a sub set of the power data from the dates 2007-02-01 and 2007-02-02 i.e. 2 days
## using the sqldf package to implant an sql statement for the date range. the goal is to 
## prevent loading the entire power data text file which has more than 2M lines.
##
library(sqldf)

## cant seem to figure out the sql statement for OR a range so getting two data frames 
## that can be row bound
power_data_1 <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
                  sql = "select * from file where Date = '1/2/2007' ")

power_data_2 <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
                  sql = "select * from file where Date = '2/2/2007' ")

## row binding the two data frames
library(dplyr)

power_data <- bind_rows(power_data_1, power_data_2)
str(power_data)




