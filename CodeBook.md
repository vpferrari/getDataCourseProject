# Code Book

## 1. Raw Data Set
The original data set refers to experiments carried out with a group of 30 people (subjects) with an age between 18-49 years old. Regular activities were monitored by a smartphone (Samsung Galaxy S II). 3-axial acceleration were collected using the smartphone's embedded accelerometer and gyroscope.

Measurements were randomly partioned into two groups: 70% of it was selected for training data and 30% selected for test data.

For the tidy data processing, data source source is found at: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original source and further information on how the experiment was conducted can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The zip contains a README file and much of the information within this CodeBook is refered to this particular text file.

*Data Source Credit:*

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

### 1.1 Regular Activities
According to the data specs described in 'activity_labels.txt' file the possible activities in the experiment were:

* [1] - WALKING
* [2] - WALKING_UPSTAIRS
* [3] - WALKING_DOWNSTAIRS
* [4] - SITTING
* [5] - STANDING
* [6] - LAYING

All acceleration measurements made is referred to one of the activities above. One may notice later on this code book that the processed tidy data is arranged according to each of these by each subject of the experiment.

### 1.2 Measurements
Basically the data set presents measurements for Acceleration and Gyroscope. They were captured and filtered according to 'features_info.txt', as follows:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Linear acceleration and angular velocity were derived in time to (quoted from 'features_info.txt':

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Fast Fourier Transform (FFT) were applied to some of the signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag.

Based on this information, we can list the following features pattern in both test and train raw data, applied to three axis (X,Y,Z):

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

For each feature listed above the following variables were generated (taken from features_info.txt):

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
* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

The combination of variables and features creates a set of 561 columns, listed at 'features.txt' file.

## 2. Tidy Data

The intent of the Tidy Data is to present statistical information on the mean of all Mean ('mean()') and Standard Deviation ('std()') variables from the raw data and present them by activity and subject. It has been requested to present the variables in a meaningful way and acitivity must be presented with their descriptive names rather than code numbers.

In order to achive that one R script called run_analysis.R was created. It does the following:

* Step 1: Merges the training and the test sets to create one data set.
* Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
* Step 3: Uses descriptive activity names to name the activities in the data set
* Step 4: Appropriately labels the data set with descriptive variable names. 
* Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### 2.1 R Script
As mentioned before, such procedure described above is performed by run_analysis.R. **In order to work properly the script, have some important assumptions on how and where the data must be placed.** Such assumptions are described in details the Readme.md file in this very same GitHub repository.

### 2.2 Data Cleaning and Transformations

In order to merge the data as requested, basically two sub-steps were done:

* 1-1: For each data set (test and train) bind the columns for each set, activity and subjects. Each file was loaded into separated data frames using read.tables. Later, cbind was used to bind these columns; * Example: in order to bind columns for 'test', the files 'X_test.txt','subject_test.txt', and 'y_test.txt' had to be loaded into R, then cbind was used to generate a complete test data frame. *

* 1-2: Both 'test' and 'train' complete data frame were merged into one using rbind, which allowed all rows of one data frame to be appended to another resulting in a merged data frame.

Next step is to slice the data, creating a subset of intended columns. The measurements required by Step 2 refers to means and standard deviation. Since the columns order is set as the original files, the intended columns were defined and then extracted from the merged data frame. 

The columns were manually selected, and the criteria used was: all columns with names containing 'mean()', 'std()' and 'Mean' keywords. Columns containing 'angles' were excluded from this subset. 

With the subset data frame, columns were renamed (see Data Dictionary section below) and means of each measurements were calculated for each subject and activity using the aggregate function (see 'README.md' for further information).

## 3. Data Dictionary

The Tidy Data generated by the script will be created at the base directory with the name 'tidyData.csv' with all required information. The columns were renamed for clearance. Their actual meaning are listed below.

Column Name | Variable description
----------- | --------------------
subject | the subject (person) of the experiment
activity | activity type name
tBodyAccMean_X | Mean of Time Domain Body Acceleration Means in X axis
tBodyAccMean_Y | Mean of Time Domain Body Acceleration Means in Y axis
tBodyAccMean_Z | Mean of Time Domain Body Acceleration Means in Z axis
tBodyAccStd_X | Mean of Time Domain Body Acceleration Standard Deviation in X axis
tBodyAccStd_Y | Mean of Time Domain Body Acceleration Standard Deviation in Y axis
tBodyAccStd_Z | Mean of Time Domain Body Acceleration Standard Deviation in Z axis
tGravityAccMean_X | Mean of Time Domain Gravity Acceleration Means in X axis
tGravityAccMean_Y | Mean of Time Domain Gravity Acceleration Means in Y axis
tGravityAccMean_Z | Mean of Time Domain Gravity Acceleration Means in Z axis
tGravityAccStd_X | Mean of Time Domain Gravity Acceleration Standard Deviation in X axis
tGravityAccStd_Y | Mean of Time Domain Gravity Acceleration Standard Deviation in Y axis
tGravityAccStd_Z | Mean of Time Domain Gravity Acceleration Standard Deviation in Z axis
tBodyAccJerkMean_X | Mean of Time Domain Body Acceleration Jerk Signal Means in X axis
tBodyAccJerkMean_Y | Mean of Time Domain Body Acceleration Jerk Signal Means in Y axis
tBodyAccJerkMean_Z | Mean of Time Domain Body Acceleration Jerk Signal Means in Z axis
tBodyAccJerkStd_X | Mean of Time Domain Body Acceleration Jerk Signal Standard Deviation in X axis
tBodyAccJerkStd_Y | Mean of Time Domain Body Acceleration Jerk Signal Standard Deviation in Y axis
tBodyAccJerkStd_Z | Mean of Time Domain Body Acceleration Jerk Signal Standard Deviation in Z axis
tBodyGyroMean_X | Mean of Time Domain Body Gyroscope Means in X axis
tBodyGyroMean_Y | Mean of Time Domain Body Gyroscope Means in Y axis
tBodyGyroMean_Z | Mean of Time Domain Body Gyroscope Means in Z axis
tBodyGyroStd_X | Mean of Time Domain Body Gyroscope Standard Deviation in X axis
tBodyGyroStd_Y | Mean of Time Domain Body Gyroscope Standard Deviation in Y axis
tBodyGyroStd_Z | Mean of Time Domain Body Gyroscope Standard Deviation in Z axis
tBodyGyroJerkMean_X | Mean of Time Domain Body Gyroscope Jerk Signal Means in X axis
tBodyGyroJerkMean_Y | Mean of Time Domain Body Gyroscope Jerk Signal Means in Y axis
tBodyGyroJerkMean_Z | Mean of Time Domain Body Gyroscope Jerk Signal Means in Z axis
tBodyGyroJerkStd_X | Mean of Time Domain Body Gyroscope Jerk Signal Standard Deviation in X axis
tBodyGyroJerkStd_Y | Mean of Time Domain Body Gyroscope Jerk Signal Standard Deviation in Y axis
tBodyGyroJerkStd()_Z | Mean of Time Domain Body Gyroscope Jerk Signal Standard Deviation in Z axis
tBodyAccMagMean | Mean of Time Domain Body Acceleration Magnitude Means
tBodyAccMagStd | Mean of Time Domain Body Acceleration Magnitude Standard Deviation
tGravityAccMagMean | Mean of Time Domain Gravity Acceleration Magnitude Means
tGravityAccMagStd | Mean of Time Domain Gravity Acceleration Magnitude Standard Deviations
tBodyAccJerkMagMean | Mean of Time Domain Body Acceleration Jerk Signal Magnitude Means
tBodyAccJerkMagStd | Mean of Time Domain Body Acceleration Jerk Signal Magnitude Standard Deviation
tBodyGyroMagMean | Mean of Time Domain Body Gyroscope Magnitude Means
tBodyGyroMagStd | Mean of Time Domain Body Gyroscope Magnitude Standard Deviations
tBodyGyroJerkMagMean | Mean of Time Domain Body Gyroscope Jerk Signal Magnitude Means
tBodyGyroJerkMagStd | Mean of Time Domain Body Gyroscope Jerk Signal Magnitude Standard Deviations
fBodyAccMean_X | Mean of Fast Fourier Transform Body Acceleration Means in X axis
fBodyAccMean_Y | Mean of Fast Fourier Transform Body Acceleration Means in Y axis
fBodyAccMean_Z | Mean of Fast Fourier Transform Body Acceleration Means in Z axis
fBodyAccStd_X | Mean of Fast Fourier Transform Body Acceleration Standard Deviation in X axis
fBodyAccStd_Y | Mean of Fast Fourier Transform Body Acceleration Standard Deviation in Y axis
fBodyAccStd_Z | Mean of Fast Fourier Transform Body Acceleration Standard Deviation in Z axis
fBodyAccMeanFreq_X | Mean of Fast Fourier Transform Acceleration Frequency Means in X axis
fBodyAccMeanFreq_Y | Mean of Fast Fourier Transform Acceleration Frequency Means in Y axis
fBodyAccMeanFreq_Z | Mean of Fast Fourier Transform Acceleration Frequency Means in Z axis
fBodyAccJerkMean_X | Mean of Fast Fourier Transform Body Acceleration Jerk Signal Means in X axis
fBodyAccJerkMean_Y | Mean of Fast Fourier Transform Body Acceleration Jerk Signal Means in Y axis
fBodyAccJerkMean_Z | Mean of Fast Fourier Transform Body Acceleration Jerk Signal Means in Z axis
fBodyAccJerkStd_X | Mean of Fast Fourier Transform Body Acceleration Jerk Signal Standard Deviation in X axis
fBodyAccJerkStd_Y | Mean of Fast Fourier Transform Body Acceleration Jerk Signal Standard Deviation in Y axis
fBodyAccJerkStd_Z | Mean of Fast Fourier Transform Body Acceleration Jerk Signal Standard Deviation in Z axis
fBodyAccJerkMeanFreq_X | Mean of Fast Fourier Transform Body Acceleration Jerk Signal Frequency Means in X axis
fBodyAccJerkMeanFreq_Y | Mean of Fast Fourier Transform Body Acceleration Jerk Signal Frequency Means in Y axis
fBodyAccJerkMeanFreq_Z | Mean of Fast Fourier Transform Body Acceleration Jerk Signal Frequency Means in Z axis
fBodyGyroMean_X | Mean of Fast Fourier Transform Body Gyroscope Means in X axis
fBodyGyroMean_Y | Mean of Fast Fourier Transform Body Gyroscope Means in Y axis
fBodyGyroMean_Z | Mean of Fast Fourier Transform Body Gyroscope Means in Z axis
fBodyGyroStd_X | Mean of Fast Fourier Transform Body Gyroscope Standard Deviation in X axis
fBodyGyroStd_Y | Mean of Fast Fourier Transform Body Gyroscope Standard Deviation in Y axis
fBodyGyroStd_Z | Mean of Fast Fourier Transform Body Gyroscope Standard Deviation in Z axis
fBodyGyroMeanFreq_X | Mean of Fast Fourier Transform Body Gyroscope Frequency Means in X axis
fBodyGyroMeanFreq_Y | Mean of Fast Fourier Transform Body Gyroscope Frequency Means in Y axis
fBodyGyro-meanFreq_Z | Mean of Fast Fourier Transform Body Gyroscope Frequency Means in Y axis
fBodyAccMagMean | Mean of Fast Fourier Transform Body Acceleration Magnitude Means
fBodyAccMagStd | Mean of Fast Fourier Transform Gravity Acceleration Magnitude Standard Deviations
fBodyAccMagMeanFreq | Mean of Fast Fourier Transform Body Gyroscope Jerk Signal Standard Deviation in Z axis
fBodyBodyAccJerkMagMean | Mean of Fast Fourier Transform Body Acceleration Magnitude Means
fBodyBodyAccJerkMagStd | Mean of Fast Fourier Transform Body Acceleration Magnitude Standard Deviation
fBodyBodyAccJerkMagMeanFreq | Mean of Fast Fourier Transform Acceleration Jerk Signal Frequency Means
fBodyBodyGyroMagMean | Mean of Fast Fourier Transform Gyroscope Magnitude Means
fBodyBodyGyroMagStd | Mean of Fast Fourier Transform Gyroscope Magnitude Standard Deviantions
fBodyBodyGyroMagMeanFreq | Mean of Fast Fourier Transform Gyroscope Magnitude Frequency Means
fBodyBodyGyroJerkMagMean | Mean of Fast Fourier Transform Gyroscope Jerk Signals Magnitude Means
fBodyBodyGyroJerkMagStd | Mean of Fast Fourier Transform Gyroscope Jerk Signals Magnitude Standard Deviations
fBodyBodyGyroJerkMagMeanFreq | Mean of Fast Fourier Transform Gyroscope Jerk Signal Magnitude Frequency Means
