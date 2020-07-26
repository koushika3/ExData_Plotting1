zipF <- "exdata_data_household_power_consumption.zip"
outDir <- "powerConsumption"
unzip(zipfile = zipF, exdir = outDir)

powerConsumption <- read.table("powerConsumption/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
powerConsumption$Date <- as.Date(powerConsumption$Date, "%d/%m/%Y")

powerConsumption <- powerConsumption[complete.cases(powerConsumption),]

library(dplyr)
powerConsumption <- powerConsumption %>% filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

dateTime <- strptime(paste(as.character(powerConsumption$Date), powerConsumption$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 
globalActivePower <- powerConsumption$Global_active_power

png("plot3.png", width=480, height=480)

with(powerConsumption, plot(Sub_metering_1, datetime, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l"))

dev.off()