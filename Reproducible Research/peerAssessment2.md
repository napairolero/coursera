## US Storm Data Fatalities, Injuries and Economic Costs

### Synopsis
This report reveals the storm events that cause the highest economic cost and population loss/injury. Tornadoes cause the most fatalities and injuries by a wide margin. Heat, excessive heat, floods, flash floods, lightning and tstm wind round out the remaining top five slots in both categories. See the barplots later in this document for ranking and values. Winter storms and river floods have the highest economic cost. Hurrican Opal, floods and heavy rain/severe weather round out the remaining three spots. Again, see below for a bar plot with ranking and exact values. 

### Data Processing
First, download and read the csv data file. 


```r
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", temp)
data <- read.csv(temp, stringsAsFactors=FALSE)
unlink(temp)
```

Since the csv file was imported with stringsAsFactors=FALSE, convert the weather type to factor.


```r
data$EVTYPE <- factor(data$EVTYPE)
```

The first question is, "Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?". The relevant variables here are INJURIES and FATALITIES. Use tapply to find total fatalities and injuries across events.


```r
injuriesEvent <- tapply(data$INJURIES, data$EVTYPE, sum)
fatalitiesEvent <- tapply(data$FATALITIES, data$EVTYPE, sum)
```

Next, plot the top five of each.


```r
injuriesEvent <- injuriesEvent[order(injuriesEvent, decreasing = TRUE)]
fatalitiesEvent <- fatalitiesEvent[order(fatalitiesEvent, decreasing = TRUE)]
par(mar = c(7.1,4.1,4.1,2.1))
barplot(injuriesEvent[1:5], las=3, main = "Top 5 Injuries by Event", ylab="Total Injuries", cex.names=.8)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

```r
barplot(fatalitiesEvent[1:5], las = 3, main = "Top 5 Fatalities by Event", ylab="Total Fatalities", cex.names=.8)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-2.png) 

These plots show that tornadoes are by far the worst event for both fatalities and injuries. Lightning is the 5th worst in both categories. Floods, flash floods, heat, excessive heat and tstm winds round out the remaining spots. 

The next question asks "Across the United States, which types of events have the greatest economic consequences?". For this the relevant variables are PROPDMG and CROPDMG. The raw data contains a multiplier in PROPDMGEXP and CROPDMGEXP. "K" or "k" indicates thousand, "M" or "m" indicates million, "B" or "b" indicates billion and "H" or "h" indicates hundred. First use the multiplier and replace the values in PROPDMG and CROPDMB.


```r
for (i in 1:length(data[,1])){
  if ( data$PROPDMGEXP[i] == "H" | data$PROPDMGEXP[i] == "h" ){
    if (is.na(data$PROPDMG[i]) == FALSE){
      data$PROPDMG[i] <- 100*data$PROPDMG[i]
      }
  } else if (data$PROPDMGEXP[i] == "K" | data$PROPDMGEXP[i] == "k"){
    if (is.na(data$PROPDMG[i]) == FALSE){
      data$PROPDMG[i] <- 1000*data$PROPDMG[i]
      }
  } else if (data$PROPDMGEXP[i] == "M" | data$PROPDMGEXP[i] == "m"){
    if (is.na(data$PROPDMG[i]) == FALSE){
      data$PROPDMG[i] <- 1000000*data$PROPDMG[i]
      }
  } else if (data$PROPDMGEXP[i] == "B" | data$PROPDMGEXP[i] == "b"){
    if (is.na(data$PROPDMG[i]) == FALSE){
      data$PROPDMG[i] <- 1000000000*data$PROPDMG[i]
      }
  }
}

for (i in 1:length(data[,1])){
  if ( data$CROPDMGEXP[i] == "H" | data$CROPDMGEXP[i] == "h" ){
    if (is.na(data$CROPDMG[i]) == FALSE){
      data$CROPDMG[i] <- 100*data$CROPDMG[i]
      }
  } else if (data$CROPDMGEXP[i] == "K" | data$CROPDMGEXP[i] == "k"){
    if (is.na(data$CROPDMG[i]) == FALSE){
      data$CROPDMG[i] <- 1000*data$CROPDMG[i]
      }
  } else if (data$CROPDMGEXP[i] == "M" | data$CROPDMGEXP[i] == "m"){
    if (is.na(data$CROPDMG[i]) == FALSE){
      data$CROPDMG[i] <- 1000000*data$CROPDMG[i]
      }
  } else if (data$CROPDMGEXP[i] == "B" | data$CROPDMGEXP[i] == "b"){
    if (is.na(data$CROPDMG[i]) == FALSE){
      data$CROPDMG[i] <- 1000000000*data$CROPDMG[i]
      }
  }
}
```

Use tapply to sum across events, combine property and crop damage, and then plot. 


```r
propDamage <- tapply(data$PROPDMG, data$EVTYPE, sum)
cropDamage <- tapply(data$CROPDMG, data$EVTYPE, sum)
totalDamage <- propDamage + cropDamage
totalDamage <- totalDamage[order(totalDamage, decreasing = TRUE)]
par(mar = c(7.1,4.1,4.1,2.1))
barplot(totalDamage[1:5], las=3, main="Top 5 Total Damage by Event", ylab="Total Damage", cex.names=.8,
        names.arg = c("Winter Storm", "River Flood", "Hurricane Opal", "Flood", "HeavyRain/SevWet"))
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png) 

The barplot shows that winter storms and river floods are the most costly. Hurricane Opal, Floods and Heavy Rain Severe Weather round out the remaining three spots.

### Results
Tornadoes cause the most fatalities and injuries by a wide margin. Heat, excessive heat, floods, flash floods, lightning and tstm wind round out the remaining top five slots in both categories. See the barplots later in this document for ranking and values. Winter storms and river floods have the highest economic cost. Hurrican Opal, floods and heavy rain/severe weather round out the remaining three spots. Again, see below for a bar plot with ranking and exact values. 
