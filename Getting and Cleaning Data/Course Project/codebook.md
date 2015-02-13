#script description for Coursera Getting and Cleaning Data course project

The data for this project is obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 
This site also contains information about the data set. Basically, thirty participants were tracked doing six activities through their 
Samsung Galaxy S II smartphones. The web address describes the precise measurements. The observations were split into two sets, test and training.
The folder UCI Har Dataset contains txt files used in the project. These are the test/training sets, feature names, activity labels, y_ files containing activity encoded numbers 
corresponding to activity type, and subject for each observation in the test/training sets 

The script for the course project is called run_analysis.R. First, set your working directory to the folder UCI HAR Dataset.
The first part of the script imports the necessary files. 

Next, the column names of the test and training set are assigned by the imported features. These two data frames are merged, the training set following the test set.
The merged data is called data. Next, only the 
variables containing the means and standard deviations are needed, so the code subsets on these. Any variable containing the 
strings "mean" and "std" is kept. Next, subject and activity are added as additional variables in data. The activity variable in data is then converted to the descriptive titles from the activity_labels txt file.   

The final part of the code creates the dataframe meanSubAct that records the mean for all variables in data by 
subject and activity. This is done with the tapply function and a for loop. The data is in wide format, each row contains a subject/activity
pair along with the means across all features. 

Finally the two data frames generated in this script are written to disk as txt files. Data in mergeData.txt and meanSubAct
in meanSubjectActivity.txt. Both txt files are contained in this repository. 
