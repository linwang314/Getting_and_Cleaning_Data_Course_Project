# Code Book
This code book describes the variables in the tidy data, the original source data set, and any work or transformations I have performed to clean up the original data and obtain the tidy data.  
## Tidy Data Information  
This data set contains the average of each variable for each activity and each subject. There are 180 records for the 30 subjects that each performed 6 activities. The records are first grouped by subject and then by activity. The first 2 variables identifies which subject and activity, and all the other 86 variables are the average of measurements (mean or standard deviation).   
### Identifiers  
* subjectID - ID of the test subject (range: 1-30)
* activity - type of activity (6 levels) 
  * WALKING - value 1
  * WALKING_UPSTAIRS - value 2
  * WALKING_DOWNSTAIRS - value 3
  * SITTING - value 4
  * STANDING - value 5
  * LAYING - value 6  
### Measurements
In all these variable names, *'t'* stands for 'time', *'f'* for 'frequency', *'StdDev'* for 'standard deviation', *'acc'* for 'acceleration', *'Gyro'* for 'gyroscope', *'Mag'* for 'magnitude'.  
*tBodyAccMeanX
*tBodyAccMeanY
*tBodyAccMeanZ
*tGravityAccMeanX
*tGravityAccMeanY
*tGravityAccMeanZ
*tBodyAccJerkMeanX
*tBodyAccJerkMeanY
*tBodyAccJerkMeanZ
*tBodyGyroMeanX
*tBodyGyroMeanY
*tBodyGyroMeanZ
*tBodyGyroJerkMeanX
*tBodyGyroJerkMeanY
*tBodyGyroJerkMeanZ
*tBodyAccMagMean
*tGravityAccMagMean
*tBodyAccJerkMagMean
*tBodyGyroMagMean
*tBodyGyroJerkMagMean
*fBodyAccMeanX
*fBodyAccMeanY
*fBodyAccMeanZ
*fBodyAccMeanFreqX
*fBodyAccMeanFreqY
*fBodyAccMeanFreqZ
*fBodyAccJerkMeanX
*fBodyAccJerkMeanY
*fBodyAccJerkMeanZ
*fBodyAccJerkMeanFreqX
*fBodyAccJerkMeanFreqY
*fBodyAccJerkMeanFreqZ
*fBodyGyroMeanX
*fBodyGyroMeanY
*fBodyGyroMeanZ
*fBodyGyroMeanFreqX
*fBodyGyroMeanFreqY
*fBodyGyroMeanFreqZ
*fBodyAccMagMean
*fBodyAccMagMeanFreq
*fBodyBodyAccJerkMagMean
*fBodyBodyAccJerkMagMeanFreq
*fBodyBodyGyroMagMean
*fBodyBodyGyroMagMeanFreq
*fBodyBodyGyroJerkMagMean
*fBodyBodyGyroJerkMagMeanFreq
*angletBodyAccMeangravity
*angletBodyAccJerkMeangravityMean
*angletBodyGyroMeangravityMean
*angletBodyGyroJerkMeangravityMean	
*angleXgravityMean
*angleYgravityMean
*angleZgravityMean
*tBodyAccStdDevX
*tBodyAccStdDevY
*tBodyAccStdDevZ
*tGravityAccStdDevX
*tGravityAccStdDevY
*tGravityAccStdDevZ
*tBodyAccJerkStdDevX
*tBodyAccJerkStdDevY
*tBodyAccJerkStdDevZ
*tBodyGyroStdDevX
*tBodyGyroStdDevY
*tBodyGyroStdDevZ
*tBodyGyroJerkStdDevX
*tBodyGyroJerkStdDevY
*tBodyGyroJerkStdDevZ
*tBodyAccMagStdDev
*tGravityAccMagStdDev
*tBodyAccJerkMagStdDev
*tBodyGyroMagStdDev
*tBodyGyroJerkMagStdDev
*fBodyAccStdDevX
*fBodyAccStdDevY
*fBodyAccStdDevZ
*fBodyAccJerkStdDevX
*fBodyAccJerkStdDevY
*fBodyAccJerkStdDevZ
*fBodyGyroStdDevX
*fBodyGyroStdDevY
*fBodyGyroStdDevZ
*fBodyAccMagStdDev
*fBodyBodyAccJerkMagStdDev
*fBodyBodyGyroMagStdDev
*fBodyBodyGyroJerkMagStdDev  
##Source Data Information  
### Background  
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record in the dataset it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Activity label.
* An identifier of the subject who carried out the experiment.  

### Files included
* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all 561 features.
* 'activity_labels.txt': Links the 6 class labels with their activity name.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity (total of 21 subjects). 
* 'train/X_train.txt': Training measurement set.
* 'train/y_train.txt': Training activity labels.
* 'test/subject_train.txt': Each row identifies the subject who performed the activity (total of 9 subjects). 
* 'test/X_test.txt': Test measurement set.
* 'test/y_test.txt': Test activity labels.  

## Work and Transformation Performed  
### Set up
1. download and the source data if it is not already in the current working directory
2. load 'dplyr' package for cleaning  
### Merge test and training data sets
1. read activity label and features into R 
2. read test and training data into R
3. combine subject, activity labels and measurements within test and training data sets
4. merge test and data sets in Step 3 into one data frame  
### Extract mean and standard deviation measurements
1. transform the data frame into 'tbl_df' object
2. select columns that are mean or standard deviation together with subject and activity columns  
### Use descriptive activity names and variable names
1. replace activity ID with activity names with factor() function
2. update other variable names with descriptive terms  
### Create the final tidy data set
1. arrange and group the current data set first by subject and then by activity
2. calculate the average of each variable for each subject and each activity with summarize_each() function
3. create a tidy text file with write.table() function
