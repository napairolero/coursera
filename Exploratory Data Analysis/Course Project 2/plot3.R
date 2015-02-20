#############################Exploratory Data Analysis Project 2: Plot 3 #################################################
#get data
temp <- tempfile() 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
NEI <- readRDS(unzip(temp, "summarySCC_PM25.rds"))
SCC <- readRDS(unzip(temp, "Source_Classification_Code.rds"))
unlink(temp)

NEI$year <- factor(NEI$year) #convert year to factor
NEI$type <- factor(NEI$type)
NEIBalt <- NEI[NEI$fips =="24510", ] #subset on baltimore

library(plyr) #load plyr package
emissionsByYearBalt <- ddply(NEIBalt, c("year", "type"), summarize, totalEmissions = sum(Emissions)) #compute emissions by year

library(ggplot2) #load ggplot2 package
#create and save png plot in wd
png(file="plot3.png", width=480, height=480, units ="px")
plot1 <- qplot(year, totalEmissions, data=emissionsByYearBalt, col=type)+geom_line(aes(group=type))
plot1 <- plot1+xlab("Year")+ylab("Total Emissinos")+ggtitle("Total Emissions in Baltimore by Type")
print(plot1)
dev.off()