## Course Project for GettingCleaningData
## Created June 19, 2015

## This repo contains run_analysis.R, a script which does the following

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## IMPORTANT: Script assumes that the working directory is the parent directory for /test and /train

To run the script
* Open R
* Make sure your working directoy is set to the directory containing the folders for the train and test data
* Type ``source("run_analysis.R")``
* The data set "tidyActivityData.txt" should appear in your working directory

## The repo also contains codebook.md, a codebook explaining the changes made to the original user activity data
