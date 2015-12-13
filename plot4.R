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


#plot 4
plot4 <- function() {
        par(mfrow=c(2,2))

        plot(dt$timeseries,dt$Global_active_power, type="l", xlab="", ylab="Global Active Power") ##plot 1,1
        plot(dt$timeseries,dt$Voltage, type="l", xlab="datetime", ylab="Voltage") ##plot 1,2
        plot(dt$timeseries,dt$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering") ##plot 2,1
        lines(dt$timeseries,dt$Sub_metering_2,col="red")
        lines(dt$timeseries,dt$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex makes text small
        plot(dt$timeseries,dt$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power") ##plot 2,2
        
       
        dev.copy(png, file="plot4.png", width=500, height=500)
        dev.off()
        cat("plot4.png has been saved in", getwd())
}
plot4()
