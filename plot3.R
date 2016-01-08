## This file plots usage of energy submetering across three categories.

## records original parameters
opar <- par()

## Reads the relevant data into a table from a text file.
library(datasets)
lref <- grep("1/2/2007",readLines("household_power_consumption.txt"))

headings <- read.table("household_power_consumption.txt", header = FALSE,
                       sep=";",nrows=1,colClasses="character")

data <- read.table("household_power_consumption.txt", header = FALSE, 
                   sep = ";",skip=lref,nrows=2879,col.names=headings)

## converts the date/times into specified R formats  

data$Date <- as.Date(data$Date,format='%d/%m/%Y')
data$Date <- paste(data$Date,data$Time)
data$Date <- strptime(data$Date, "%Y-%m-%d %H:%M:%S")

# prints the graph of plot 3 

with(data,plot(Date,Sub_metering_1,xlab = "",
               ylab="Energy sub metering",type="n",cex.lab=0.7,cex.axis=0.7))
with(data,lines(Date,Sub_metering_1, col="black"))
with(data,lines(Date,Sub_metering_2, col="red"))
with(data,lines(Date,Sub_metering_3, col="blue"))
legend("topright",lty=1,cex=0.7, col = c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))



dev.copy(png, file = "plot3.png")
dev.off()

#resets original parameters
par(opar)