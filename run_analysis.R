## Create one R script called run_analysis.R that does the following: 
## 1. Merges the training and the test sets to create one data set. 
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set 
## 4. Appropriately labels the data set with descriptive activity names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


## data.table and reshape2 packages are required for this program
## Install the packages if they are not already installed.
if (!require("data.table")) { 
  install.packages("data.table") 
} 

if (!require("reshape2")) { 
  install.packages("reshape2") 
} 

require("data.table") 
require("reshape2") 

# Load: Load data from activity_labels.txt
activity_data <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels <- activity_data$V2

##activity_labels
##[1] WALKING            WALKING_UPSTAIRS   WALKING_DOWNSTAIRS SITTING            STANDING           LAYING            
##Levels: LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS

# Load: data column names 
features <- read.table("./UCI HAR Dataset/features.txt")
## head(features)
##  V1                V2
##1  1 tBodyAcc-mean()-X
##2  2 tBodyAcc-mean()-Y
##3  3 tBodyAcc-mean()-Z
##4  4  tBodyAcc-std()-X
##5  5  tBodyAcc-std()-Y
##6  6  tBodyAcc-std()-Z

# Extract only the interested measurements which are the mean and standard deviation.
intrst_features <- grepl("mean|std", features$V2) 

# Load and process X_test & Y_test data. 

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt") 
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") 

## Label the X_test data with the features.
names(X_test) = features$V2

# Extract only (those columns where) for the mean and standard deviation for each measurement. 
X_test = X_test[,intrst_features] 

#Notice that we only have those columns which have mean or std in them
##> head(X_test,n=1)
##  tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y tBodyAcc-std()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
##1         0.2571778       -0.02328523       -0.01465376        -0.938404       -0.9200908       -0.6676833            0.9364893           -0.2827192
##  tGravityAcc-mean()-Z tGravityAcc-std()-X tGravityAcc-std()-Y tGravityAcc-std()-Z tBodyAccJerk-mean()-X tBodyAccJerk-mean()-Y tBodyAccJerk-mean()-Z
##1            0.1152882          -0.9254273          -0.9370141          -0.5642884            0.07204601             0.0457544            -0.1060427
##  tBodyAccJerk-std()-X tBodyAccJerk-std()-Y tBodyAccJerk-std()-Z tBodyGyro-mean()-X tBodyGyro-mean()-Y tBodyGyro-mean()-Z tBodyGyro-std()-X tBodyGyro-std()-Y
##1           -0.9066828           -0.9380164           -0.9359358          0.1199762        -0.09179234          0.1896285        -0.8830891        -0.8161636
##  tBodyGyro-std()-Z tBodyGyroJerk-mean()-X tBodyGyroJerk-mean()-Y tBodyGyroJerk-mean()-Z tBodyGyroJerk-std()-X tBodyGyroJerk-std()-Y tBodyGyroJerk-std()-Z
##1        -0.9408812             -0.2048962             -0.1744877            -0.09338934            -0.9012242            -0.9108601            -0.9392504
##  tBodyAccMag-mean() tBodyAccMag-std() tGravityAccMag-mean() tGravityAccMag-std() tBodyAccJerkMag-mean() tBodyAccJerkMag-std() tBodyGyroMag-mean() tBodyGyroMag-std()
##1         -0.8669294        -0.7051911            -0.8669294           -0.7051911             -0.9297665            -0.8959942          -0.7955439         -0.7620732
##  tBodyGyroJerkMag-mean() tBodyGyroJerkMag-std() fBodyAcc-mean()-X fBodyAcc-mean()-Y fBodyAcc-mean()-Z fBodyAcc-std()-X fBodyAcc-std()-Y fBodyAcc-std()-Z
##1              -0.9251949             -0.8943436        -0.9185097        -0.9182132        -0.7890915       -0.9482903       -0.9251369       -0.6363167
##  fBodyAcc-meanFreq()-X fBodyAcc-meanFreq()-Y fBodyAcc-meanFreq()-Z fBodyAccJerk-mean()-X fBodyAccJerk-mean()-Y fBodyAccJerk-mean()-Z fBodyAccJerk-std()-X
##1            0.01111695             0.1212507            -0.5229487            -0.8996332             -0.937485            -0.9235514           -0.9244291
##  fBodyAccJerk-std()-Y fBodyAccJerk-std()-Z fBodyAccJerk-meanFreq()-X fBodyAccJerk-meanFreq()-Y fBodyAccJerk-meanFreq()-Z fBodyGyro-mean()-X fBodyGyro-mean()-Y
##1           -0.9432104           -0.9478915                 0.4510054                  0.137167                -0.1802991         -0.8235579          -0.807916
##  fBodyGyro-mean()-Z fBodyGyro-std()-X fBodyGyro-std()-Y fBodyGyro-std()-Z fBodyGyro-meanFreq()-X fBodyGyro-meanFreq()-Y fBodyGyro-meanFreq()-Z fBodyAccMag-mean()
##1         -0.9179126        -0.9032627         -0.822677        -0.9561651              0.1840346            -0.05932286              0.4381072         -0.7909464
##  fBodyAccMag-std() fBodyAccMag-meanFreq() fBodyBodyAccJerkMag-mean() fBodyBodyAccJerkMag-std() fBodyBodyAccJerkMag-meanFreq() fBodyBodyGyroMag-mean()
##1         -0.711074             -0.4834525                 -0.8950612                -0.8963596                    -0.03535579                -0.77061
##  fBodyBodyGyroMag-std() fBodyBodyGyroMag-meanFreq() fBodyBodyGyroJerkMag-mean() fBodyBodyGyroJerkMag-std() fBodyBodyGyroJerkMag-meanFreq()
##1             -0.7971128                  -0.0473913                  -0.8901655                 -0.9073076                      0.07164545


# Load activity labels 
## Append another column for activity label equal to the value of 1st column in Y_test
Y_test[,2] = activity_labels[Y_test[,1]] 

## Add labels to Y_test
names(Y_test) = c("Activity_ID", "Activity_Label") 

## Add Labels to subject_test
names(subject_test) = "subject" 

# Bind data 
# Combine all the test data - subject_test,Y_test and X_test into one.
test_data <- cbind(as.data.table(subject_test), y_test, X_test) 

# Load and process X_train & y_train data. 

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt") 
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt") 
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") 

## Label the X_train data with the features.
names(X_train) = features$V2

# Extract only (those columns where) for the mean and standard deviation for each measurement. 

X_train = X_train[,intrst_features] 

# Load activity data 
## Append another column for activity label equal to the value of 1st column in Y_train
Y_train[,2] = activity_labels[y_train[,1]] 

## Add labels to Y_train
names(Y_train) = c("Activity_ID", "Activity_Label") 

## Add Labels to subject_train
names(subject_train) = "subject" 

# Bind data 
# Combine all the test data - subject_train,Y_train and X_train into one.
train_data <- cbind(as.data.table(subject_train), y_train, X_train) 

# Merge test and train data 
data = rbind(test_data, train_data) 

id_labels   = c("subject", "Activity_ID", "Activity_Label") 
data_labels = setdiff(colnames(data), id_labels) 
melt_data      = melt(data, id = id_labels, measure.vars = data_labels) 

# Apply mean function to dataset using dcast function 
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean) 
write.table(tidy_data, file = "./tidy_data.txt",row.names = FALSE) 
