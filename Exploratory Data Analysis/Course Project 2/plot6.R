#############################Exploratory Data Analysis Project 2: Plot 6 #################################################
#get data
temp <- tempfile() 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
NEI <- readRDS(unzip(temp, "summarySCC_PM25.rds"))
SCC <- readRDS(unzip(temp, "Source_Classification_Code.rds"))
unlink(temp)

NEI$year <- factor(NEI$year) #convert year to factor
NEI$type <- factor(NEI$type)
NEIBalt <- NEI[NEI$fips =="24510", ] #subset on baltimore
NEILA <- NEI[NEI$fips == "06037", ] #subset to LA

#subsetNEI on vehicle in EI.Sector
vehicle <- grepl("Vehicle", SCC$EI.Sector)
SCCVehicle <- SCC[vehicle, 1]
SCCVehicle <- as.character(SCCVehicle)
NEIBalt <- NEIBalt[NEIBalt$SCC %in% SCCVehicle, ]
NEILA <- NEILA[NEILA$SCC %in% SCCVehicle, ]

library(plyr) #load plyr package
emissionsByYearBalt <- ddply(NEIBalt, .(year), summarize, totalEmissions = sum(Emissions)) #compute emissions by year in BALT
emissionsByYearLA <- ddply(NEILA, .(year), summarize, totalEmissions = sum(Emissions)) #compute emissions by year in LA

#create and save png plot in wd
png(file="plot6.png", width=480, height=480, units ="px")
plot(as.numeric(as.character(emissionsByYearLA$year)),emissionsByYearLA$totalEmissions, ylim=c(0,4650), col="red", pch = 1, xlab="Year", ylab="Total Emissions")
title(main="Motor Vehicle Total Emission of PM2.5")
lines(as.numeric(as.character(emissionsByYearLA$year)),emissionsByYearLA$totalEmissions,col="red")

points(as.numeric(as.character(emissionsByYearLA$year)),emissionsByYearBalt$totalEmissions, col="black")
lines(as.numeric(as.character(emissionsByYearBalt$year)),emissionsByYearBalt$totalEmissions, col="black")
legend("right", col=c("red", "black"), pch = 1, lty=1, legend= c("Los Angeles County", "Baltimore"))
dev.off()