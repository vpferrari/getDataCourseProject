# Getting and Cleaning Data Course Project

## 1. Introduction

This 'README' file aims to provide basic information about how to use 'run_analysis.R' file presented in this repository in order to reproduce the steps to achieve the tidy data proposed by the Coursera's Getting and Cleaning Data Course Project.

This readme will set the stage for the following topics:

- *Section 2. Assumptions:* how to set the working directory and place the data to be checked by the script.
- *Section 3. Files: * a description of files used by the script and also where you may find information about variables in the Code Book
- *Section 4. the run_analysis.R script:* how to execute run_analysis.R script in your workstation and some highlights to clarify how it works.

Enjoy!

## 2. Assumptions

### 2.1 Working Directory
In order to run successfully you must place both script and data in a working directory. The script will be at the "root folder" of your working directory.  It is important to notice it is not in the scope of the script to download the files to you. Instead, data must be placed as a subfolder of the main direcotry and it MUST be named as "data". 

Optionally, this file and the codebook markdown files can be downloaded as well and it will share the same location as the run_analysis.R file.

So, you will end up with a working directory with the following structure:

**.<workingDirectory>:**
run_analysis.R
CodeBook.md
README.md

**./data**
activity_labels.txt
features_info.txt
features.txt
README.txt

**./data/test**
subject_test.txt
X_test.txt
y_test.txt

**./data/train**
subject_train.txt
X_train.txt
y_train.txt

The files listed in the 'data' folder above are *input files* that the script will use.

The *output file* will be just one: 'tidyData.txt' is a tab delimited text file, generated once the script runs successfully. **The output file is placed at the home working directory, alongside with the script file itself.**

### 2.2 Downloading Data

The Course Project asks you to download a zip file located at: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once you unzip it, you just need to **rename the original folder name to 'data'** and place the subfolder in your working directory. The only folder required to be renamed is the main one. Once you get familiar with the data (and they provide a complimentary README file for that) you will notice that 'train' and 'test' folders follows the above description on how to set your working directory.

## 3. Files

The main files in this repo and in the data folder are:

- **CodeBook.md**: Contains further information about how the raw data is structured, which components the script uses and a data dictionary with all information contained the Tidy Data.
- **run_analysis.R**: this is the R script that needs to be run in a R session.
- **README.md**: it is the file you are reading at this moment. Not to be confused with the README.txt file from the raw data.
- **./data/test/subject_test.txt**: A list file where each line contains one code to identify the person whom the measurement was made. This file contains the same amount of lines as other test data files. This file can be joined with 'X_test.txt'.
- **./data/test/y_test.txt**: A list file where each line contains the code for the activity. Later on the script will convert these numbers into actual descriptive data (e.g.: walking, walking upstairs, etc), defined in the 'activity_labels.txt' file.
- **./data/test/X_test.txt**: A file with all measurements described in features.txt. This is the test data itself, with all information retrieved and pre-processed by the reasearch team.
- **./data/train/subject_train.txt**: A list file where each line contains one code to identify the person whom the measurement was made. This file contains the same amount of lines as other test data files. This file can be joined with 'X_train.txt'.
- **./data/train/y_train.txt**: A list file where each line contains the code for the activity. Later on the script will convert these numbers into actual descriptive data (e.g.: walking, walking upstairs, etc), defined in the 'activity_labels.txt' file.
- **./data/train/X_train.txt**: A file with all measurements described in features.txt. This is the train data itself, with all information retrieved and pre-processed by the reasearch team.

## 4. run_analysis.R script

Once you know the files in this repo and in the data set, you may run the script in any R session. This script has been tested in R version 3.2.2 and it uses only base packages. In theory, 3.x versions should be fine.

### 4.1 Files into dataframes

The script will grab the 'data' direcotry and load the following files into dataframes:

- X_test.txt
- subject_test.txt
- y_test.txt
- X_train.txt
- subject_train.txt
- y_train.txt

First X_test.txt, subject_test.txt and y_test.txt are merged together using cbind() function. Same approach was used for X_train.txt, subject_train.txt and y_train.txt.

### 4.2 Merging data

The resulting data frames for test and train sets created in the previous section (4.1) will then be merged. The script uses rbind() function to do this. I decided not to merge() because I considered risky of using col names as parameters and as a result the script relies on the pre-established data structure provided by the raw data.

### 4.3 Cleaning data

In order to extract just the Mean and Standard Deviation columns the script uses the index columns of these to grab subsets of the merged data frame 'merge_df' and put them together in a third data frame named 'extracted_df' using cbind() function.

### 4.4 Renaming columns and activity names

Columns were then renamed by just changing the name(extracted_df) and assigning it a vector created with the c() function. A full list of the columns created and renamed plus their descriptions can be found in the CodeBook.md.

Activity names are simply switching values using a logical sequence of IF/ELSE IF assignments, using the following convention:

* 1 - WALKING
* 2 - WALKING_UPSTAIRS
* 3 - WALKING_DOWNSTAIRS
* 4 - SITTING
* 5 - STANDING
* 6 - LAYING

... which is essentially the expected content located in activity_labels.txt from the raw data.

### 4.5 Generating the Tidy Data

The requested Tidy Data is based on the mean of each variable (which are mean() and std() columns) grouped by activity per subject. In order to process this information the script uses the aggregate() function which splits the data into **subsets** and computes the **summary statistics** of the measurements. 

In this case, the subsets are based on the combined list of subject and activity. The summary statistics is the mean of each measurements per subset.

Finally, the data is exported using write.table, generating the file **tidyData.txt**. The separator is a tab delimiter (sep = "\t") and it can be viewed in any text editor (gedit, kate, textWrangler) or spreadsheet software (Libre Office Calc or Google Docs).

**Please, refer to CodeBook.md for further information about the generated Tidy Data.**










