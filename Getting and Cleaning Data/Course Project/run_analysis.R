################################# Cleaning Data : Course Project ##############################
#import data
test <- read.table("test/X_test.txt", stringsAsFactors= FALSE)
train <- read.table("train/X_train.txt", stringsAsFactors = FALSE)
features <- read.table("features.txt")
subjectTest <- read.table("test/subject_test.txt")
subjectTrain <- read.table("train/subject_train.txt")
y_test <- read.table("test/y_test.txt")
y_train <- read.table("train/y_train.txt")
activity_labels <- read.table("activity_labels.txt")

#column names of test/train
colnames(test) <- features[,2]
colnames(train) <- features[,2]

#merge test and train data sets
data <- rbind(test,train)

#extract only mean and std columns
meanvar <- grepl("mean", features[ , 2])
stdvar <- grepl("std", features[ ,2])
meanStdVar <- (meanvar | stdvar)
data <- data[ , meanStdVar]


#add subject and activity to end of each observation
subject <- rbind(subjectTest, subjectTrain)
activity <- rbind(y_test, y_train)
data$subject <- subject[,1]
data$activity <- activity[,1]

#add descriptive activity names
data$activity<- factor(data$activity)
levels(data$activity) <- activity_labels[,2]

#compute mean over activity/subject and store in data frame
data$subject <- factor(data$subject)
meanSubAct <- tapply(data[,1], list(data$subject, data$activity), mean)
meanSubAct <- melt(meanSubAct)
colnames(meanSubAct) <- c("subject", "activity", colnames(data)[1])
for (i in 2:79){
  temp <- tapply(data[,i], list(data$subject, data$activity), mean)
  temp <- melt(temp)
  colnames(temp) <- c("subject", "activity", colnames(data)[i])
  meanSubAct <- merge(meanSubAct, temp)
}

#order mean data frame by subject
meanSubAct <- meanSubAct[order(meanSubAct$subject), ]

#write file
write.table(data, "mergeData.txt", row.name=FALSE)
write.table(meanSubAct, "meanSubjectActivity.txt", row.name = FALSE)

