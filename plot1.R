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
keeps<-c("Date_and_Time","Global_active_power")
obs<-obs[keeps]
str(obs)
with(obs,hist(Global_active_power,col="red",main="Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.copy(png,file="plot1.png",width = 480, height = 480)
dev.off()