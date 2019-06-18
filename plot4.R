install.packages("data.table")
install.packages("dplyr")
install.packages("R.utils")


library("R.utils")
library("data.table")
library("dplyr")

#1.12.2
packageVersion("data.table")
#0.8.1
packageVersion("dplyr")

#set the wording directory
setwd("D:/Melick/GD/Temp/41")


download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" , destfile = "dataset.zip")

if(!dir.exists("Data")){dir.create("Data")}
unzip("dataset.zip",exdir = "Data")

varDataPath <- "Data/household_power_consumption.txt"



# calculate the memory size in Mbs
dt_d<- fread(file = varDataPath , nrows = 1000 ,stringsAsFactors = F ) %>% tibble::as_tibble()
# Object size in byes
countLines(varDataPath)/1000 * object.size(dt_d)

dt_d<- fread(file = varDataPath  ,stringsAsFactors = F ) %>% tibble::as_tibble()

## check first few data
head(dt_d)
tail(dt_d)

## convert the date
dt_d <- mutate(dt_d,Date = as.Date( dt_d$Date, "%d/%m/%Y"))

## filter the dataset
dt_d <- filter(dt_d,dt_d$Date >= "2007-02-01" & dt_d$Date <= "2007-02-02" )

## clean the data
dt_d <- mutate(dt_d,Global_active_power=as.numeric(dt_d$Global_active_power,na.rm = TRUE))
dt_d <- mutate(dt_d,Global_reactive_power=as.numeric(dt_d$Global_reactive_power,na.rm = TRUE))
dt_d <- mutate(dt_d,Voltage=as.numeric(dt_d$Voltage,na.rm = TRUE))
dt_d <- mutate(dt_d,Global_intensity=as.numeric(dt_d$Global_intensity,na.rm = TRUE))
dt_d <- mutate(dt_d,Global_intensity=as.numeric(dt_d$Global_intensity,na.rm = TRUE))
dt_d <- mutate(dt_d,Sub_metering_1=as.numeric(dt_d$Sub_metering_1,na.rm = TRUE))
dt_d <- mutate(dt_d,Sub_metering_2=as.numeric(dt_d$Sub_metering_2,na.rm = TRUE))
dt_d <- mutate(dt_d,Sub_metering_3=as.numeric(dt_d$Sub_metering_3,na.rm = TRUE))
dt_d <- mutate(dt_d,dt=as.POSIXct(paste(dt_d$Date,dt_d$Time)) )

par(mfrow = c(2,2) , mar=c(4,4,2,1))

plot(dt_d$dt,dt_d$Global_active_power,type = "l" , ylab = "Global Active Power(killowatts)" , xlab = "")
plot(dt_d$dt,dt_d$Voltage,type = "l" , ylab = "Voltage" , xlab = "datetime")

plot(dt_d$dt,dt_d$Sub_metering_1,type = "n" , ylab = "Energy sub metering" , xlab = "" )
points(dt_d$dt,dt_d$Sub_metering_1,type = "l" , col="gray")
points(dt_d$dt,dt_d$Sub_metering_2,type = "l" , col="red")
points(dt_d$dt,dt_d$Sub_metering_3,type = "l" , col="blue")
legend("topright" , legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3") , col = c("gray","red","blue") , pch = 95 , lty = 1:2 )

plot(dt_d$dt,dt_d$Global_reactive_power,type = "l" , ylab = "Global reactive power" , xlab = "datetime")

# 1. Open jpeg file
png("plot4.png", width = 480, height = 480)

# 2. Create the plot
par(mfrow = c(2,2) , mar=c(4,4,2,1))

plot(dt_d$dt,dt_d$Global_active_power,type = "l" , ylab = "Global Active Power(killowatts)" , xlab = "")
plot(dt_d$dt,dt_d$Voltage,type = "l" , ylab = "Voltage" , xlab = "datetime")

plot(dt_d$dt,dt_d$Sub_metering_1,type = "n" , ylab = "Energy sub metering" , xlab = "" )
points(dt_d$dt,dt_d$Sub_metering_1,type = "l" , col="gray")
points(dt_d$dt,dt_d$Sub_metering_2,type = "l" , col="red")
points(dt_d$dt,dt_d$Sub_metering_3,type = "l" , col="blue")
legend("topright" , legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3") , col = c("gray","red","blue") , pch = 95 , lty = 1:2 )

plot(dt_d$dt,dt_d$Global_reactive_power,type = "l" , ylab = "Global reactive power" , xlab = "datetime")
# 3. Close the file
dev.off()







