
#downloading and unzipping dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="household_power_consumption.zip", mode = "wb")
unzip("household_power_consumption.zip",exdir=".")

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
png(file = "plot3.png", width = 480, height = 480, units = "px")

#Building the plot on screen to check that all ok
plot(workset$Date, workset$Sub_metering_1,type="l",main="", xlab="",ylab="Energy sub metering")

#Adding second variable
lines(workset$Date, workset$Sub_metering_2, col="red")

#Adding third variable
lines(workset$Date, workset$Sub_metering_3, col="blue")

#Adding legend to the top right corner
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1,col=c("black","red","blue"),cex = 0.75)

#disconnecting the device
dev.off()


