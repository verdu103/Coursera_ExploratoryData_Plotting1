## Exploratory df.power Analysis Project 1
## Household Power: Plot 4
##step one: set the working directory: 
setwd("~/Google Drive/Coursera_R_studio/exploratory_data/Project1")

# Get the data: make sure the downloaded data is available
## put it in a file in the local working directory
my.file = "exdata_plotting1.zip"
if (!file.exists(my.file)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = my.file, method = "curl")
}

## Reading the data from the contents of the zipped file
df.power = read.csv(unz(my.file, "household_power_consumption.txt"), header=T, sep=";", stringsAsFactors=F, na.strings="?", colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Below we only need data from two days
## Formatting the date and time and subseting the data only on 2007-02-01 and 2007-02-02
## Formatting the date 
df.power$Date = as.Date(df.power$Date, format="%d/%m/%Y")

##subseting *grabbing* the data only on 2007-02-01 and 2007-02-02
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")
df.power = df.power[df.power$Date >= startDate & df.power$Date <= endDate, ]

datetime <- paste(as.Date(df.power$Date), df.power$Time)
df.power$datetime <- as.POSIXct(datetime)

## Creating the Plot 4
## Create png file for Plot 4
png(file = "plot4.png", 
    width = 480, height = 480,
    units = "px", bg = "white")

## Create the grids for the four plots required 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## Top-left
plot(df.power$datetime, df.power$Global_active_power, 
     type = "l",
     xlab = "", ylab = "Global Active Power")
## Top-right
plot(df.power$datetime, df.power$Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage")
## Bottom-left
plot(df.power$datetime, df.power$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(df.power$datetime, df.power$Sub_metering_2, col = "red")
lines(df.power$datetime, df.power$Sub_metering_3, col = "blue")
# Remove the border of legend here.
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
## Bottom-right
plot(df.power$datetime, df.power$Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()