start_datetime <- grep("^1/2/2007", readLines('household_power_consumption.txt')) - 1

## Adjust for presence of the header
start_datetime <- start_datetime - 1

## Number of minutes in two days
two_days_min <- 2*24*60

hpc <- read.csv("household_power_consumption.txt",
                header = TRUE,
                skip=start_datetime,
                nrow=two_days_min,
                sep=";", 
                colClasses = c('character',
                               'character',
                               'numeric',
                               'numeric',
                               'numeric',
                               'numeric',
                               'numeric',
                               'numeric',
                               'numeric'),
                na.strings="?",
                stringsAsFactors=FALSE)

## Add the column names which were skipped during the file read.
names(hpc) <- c('Date', 
                'Time', 
                'Global_active_power', 
                'Global_reactive_power',
                'Voltage', 
                'Global_intensity', 
                'Sub_metering_1', 
                'Sub_metering_2', 
                'Sub_metering_3')

## Combine Date, Time columns into datetime
hpc$datetime <- as.POSIXct(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")

## Plot of Global Active Power v. DateTime
plot(hpc$datetime, hpc$Global_active_power,
     col='black',
     main='',
     ylab='Global Active Power (kilowatts)',
     xlab='',
     type='l')

## Plot of Sub_metering_1 v. DateTime
plot(hpc$datetime, hpc$Sub_metering_1,
     col='black',
     main='',
     ylab='Energy sub metering',
     xlab='',
     type='l')

## Overlay sub_metering_2
lines(hpc$datetime, hpc$Sub_metering_2,
       col='red')
       
## Overlay sub_metering_3
lines(hpc$datetime, hpc$Sub_metering_3,
       col='blue')

## Customize the text width to prevent truncation.
legend("topright",
  legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
  col=c('black', 'red', 'blue'),
  lty=1,
  text.width=1.8*strwidth("Sub_metering_1"))
