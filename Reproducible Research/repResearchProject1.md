## Reproducible Research: Project One
This is the R markdown document for the reproducible research peer assessment one. Each question will be answered in the order given by the assessment document. 
### Loading and preprocessing the data
First, fork and clone the RepData_PeerAssessment1 repository. Set the wd to wherever you locally cloned the repository and read the csv file. 
Note that I locally unzipped the csv folder activity.

```r
setwd("C:/Users/owner/Documents/GitHub/coursera/Reproducible Research/RepData_PeerAssessment1")
data <- read.csv("activity/activity.csv")
```
Next convert the date variable to the date class

```r
data$date <- as.Date(data$date)
```
### What is the mean total number of steps taken per day?
The following tapply function call calculates the total number of steps per day

```r
totalSteps <- tapply(data$steps, data$date, sum)
```

The next code chunk creates a histogram for totalSteps

```r
hist(totalSteps, main="Total Steps per Day", xlab="Total Steps", breaks =10)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

Finally, compute and report the mean and median of totalSteps.

```r
summary(totalSteps)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##      41    8841   10760   10770   13290   21190       8
```

## What is the average daily activity pattern
Convert the interval variable to factor and compute the average across days


```r
data$interval <- as.factor(data$interval)
fiveMinAvg <- tapply(data$steps, data$interval, mean, na.rm=TRUE)
```

Then, plot average steps against the corresonding five minute interval.


```r
plot(fiveMinAvg, type="l", main="Average Steps For Each Five Minute Interval", xlab="Interval Index", ylab="Average")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png) 

Finally, the following function call finds the index of the max. The first number is the actual interval while the second is its place in linear order. 


```r
which.max(fiveMinAvg)
```

```
## 835 
## 104
```

## Imputing missing values
The function na.omit subsets the data to only rows with no NA values. Therefore, the number of rows with NA data is


```r
length(data$interval)-length(na.omit(data)[,1])
```

```
## [1] 2304
```
Next, fill in any NA values with the corresonding five minute average. 


```r
for (i in 1:length(data[,1])){
  if(is.na(data$steps[i]) == TRUE){
    data$steps[i] <- fiveMinAvg[as.character(data$interval[i])]
  }  
}
```

Recalculate total steps, construct a histogram and compute the mean/median.


```r
totalSteps <- tapply(data$steps, data$date, sum, na.rm=T)
hist(totalSteps, main="Total Steps per Day", xlab="Total Steps", breaks =10)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png) 

```r
summary(totalSteps)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##      41    9819   10770   10770   12810   21190
```
From the two summaries, imputation does not change the mean but raises the median. Further, imputation raises the median to equal the mean. From the histograms, the center bar is much higher with imputation.  

## Are there differences in activity patterns between weekdays and weekends?
First, identify which days are weekdays and which are weekends


```r
weekday <- character(length(data[,1]))
for (i in 1:length(data$date)){
  if (weekdays(data$date[i]) == "Sunday" | weekdays(data$date[i]) == "Saturday"){
    weekday[i] <- "weekend"
  } else {
    weekday[i] <- "weekday"
  }
}
data$weekday <- as.factor(weekday)
```
Next compute the average by five minute interval and weekday/weekend.


```r
newFiveMinAvg <- aggregate(steps ~ interval + weekday, data= data, FUN = "mean")
```
Finally, plot using ggplot


```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 3.1.2
```

```r
ggplot(data=newFiveMinAvg, aes(x=as.numeric(interval), y=steps)) +geom_line()+ggtitle("Mean Number of Steps Per 5 Minute Interval")+ xlab("Interval")+ylab("Mean")+facet_wrap(~weekday, nrow=1)
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14-1.png) 

To answer the question, there definitely are differences between weekdays and weekends.
