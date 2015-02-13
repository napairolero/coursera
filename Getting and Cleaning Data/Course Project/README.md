#readme for Courseras Getting and Cleaning Data course project


The script for this project is titled run_analysis.R. Description of how the script works is in the 
codebook.md file contained in this repository. The UCI HAR Dataset folder comes from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. To execute the code, set the working directory to the UCI
HAR Dataset folder. The script produces two data frames that are both written to disk. data (written as mergeData.txt) contains the clean data set and meanSubAct (written as meanSubjectActivity.txt) contains the mean 
for all features over activity/subject pairs. Each observation in meanSubAct is for one activity/subject pair, given in column 
one and two. The rest of the columns contain the feature means. 
