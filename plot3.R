library(dplyr)
library(lubridate)

# Step 1- check and create dir if needed
if (!file.exists("./data")) {dir.create("./data")}

# Step 2- download file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zf <- "./data/cons.zip"
if (!file.exists("./data/cons.zip")) {download.file(url,zf)}

# Step 3- unzip file
if (!file.exists("./data/household_power_consumption.txt")) {unzip(zipfile = f, exdir ="./data" )}

# Step 3: reading relevant data, skip row not needed
data <- read.table("./data/household_power_consumption.txt", sep = ";", skip = 66637, nrows = 2880)
# converto to local dataframe
data <- tbl_df(data)

# Step 4: Prepare data for plot 
data <- data %>%
  mutate(V1 = as.POSIXct(dmy_hms(as.character(paste(V1, V2)))),
         V7 = as.numeric(as.character(V7)),
         V8 = as.numeric(as.character(V8)),
         V9 = as.numeric(as.character(V9))) %>% 
  select(V1,V7:V9)
  
# Step 5: Draw chart
png("./data/plot3.png", width=480, height=480)

with(data, plot(V1,V7, type="n", xlab = "", ylab = "Energy Sub Metering"))
with(data, points(V1,V7, col="black", type="l"))
with(data, points(V1,V8, col="red", type="l"))
with(data, points(V1,V9, col="blue", type="l"))
legend("topright", lty=1, col = c("black", "red", "blue"), 
       legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

dev.off()


