# this is the first assignment for Exploratory_data class

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

#plot3

plot3 <- function() {
        plot(dt$timeseries,dt$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(dt$timeseries,dt$Sub_metering_2,col="red")
        lines(dt$timeseries,dt$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
        dev.copy(png, file="plot3.png", width=500, height=500)
        dev.off()
        cat("plot3.png has been saved in", getwd())
}
plot3()


