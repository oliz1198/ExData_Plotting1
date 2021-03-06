#load data
#file downloaded and unzipped as "household.txt"
#load only the rows corresponding to 2/1/07 to 2/2/07
data <- read.table("household.txt", header = FALSE, sep = ";", 
                   skip=grep("1/2/2007", readLines("household_power_consumption.txt")), 
                   nrows = 2879)
#first row is missing, add this row
row1 <- list("1/2/2007", "00:00:00", 0.326, 0.128, 243.150, 1.400,
             0.000, 0.000, 0.000)
hhdf <- rbind(row1, data)
#add the right header
read_header <- read.table("household.txt", header = TRUE, sep = ";", 
                          nrows = 2)
names(hhdf) <- names(read_header)

#convert dates & times
hhdf$Date <- as.Date(hhdf$Date, format = "%d/%m/%Y")
Date_Time <- paste(hhdf$Date, hhdf$Time)
Date_Time <- strptime(Date_Time, format = "%Y-%m-%d %H:%M:%S", tz = "gmt")
hhdf <- cbind(Date_Time, hhdf[,3:9])


#plot 4
png(filename = "plot4.png") #opens PNG device
par(mfcol = c(2,2)) #initiates matrix of plots
plot(hhdf$Date_Time, hhdf$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
plot(hhdf$Date_Time, hhdf$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(hhdf$Date_Time, hhdf$Sub_metering_2, col = "red")
lines(hhdf$Date_Time, hhdf$Sub_metering_3, col = "blue")
legend("topright", legend = names(hhdf)[6:8], lty = 1, bty = "n", 
       col = c("black", "red", "blue"))
plot(hhdf$Date_Time, hhdf$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(hhdf$Date_Time, hhdf$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")

dev.off() #closes PNG device