#############################Exploratory Data Analysis Project 2: Plot 5 #################################################
#get data
temp <- tempfile() 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
NEI <- readRDS(unzip(temp, "summarySCC_PM25.rds"))
SCC <- readRDS(unzip(temp, "Source_Classification_Code.rds"))
unlink(temp)

NEI$year <- factor(NEI$year) #convert year to factor
NEI$type <- factor(NEI$type)
NEIBalt <- NEI[NEI$fips =="24510", ] #subset on baltimore

#subsetNEI on vehicle in EI.Sector
vehicle <- grepl("Vehicle", SCC$EI.Sector)
SCCVehicle <- SCC[vehicle, 1]
SCCVehicle <- as.character(SCCVehicle)
NEIBalt <- NEIBalt[NEIBalt$SCC %in% SCCVehicle, ]

library(plyr) #load plyr package
emissionsByYearBalt <- ddply(NEIBalt, .(year), summarize, totalEmissions = sum(Emissions)) #compute emissions by year

#create and save png plot in wd
png(file="plot5.png", width=480, height=480, units ="px")
plot1 <- plot(as.numeric(as.character(emissionsByYearBalt$year)),emissionsByYearBalt$totalEmissions ,pch = 1,type="l", xlab="Year", ylab="Total Emissions")
title(main="Motor Vehicle Total Emission of PM2.5 in Baltimore")
lines(emissionsByYearBalt$year,emissionsByYearBalt$totalEmissions)
dev.off()

