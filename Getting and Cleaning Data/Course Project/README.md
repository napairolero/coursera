#readme for Courseras Getting and Cleaning Data course project


The script for this project is titled run_analysis.R.  The UCI HAR Dataset folder comes from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. To execute the code, set the working directory to the UCI
HAR Dataset folder. Description of the data set is given in codebook.md. The script run_analysis.R produces two data frames that are both written to disk (more detail below). data (written as mergeData.txt) contains the clean data set and meanSubAct (written as meanSubjectActivity.txt) contains the mean 
for all features over activity/subject pairs. Each observation in meanSubAct is for one activity/subject pair, given in column 
one and two. The rest of the columns contain the feature means. 
 
First, set your working directory to the folder UCI HAR Dataset. The first part of the script imports the necessary files. 

Next, the **column names of the test and training set are assigned by the imported features**. This is the give descriptive variable
names part of the assignment. These **data frames are merged**, the training set following the test set.
The merged data is called data. Next, **only the 
variables containing the means and standard deviations are needed, so the code subsets on these**. Any variable containing the 
strings "mean" and "std" is kept. Next, subject and activity are added as additional variables in data. The **activity variable in data is then converted to the descriptive titles** from the activity_labels txt file.
This was also requested in the project.   

The final part of the code creates the dataframe meanSubAct that **records the mean for all variables in data by 
subject and activity**. This is done with the tapply function and a for loop. The data is in wide format, each row contains a subject/activity
pair along with the means across all features. 

Finally the two data frames generated in this script are written to disk as txt files. Data in mergeData.txt and meanSubAct
in meanSubjectActivity.txt. Both txt files are contained in this repository. 
