## This file plots Global Active Power usage across multiple days.

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

# prints the graph of plot 2 
par(oma=c(0,0,0,0))
with(data,plot(Date,Global_active_power, type="n", xlab = "",
               ylab="Global Active Power (kilowatts)",col="black",cex.lab=0.7,cex.axis=0.7))
with(data,lines(Date,Global_active_power))               
              

dev.copy(png, file = "plot2.png")
dev.off()

#resets original parameters
par(opar)
