#script description for Coursera Getting and Cleaning Data course project

The data for this project is obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 
This site also contains information about the data set. Basically, thirty participants were tracked doing six activities through their 
Samsung Galaxy S II smartphones. The web address describes the precise measurements. The observations were split into two sets, test and training.
The folder UCI Har Dataset contains txt files used in the project. These are the test/training sets, feature names, activity labels, y_ files containing activity encoded numbers 
corresponding to activity type, and subject for each observation in the test/training sets 

List of important data frames in the code
* data: test/train data frame 
* meanSubAct: data frame with mean across features for subject/activity pairs

Imported data in the code
* test: test set
* train: training set 
* features: feature names 
* subjectTest: subjects for test set
* subjectTrain: subjects for training set
* y_test: activity numbers for test set
* y_train: activity numbers for training set
* activity_labels: descriptive labels for activities
