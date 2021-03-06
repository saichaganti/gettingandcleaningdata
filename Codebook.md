This is the code book that the variables, the data, and any transformations or work that you performed to clean up the data.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 



Need to perform the following - 
 • run_analysis.R that does the following. - 
 • Merges the training and the test sets to create one data set.
 • Extracts only the measurements on the mean and standard deviation for each measurement. 
 • Uses descriptive activity names to name the activities in the data set
 • Appropriately labels the data set with descriptive variable names. 
 • From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 The data source
 •The dataset is available for download from
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
 •Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
 • 'README.txt'
 • 'features_info.txt': Shows information about the variables used on the feature vector.
 • 'features.txt': List of all features.
 • 'activity_labels.txt': Links the class labels with their activity name.
 • 'train/X_train.txt': Training set.
 • 'train/y_train.txt': Training labels.
 • 'test/X_test.txt': Test set.
 • 'test/y_test.txt': Test labels.
 
The following files are available for the train and test data. Their descriptions are equivalent.
 • 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

 • 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

 • 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

 • 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
 
Transformation details
 
How  run_analysis.R  implements the above steps:
 •Require  reshape2  and  data.table  libraries.
 •Retrieve activity labels
 •Retrieve interested features which are mean and std(freqMean is also included)
 •Load test data and label the test data with the features.
 •Load train data and label the train data with the features.
 •Extract the mean and standard deviation column names and data.
 •Process the data. There are two parts processing test and train data respectively.
 •Merge data set.

Variables used in run_analysis - 

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