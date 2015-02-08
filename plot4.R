
#Here we read two sets: Set of col names and chunk of data that contains two needed days
names1 <-read.table("household_power_consumption.txt",sep=";", na.strings ="?", nrows=1,stringsAsFactors=F)
megadata<-read.table("household_power_consumption.txt",sep=";", na.strings ="?", nrows=10000,skip=63200,stringsAsFactors=F)

#Merge and transform date and time from character to data type for easy subsetting and plotting
megadata$V1 <-paste(megadata$V1, megadata$V2)
megadata$V1<-strptime(megadata$V1, "%d/%m/%Y %H:%M:%S")

#Subsetting only two needed days
workset <-subset(megadata,megadata$V1>"2007-01-31 23:59:00" & megadata$V1<"2007-02-03 00:00:00")

#Naming the columns correct and dropping obsolete time column
names(workset)<-names1
workset$Time<-NULL

#resetting local to get names of weekdays in english
Sys.setlocale("LC_TIME", "English")


#Because of the legend issue, this time straight plot to file, instead of screen copy
png(file = "plot4.png", width = 480, height = 480, units = "px")

#setting the  device parameters to 2x2 matrix
par(mfcol=c(2,2))
#Building the first plot from task2
plot(workset$Date, workset$Global_active_power,type="l",main="", xlab="",ylab="Global Active Power (kilowatts)")

#Building the second plot from task3
plot(workset$Date, workset$Sub_metering_1,type="l",main="", xlab="",ylab="Energy sub metering")

#Adding second variable to second plot
lines(workset$Date, workset$Sub_metering_2, col="red")

#Adding third variableto second plot
lines(workset$Date, workset$Sub_metering_3, col="blue")

#Adding legend to the top right corner to second plot
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1,col=c("black","red","blue"),cex=0.85,bty="o",box.lty=1)

#Building the third plot 
plot(workset$Date, workset$Voltage,type="l",main="", xlab="datetime",ylab="Voltage")

#And finally the last plot!
plot(workset$Date, workset$Global_reactive_power,type="l",main="", xlab="datetime",ylab="Global_reactive_power")

#Copy my plot to a PNG file with exact dimensions and disconnecting the device
dev.off()


