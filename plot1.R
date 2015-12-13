# # this is the first assignment for Exploratory_data class
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
file <- unzip(temp)

electricity <- read.table(file, header=T, sep=";")
head(electricity)
class(electricity$Date)
dim(electricity)
electricity$Date <- as.Date(electricity$Date, format="%d/%m/%Y")  #change the class to date
dt <- electricity[(electricity$Date=="2007-02-01") | (electricity$Date=="2007-02-02"),] #took the first 2 days of Feb 2007


dt[,3:9]<-lapply(dt[,3:9],as.character) #change remaining clumns to charachter
dt[,3:9]<-lapply(dt[,3:9],as.numeric) #change remaining clumns to numeric

dt$timeseries<-as.POSIXlt(paste(dt$Date,dt$Time))
names(dt)

#plot 1
plot1 <- function() {
        hist(dt$Global_active_power, col="red",main = paste("Global Active Power"), xlab="Global Active Power (kilowatts)")
        dev.copy(png, file="plot1.png", width=480, height=480) 
        dev.off()
        cat("Plot1.png has been saved in", getwd())
}
plot1()

