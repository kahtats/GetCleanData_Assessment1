# Code Book for Getting and Cleaning Data: Peer Assessment 1
Seah Kah Tat

## Introduction
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data

## Data Set Variables
The 561 variables in the original data consists of the following:
* Time domain signals (prefix 't' to denote time) in 3-axial raw signals (tAcc-XYZ and tGyro-XYZ) from the accelerometer and gyroscope.
* Body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) separated from acceleration signals
* Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ) derived in time from body linear acceleration and angular velocity
* Magnitude of these three-dimensional signals (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag) calculated using the Euclidean norm
* Frequency domain signals (fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag) derived by applying Fast Fourier Transform (FFT) to previously-mentioned signals

The set of variables that were estimated from these signals are: 
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors were also obtained by averaging the signals in a signal window sample. 

The complete list of variables of each feature vector is available in 'features.txt', with more details found in 'features_info.txt', in the original data.

Notes:
* Each value of each variable is normalized and bounded within [-1,1].  
* The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2). 
* The gyroscope units are in rad/seg. 

## Study Design
The run_analysis.R script performs the following steps to obtain and clean the data:

### 1. Download and Extract Original Data
The script first downloads the zip file from the source to the working directory and then unzips the data into the same directory.

### 2. Merge the training and test sets to create one data set
Next, the script reads in the data ('X-train.txt'), activity labels ('y-train.txt') and subject labels ('subject-train.txt') from the training set and store them in data frames `train.x`, `train.y` and `sub.train`. This is done similarly for the test set ('X-test.txt', 'y-test.txt' and 'subject-test.txt' to `test.x`, `test.y` and `sub.test` respectively). The data frames for training and test sets are then first column-binded separately in the order as stated previously before row-binding both resultant data frames into one data frame stored as `dataset`.

### 3. Extract only the mean and standard deviation for each measurement
To do this, The script first reads in the column number and names of the 561 variables from 'features.txt' and stores them in `feature` data frame, then subsets `feature` by excluding variables that do not contain 'mean' and 'std' in their variable names, as well as those that contain 'Freq' in their names, and stores them in `f.mean.std2` data frame. The set of column numbers remaining in `f.mean.std2`, together with '562' and '563' indicating the activity and subject label columns, are then used to subset `dataset` and the resulting data frame stored as `data.meanstd`.

### 4. Name the activities in the data set
The script reads in the activity names in 'activity_labels.txt' file and then replaces the activity labels in the activity label column in `data.meanstd` by creating a new column labelled 'Activity' and inputs the activity name that corresponds to the activity label in each row into the column. The activity label column is then deleted. 

### 5. Label the data set with descriptive variable names
Subsequently, the script edits the variable names stored in `f.mean.std2` by removing brackets in the names, followed by the word 'Body' in some variable names that repeats the word twice. The column names for `data.meanstd` are then renamed according to the column of variable names in `f.mean.std2`, plus 'Subject' and 'Activity'.

### 6. Create an independent tidy data set with the average of each variable for each activity and each subject
Finally, the script obtains the averages for each variable for each subject and each activity using the `ddply` function, with `ColMeans` function included as an input, and stores this data in `data.summ` data frame. An output of `data.summ` in text format is then produced using the `write.table` function.

