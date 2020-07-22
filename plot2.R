#load data
#load only the rows corresponding to 2/1/07 to 2/2/07 from downloaded and unzipped file
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


#plot 2
png(filename = "plot2.png") #open png device
plot(hhdf$Date_Time, hhdf$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

dev.off() #close PNG device
