## Exploratory Data Analysis Project 1
## Household Power: Plot 1

##step one: set the working directory: 
setwd("~/Google Drive/Coursera_R_studio/exploratory_data/Project1")

# Get the data: make sure the downloaded data is available
## put it in a file in the local working directory
my.file = "exdata_plotting1.zip"
if (!file.exists(my.file)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net
                         /exdata%2Fdata%2Fhousehold_power_consumpti
                         on.zip", destfile = my.file, method = 
                         "curl")
}

## Reading the data from the contents of the zipped file
df.power = read.csv(unz(my.file, "household_power_consumption.txt"), header=T, sep=";", stringsAsFactors=F, na.strings="?", colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

## Formatting the date 
df.power$Date = as.Date(df.power$Date, format="%d/%m/%Y")

##subseting *grabbing* the data only on 2007-02-01 and 2007-02-02
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")
df.power = df.power[df.power$Date >= startDate & df.power$Date <= endDate, ]

datetime <- paste(as.Date(df.power$Date), df.power$Time)
df.power$datetime <- as.POSIXct(datetime)

## Creating the plot and save it as a .png
png(file = "plot1.png", 
    width = 480, height = 480,
    units = "px", bg = "white")

## Plot 1
hist(df.power$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red", breaks = 12, ylim = c(0, 1200))

dev.off()