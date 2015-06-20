## R-script to combine test and train data files for the UCI HAR Dataset
## Script assumes that the working directory is the parent directory for /test and /train

## Project Instructions
## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

######## Step 1 - Create One Data Set from Six ############
## Read in training data
X_train <- read.table(file="./train/X_train.txt")
Y_train <- read.table(file="./train/y_train.txt")
sub_train <- read.table(file="./train/subject_train.txt")
## Combine all training data
train_all <- cbind(sub_train,Y_train,X_train)

## Read in test data
X_test <- read.table(file="./test/X_test.txt")
Y_test <- read.table(file="./test/y_test.txt")
sub_test <- read.table(file="./test/subject_test.txt")

## Combine test data
test_all <- cbind(sub_test,Y_test,X_test)

## Step 1: Combine test and training data
AllData <- rbind(train_all,test_all)

##### Step 2: Extract only mean and SD columns for each measurement
## I decided that this does not include "angle" measurements at the end of the file
## Requires merging features.txt with file from Step 1
featureNames <- read.table(file="./features.txt")
names(featureNames) <- c("Number", "Activity")
varNames <- c("Subject","Activity",as.character(featureNames$Activity))
names(AllData) <- varNames
## With help from StackOverflow and dplyr
require(dplyr)
## http://stackoverflow.com/questions/28549045/dplyr-select-error-found-duplicated-column-name
## Make column names legal in R
valid_column_names <- make.names(names=names(AllData), unique=TRUE, allow_ = TRUE)
names(AllData) <- valid_column_names

## Select means and standard deviations and clean up variable names
SubActVals <- select(AllData, Subject, Activity)
AllMeanStd <- select(AllData, matches("mean|std"))
AllMeanStd <- select(AllMeanStd, -contains("angle"))
AllMeanStd <- select(AllMeanStd, -contains("meanFreq"))
## data frame "AllMeanStd" contains only means and standard deviations of measurements
## clean up variable names
AllDataNames <- names(AllMeanStd)
AllDataNames <- gsub("mean..","mean",AllDataNames)
AllDataNames <- gsub("std..","std",AllDataNames)
names(AllMeanStd) <- AllDataNames
## Column bind subject and activity variables
actMeanStd <- cbind(SubActVals, AllMeanStd)

#### Step 3: Labels data with descriptive Activity Names
## Read in labels and change some names
actNames <- read.table(file="./activity_labels.txt")
actLabels <- actNames[,2]
actLabels <- gsub("WALKING_UPSTAIRS", "WALKING_UP", actLabels)
actLabels <- gsub("WALKING_DOWNSTAIRS", "WALKING_DN", actLabels)
## Apply labels to appropriate rows
for (i in seq(actLabels)) {actMeanStd[actMeanStd$Activity == i, 'Activity'] <- actLabels[i]}

#### Step 4: Label the data set with descriptive variable names
## Already done wwith gsub commands in Step 2

### Step 5: Create a tidy data set with the average of each variable for each activity and each subject.
by_Sub_Act <- actMeanStd %>% group_by(Subject, Activity)
by_Sub_Act_Mean <- summarise_each(by_Sub_Act,funs(mean))
write.table(by_Sub_Act_Mean, file="tidyActivityData.txt", row.names=FALSE)