## Code Book for 'tidydataset'
| Variable  | Description |
| :------------ | :------------ |
| Subject | Identifier for the subject who performed the activity for each window sample, its range is from 1 to 30 |
| Activity | Activity name for which the subject is tracked performing |
| tBodyAcc-mean-X | Mean of body acceleration time-domain signals in X-direction |
| tBodyAcc-mean-Y | Mean of body acceleration time-domain signals in Y-direction |
| tBodyAcc-mean-Z | Mean of body acceleration time-domain signals in Z-direction |
| tBodyAcc-std-X | Standard deviation of body acceleration time-domain signals in X-direction |
| tBodyAcc-std-Y | Standard deviation of body acceleration time-domain signals in Y-direction |
| tBodyAcc-std-Z | Standard deviation of body acceleration time-domain signals in Z-direction |
| tGravityAcc-mean-X | Mean of gravity acceleration time-domain signals in X-direction |
| tGravityAcc-mean-Y | Mean of gravity acceleration time-domain signals in X-direction |
| tGravityAcc-mean-Z | Mean of gravity acceleration time-domain signals in X-direction |
| tGravityAcc-std-X | Standard deviation of gravity acceleration time-domain signals in X-direction |
| tGravityAcc-std-Y | Standard deviation of gravity acceleration time-domain signals in Y-direction |
| tGravityAcc-std-Z | Standard deviation of gravity acceleration time-domain signals in Z-direction |
| tBodyAccJerk-mean-X | Mean of jerk for body acceleration time-domain signals in X-direction |
| tBodyAccJerk-mean-Y | Mean of jerk for body acceleration time-domain signals in Y-direction |
| tBodyAccJerk-mean-Z | Mean of jerk for body acceleration time-domain signals in Z-direction |
| tBodyAccJerk-std-X | Standard deviation of jerk for body acceleration time-domain signals in X-direction |
| tBodyAccJerk-std-Y | Standard deviation of jerk for body acceleration time-domain signals in X-direction |
| tBodyAccJerk-std-Z | Standard deviation of jerk for body acceleration time-domain signals in X-direction |
| tBodyGyro-mean-X | Mean of gyroscope time-domain signals in X-direction |
| tBodyGyro-mean-Y | Mean of gyroscope time-domain signals in Y-direction |
| tBodyGyro-mean-Z | Mean of gyroscope time-domain signals in Z-direction |
| tBodyGyro-std-X | Standard deviation of gyroscope time-domain signals in X-direction |
| tBodyGyro-std-Y | Standard deviation of gyroscope time-domain signals in Y-direction |
| tBodyGyro-std-Z | Standard deviation of gyroscope time-domain signals in Z-direction |
| tBodyGyroJerk-mean-X | Mean of jerk for gyroscope time-domain signals in X-direction |
| tBodyGyroJerk-mean-Y | Mean of jerk for gyroscope time-domain signals in Y-direction |
| tBodyGyroJerk-mean-Z | Mean of jerk for gyroscope time-domain signals in Z-direction |
| tBodyGyroJerk-std-X | Standard deviation of jerk for gyroscope time-domain signals in X-direction |
| tBodyGyroJerk-std-Y | Standard deviation of jerk for gyroscope time-domain signals in Y-direction |
| tBodyGyroJerk-std-Z | Standard deviation of jerk for gyroscope time-domain signals in Z-direction |
| tBodyAccMag-mean | Mean of body acceleration time-domain signals magnitude |
| tBodyAccMag-std | Standard deviation of body acceleration time-domain signals magnitude |
| tGravityAccMag-mean | Mean of gravity acceleration time-domain signals magnitude |
| tGravityAccMag-std | Standard deviation of gravity acceleration time-domain signals magnitude |
| tBodyAccJerkMag-mean | Mean of jerk for body acceleration time-domain signals magnitude |
| tBodyAccJerkMag-std | Standard deviation of jerk for body acceleration time-domain signals magnitude |
| tBodyGyroMag-mean | Mean of gyroscope time-domain signals magnitude |
| tBodyGyroMag-std | Standard deviation of gyroscope time-domain signals magnitude |
| tBodyGyroJerkMag-mean | Mean of jerk for gyroscope time-domain signals magnitude |
| tBodyGyroJerkMag-std | Standard deviation of jerk for gyroscope time-domain signals magnitude |
| fBodyAcc-mean-X | Mean of body acceleration frequency-domain signals in X-direction |
| fBodyAcc-mean-Y | Mean of body acceleration frequency-domain signals in Y-direction |
| fBodyAcc-mean-Z | Mean of body acceleration frequency-domain signals in Z-direction |
| fBodyAcc-std-X | Standard deviation of body acceleration frequency-domain signals in X-direction |
| fBodyAcc-std-Y | Standard deviation of body acceleration frequency-domain signals in Y-direction |
| fBodyAcc-std-Z | Standard deviation of body acceleration frequency-domain signals in Z-direction |
| fBodyAccJerk-mean-X | Mean of jerk for body acceleration frequency-domain signals in X-direction |
| fBodyAccJerk-mean-Y | Mean of jerk for body acceleration frequency-domain signals in Y-direction |
| fBodyAccJerk-mean-Z | Mean of jerk for body acceleration frequency-domain signals in Z-direction |
| fBodyAccJerk-std-X | Standard deviation of jerk for body acceleration frequency-domain signals in X-direction |
| fBodyAccJerk-std-Y | Standard deviation of jerk for body acceleration frequency-domain signals in Y-direction |
| fBodyAccJerk-std-Z | Standard deviation of jerk for body acceleration frequency-domain signals in Z-direction |
| fBodyGyro-mean-X | Mean of body gyroscope frequency-domain signals in X-direction |
| fBodyGyro-mean-Y | Mean of body gyroscope frequency-domain signals in Y-direction |
| fBodyGyro-mean-Z | Mean of body gyroscope frequency-domain signals in Z-direction |
| fBodyGyro-std-X | Standard deviation of body gyroscope frequency-domain signals in X-direction |
| fBodyGyro-std-Y | Standard deviation of body gyroscope frequency-domain signals in Y-direction |
| fBodyGyro-std-Z | Standard deviation of body gyroscope frequency-domain signals in Z-direction |
| fBodyAccMag-mean | Mean of body acceleration frequency-domain signals magnitude|
| fBodyAccMag-std | Standard deviation of body acceleration frequency-domain signals magnitude|
| fBodyAccJerkMag-mean | Mean of jerk for body acceleration frequency-domain signals magnitude|
| fBodyAccJerkMag-std | Standard deviation of jerk for body acceleration frequency-domain signals magnitude|
| fBodyGyroMag-mean | Mean of body gyroscope frequency-domain signals magnitude |
| fBodyGyroMag-std | Standard deviation of body gyroscope frequency-domain signals magnitude |
| fBodyGyroJerkMag-mean | Mean of jerk for  body gyroscope frequency-domain signals magnitude |
| fBodyGyroJerkMag-std | Standard deviation of jerk for body gyroscope frequency-domain signals magnitude |
