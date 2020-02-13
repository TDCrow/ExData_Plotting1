#Download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download_directory <- "./Electric Power Consumption"
file_directory <- "./data"
zip_name <- paste(download_directory, "/", "household_power_consumption.zip", sep = "")

if(!file.exists(download_directory)) {
  dir.create(download_directory)
  download.file(url = fileUrl, destfile = zip_name)
}


if(!file.exists(file_directory)) {
  dir.create(file_directory)
  unzip(zipfile = zip_name, exdir = file_directory)
}
setwd(file_directory)

#Read in data, and select only relevant dates
data_class <- c("character","character", rep("numeric",7))

raw_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",colClasses = data_class)
raw_data$Date <- as.Date(raw_data$Date, "%d/%m/%Y")
selected_dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
raw_data <- raw_data[raw_data$Date %in% selected_dates,]
raw_data$datetime <- strptime(paste(raw_data$Date, raw_data$Time), "%Y-%m-%d %H:%M:%S" )

#Plot 2
png("plot2.png", width = 480, height = 480)
with(raw_data, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n"))
lines(raw_data$datetime, raw_data$Global_active_power)
dev.off()
