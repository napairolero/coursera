#############################Exploratory Data Analysis Project 2: Plot 1 #################################################
#get data
temp <- tempfile() 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
NEI <- readRDS(unzip(temp, "summarySCC_PM25.rds"))
SCC <- readRDS(unzip(temp, "Source_Classification_Code.rds"))
unlink(temp)

NEI$year <- factor(NEI$year) #convert year to factor

library(plyr) #load plyr package
emissionsByYear <- ddply(NEI, .(year), summarize, totalEmissions = sum(Emissions)) #compute emissions by year

#create and save png plot in wd
png(file="plot1.png", width=480, height=480, units ="px")
plot1 <- plot(as.numeric(as.character(emissionsByYear$year)),emissionsByYear$totalEmissions ,pch = 1,type="l", xlab="Year", ylab="Total Emissions")
title(main="Total Emission of PM2.5 in United States")
lines(emissionsByYear$year,emissionsByYear$totalEmissions)
dev.off()
