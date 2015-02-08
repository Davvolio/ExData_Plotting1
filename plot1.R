##Start of common part. Reading, tidying and subsetting.


#Here we read two sets: Set of col names and chunk of data that contains two needed days
names1 <-read.table("household_power_consumption.txt",sep=";", na.strings ="?", nrows=1,stringsAsFactors=F)
megadata<-read.table("household_power_consumption.txt",sep=";", na.strings ="?", nrows=10000,skip=63200,stringsAsFactors=F)

#Transform data from character to data type for easy subsetting
megadata$V1<-as.Date(megadata$V1, "%d/%m/%Y")

#Subsetting only two needed days
workset <-subset(megadata,megadata$V1>"2007-01-31" & megadata$V1<"2007-02-03")

#Naming the columns correct, because names was skipped with 63199 other observations earlier
names(workset)<-names1

##End of common part. Unique plotting below.

#Building the plot on screen to check that all ok
hist(workset$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## Copy my plot to a PNG file with exact dimensions and disconnecting the device
dev.copy(png, file = "plot1.png",width = 480, height = 480)  
dev.off()

