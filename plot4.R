## This file plots four graphs in 2x2 format

png(filename="plot4.png", width=480,height=480)

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

#par(oma=c(0,0,0,0))
par(mfcol=c(2,2))


# prints the graph of panel 1 

with(data,plot(Date,Global_active_power, type="n", xlab = "",
               ylab="Global Active Power",col="black",cex.lab=0.7,cex.axis=0.7))
with(data,lines(Date,Global_active_power))

# prints the graph of panel 3

with(data,plot(Date,Sub_metering_1,xlab = "",
               ylab="Energy sub metering",type="n",cex.lab=0.7,cex.axis=0.7))
with(data,lines(Date,Sub_metering_1, col="black"))
with(data,lines(Date,Sub_metering_2, col="red"))
with(data,lines(Date,Sub_metering_3, col="blue"))
legend("topright",lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       x.intersp=0,y.intersp=0.1,bty="n",cex=0.7,inset=0)


# prints the graph of panel 2

with(data,plot(Date,Voltage, type="n", xlab = "datetime",
               ylab="Voltage",col="black",cex.lab=0.7,cex.axis=0.7))
with(data,lines(Date,Voltage))




# prints the graph of panel 4

with(data,plot(Date,Global_reactive_power, type="n", xlab = "datetime",
               ylab="Global_reactive_power",col="black",cex.lab=0.7,cex.axis=0.7))
with(data,lines(Date,Global_reactive_power))

dev.copy(png, file = "plot4.png")
dev.off()

#resets original parameters
par(opar)