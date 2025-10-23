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

# Construct plot
data_plot$Time <- as.POSIXct(paste(data_plot$Date, data_plot$Time))
plot(data_plot$Time, as.numeric(data_plot$Sub_metering_1), type = "l", xlab="", ylab="Energy sub metering",  main="")
points(data_plot$Time, as.numeric(data_plot$Sub_metering_2), type = "l", xlab="", ylab="Energy sub metering",  main="", col="red")
points(data_plot$Time, as.numeric(data_plot$Sub_metering_3), type = "l", xlab="", ylab="Energy sub metering",  main="", col="blue")
legend("topright", lwd = 1, col=c("black", "blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.7, y.intersp = 0.3)

# Copy to file
dev.copy(png, file="Plot3.png", width = 480, height = 480, units = "px")
dev.off()
