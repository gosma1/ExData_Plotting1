# Ensure that LC is English so the month can be chosen correctly
Sys.setlocale("LC_TIME", "English")

# Required to obtain year
library(lubridate)

#Read file to a dataframe
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".", na.strings = "?")

# Transform variables into dates & times
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")


# Subset the data to be plotted
data_plot<-subset(data,months(data$Date) == "February" & year(data$Date) == 2007 & day(data$Date) <3)
data_plot$Time <- as.POSIXct(paste(data_plot$Date, data_plot$Time))
data_plot$Global_reactive_power <- as.numeric(data_plot$Global_reactive_power)
# Construct plot
par(mfrow=c(2,2))

# Fist Row, First column
plot(data_plot$Time, as.numeric(data_plot$Global_active_power), type = "l", xlab="", ylab="Global Active Power (kilowatts)",  main="")

# Fist Row, Second column
plot(data_plot$Time, as.numeric(data_plot$Voltage), type = "l", xlab="datetime", ylab="Voltage",  main="")

# Second Row, First column
plot(data_plot$Time, as.numeric(data_plot$Sub_metering_1), type = "l", xlab="", ylab="Energy sub metering",  main="")
lines(data_plot$Time, as.numeric(data_plot$Sub_metering_2), type = "l", xlab="", ylab="Energy sub metering",  main="", col="red")
lines(data_plot$Time, as.numeric(data_plot$Sub_metering_3), type = "l", xlab="", ylab="Energy sub metering",  main="", col="blue")
legend("topright", lwd = 1, col=c("black", "blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),  cex = 0.7, y.intersp = 0.1, bty = "n", inset = c(0.02, -0.08))

# Second Row, Second column
with(data_plot, plot(Time, Global_reactive_power, type = "l", xlab="datetime",  main=""))

# Copy to file
dev.copy(png, file="Plot4.png", width = 480, height = 480, units = "px")
dev.off()
