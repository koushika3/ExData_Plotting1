# zipF <- "exdata_data_household_power_consumption.zip"
# outDir <- "powerConsumption"
# unzip(zipfile = zipF, exdir = outDir)

powerConsumption <- read.table("powerConsumption/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
powerConsumption$Date <- as.Date(powerConsumption$Date, "%d/%m/%Y")

powerConsumption <- powerConsumption[complete.cases(powerConsumption),]

library(dplyr)
powerConsumption <- powerConsumption %>% filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

datetime <- strptime(paste(as.character(powerConsumption$Date), powerConsumption$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 
globalActivePower <- powerConsumption$Global_active_power

par(mfrow = c(2,2))
png("plot4.png", width=480, height=480)
with(powerConsumption, {
  plot(datetime, Global_active_power, type = "l")
  plot(datetime, Voltage, type = "l", xlab = "")
  plot(datetime, Sub_metering_1, ylab = "Global Active Power (kilowatts)",
       xlab = "", type = "l")
  lines(datetime, Sub_metering_2, col='Red')
  lines(datetime, Sub_metering_3, col='Blue')
  plot(datetime, Global_reactive_power, type = "l", ylab = "Global Reactive Power (kilowatts)")
})
dev.off()