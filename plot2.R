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
         V3 = as.numeric(as.character(V3)))%>%
  select(V1,V3)

# Step 5: Draw chart
png("./data/plot2.png", width=480, height=480)
#create hist
with(data, plot(V1,V3, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))


dev.off()


