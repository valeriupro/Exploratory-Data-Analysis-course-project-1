FileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
FileName<-"exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(FileName)) {download.file(FileUrl, "rdata")}
FilePath<-"household_power_consumption"
if (!file.exists(FilePath)) {unzip("rdata")}
obs<-read.table("household_power_consumption.txt",
                header=TRUE, sep=";", na.strings = "?")
obs<-obs[which(obs$Date=="1/2/2007"|obs$Date=="2/2/2007"),]
library(lubridate)
obs$Date<-dmy(obs$Date)
obs$Date_and_Time<-as.POSIXct(paste(obs$Date,obs$Time,sep=" "))
keeps<-c("Date_and_Time","Global_active_power","Global_reactive_power","Voltage","Sub_metering_1",
         "Sub_metering_2","Sub_metering_3")
obs<-obs[keeps]
par(mfcol=c(2,2),cex=0.75)
with(obs,plot(Date_and_Time,Global_active_power,type="l",xlab = '',ylab = "Global Active Power"))
with(obs,plot(Date_and_Time,Sub_metering_1,type="n", xlab = '',ylab = "Energy sub metering"))
with(obs,lines(Date_and_Time,Sub_metering_1,type="l",col="black"))
with(obs,lines(Date_and_Time,Sub_metering_2,type="l",col="red"))
with(obs,lines(Date_and_Time,Sub_metering_3,type="l",col="blue"))
legend("topright",col=c("black","red","blue"),lty=c(1,1,1),c("Sub_metering_1","Sub_metering_2",
                                                             "Sub_metering_3"), cex=0.5)
with(obs,plot(Date_and_Time,Voltage,type="l",xlab = 'datetime',ylab = "Voltage"))
with(obs,plot(Date_and_Time,Global_reactive_power,type="l",xlab = 'datetime',ylab = "Global_reactive_power"))
dev.copy(png,file="plot4.png",width = 480, height = 480)
dev.off()
