gettingandcleaningdata
======================

Course Project for Coursera - Getting and cleaning data

This is the readme file for the course project for Getting and Cleaning Data course from coursera.

The data file for this project can be downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

run_analysis.R performs the following - 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In detailed - 

1. The analysis makes use of data.table and reshape packages.
2. First activity data is loaded from activity_labels.txt
3. activity_labels extracts the second column from activity Data. This contains the activity labels.
4. Next, features are loaded from features.txt
5. Next, the second column from features are searched for mean and std using grepl command.
6. We get the interested features in the variable intrst_features.
7. X_test - data from X_test.txt
8. Y_test - data from Y_test.txt
9. subject_test - data from subject_test.txt
10. Add the labels for features to X_test
11. Extract only those intesrest features (mean/std/freqMean) from X_test.
12. Add the acitivity label to Y_test for the correlating values.
13. Add labels to Y_test and subject_test.
14. combine X_test,Y_test and subject_test into test_data.
15. Repeat steps 7 through 14 for training data as well, train_data will have all the data from training.
16. Now combine all the rows from test_data and train_data using rbind function into data.
17. melt the data using ID values as subject, activity id, activity label. Use all others as measurements.
18. Use dcast function to get the tidy_data and write to tidy_data.txt
Detailed comments are included in run_analysis.R
