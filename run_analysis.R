# run_analysis.R: This script does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# Step 1: import the data files into memory:

# first, the 'test' data package:
test_x <- "./data/test/X_test.txt"
subject_test_file <- "./data/test/subject_test.txt"
test_y <- "./data/test/y_test.txt"

test_df <- read.table(test_x, header = FALSE)
test_subject_df <- read.table(subject_test_file, col.names = "subject", header = FALSE)
test_y_df <- read.table(test_y, col.names = "activity", header = FALSE)

test_df <- cbind(test_df, test_subject_df, test_y_df)

# second, the 'train' data package: 
train_x <- "./data/train/X_train.txt"
subject_train_file <- "./data/train/subject_train.txt"
train_y <- "./data/train/y_train.txt"

train_df <- read.table(train_x, header = FALSE)
train_subject_df <- read.table(subject_train_file, col.names = "subject", header = FALSE)
train_y_df <- read.table(train_y, col.names = "activity", header = FALSE)

train_df <- cbind(train_df, train_subject_df, train_y_df)

merged_df <- rbind(train_df,test_df)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
extracted_df <- cbind(merged_df$subject, merged_df$activity,
                      merged_df[,1:6], merged_df[,41:46], 
                      merged_df[,81:86], merged_df[,121:126], 
                      merged_df[,161:166], merged_df[,201:202], 
                      merged_df[,214:215], merged_df[,227:228], 
                      merged_df[,240:241], merged_df[,253:254], 
                      merged_df[,266:271], merged_df[,294:296], 
                      merged_df[,345:350], merged_df[,373:375], 
                      merged_df[,424:429], merged_df[,452:454], 
                      merged_df[,503:504], merged_df$V513, 
                      merged_df[,516:517], merged_df$V526, 
                      merged_df[,529:530], merged_df$V539, 
                      merged_df[,542:543], merged_df$V552)

# Steps 3 and 4: use descriptive activity labels and rename cols to meaninful variable names

# rename column names:
names(extracted_df) <- c("subject","activity", "tBodyAccMean_X", "tBodyAccMean_Y",
                         "tBodyAccMean_Z", "tBodyAccStd_X", "tBodyAccStd_Y", "tBodyAccStd_Z",
                         "tGravityAccMean_X", "tGravityAccMean_Y", "tGravityAccMean_Z", "tGravityAccStd_X",
                         "tGravityAccStd_Y", "tGravityAccStd_Z", "tBodyAccJerkMean_X", "tBodyAccJerkMean_Y",
                         "tBodyAccJerkMean_Z", "tBodyAccJerkStd_X", "tBodyAccJerkStd_Y", "tBodyAccJerkStd_Z",
                         "tBodyGyroMean_X", "tBodyGyroMean_Y", "tBodyGyroMean_Z", "tBodyGyroStd_X",
                         "tBodyGyroStd_Y", "tBodyGyroStd_Z", "tBodyGyroJerkMean_X", "tBodyGyroJerkMean_Y", 
                         "tBodyGyroJerkMean_Z", "tBodyGyroJerkStd_X",
                         "tBodyGyroJerkStd_Y", "tBodyGyroJerkStd()_Z",
                         "tBodyAccMagMean", "tBodyAccMagStd",
                         "tGravityAccMagMean", "tGravityAccMagStd",
                         "tBodyAccJerkMagMean", "tBodyAccJerkMagStd",
                         "tBodyGyroMagMean", "tBodyGyroMagStd",
                         "tBodyGyroJerkMagMean", "tBodyGyroJerkMagStd",
                         "fBodyAccMean_X", "fBodyAccMean_Y",
                         "fBodyAccMean_Z", "fBodyAccStd_X",
                         "fBodyAccStd_Y", "fBodyAccStd_Z",
                         "fBodyAccMeanFreq_X", "fBodyAccMeanFreq_Y",
                         "fBodyAccMeanFreq_Z", "fBodyAccJerkMean_X",
                         "fBodyAccJerkMean_Y", "fBodyAccJerkMean_Z",
                         "fBodyAccJerkStd_X", "fBodyAccJerkStd_Y",
                         "fBodyAccJerkStd_Z", "fBodyAccJerkMeanFreq_X",
                         "fBodyAccJerkMeanFreq_Y", "fBodyAccJerkMeanFreq_Z",
                         "fBodyGyroMean_X", "fBodyGyroMean_Y",
                         "fBodyGyroMean_Z", "fBodyGyroStd_X",
                         "fBodyGyroStd_Y", "fBodyGyroStd_Z",
                         "fBodyGyroMeanFreq_X", "fBodyGyroMeanFreq_Y",
                         "fBodyGyro-meanFreq_Z", "fBodyAccMagMean",
                         "fBodyAccMagStd", "fBodyAccMagMeanFreq",
                         "fBodyBodyAccJerkMagMean", "fBodyBodyAccJerkMagStd", 
                         "fBodyBodyAccJerkMagMeanFreq", "fBodyBodyGyroMagMean",
                         "fBodyBodyGyroMagStd", "fBodyBodyGyroMagMeanFreq",
                         "fBodyBodyGyroJerkMagMean", "fBodyBodyGyroJerkMagStd",
                         "fBodyBodyGyroJerkMagMeanFreq")

# renaming activity labels:
for(i in 1:nrow(extracted_df)){
    if(extracted_df[i,"activity"] == 1){
        extracted_df[i,"activity"] <- "WALKING"
    } else if (extracted_df[i,"activity"] == 2){
        extracted_df[i,"activity"] <- "WALKING_UPSTAIRS"
    } else if (extracted_df[i,"activity"] == 3){
        extracted_df[i,"activity"] <- "WALKING_DOWNSTAIRS"
    } else if (extracted_df[i,"activity"] == 4){
        extracted_df[i,"activity"] <- "SITTING"
    } else if (extracted_df[i,"activity"] == 5){
        extracted_df[i,"activity"] <- "STANDING"
    } else if (extracted_df[i,"activity"] == 6){
        extracted_df[i,"activity"] <- "LAYING"
    }
}

# step 5: creates independent tidy data set with the average of each variable for each activity and each subject.
processedDataSet <- aggregate(extracted_df[,3:ncol(extracted_df)], by = list(extracted_df$subject, extracted_df$activity), FUN = mean)

names(processedDataSet)[1:2] <- c("subject","activity")


write.table(file = "tidyData.txt", processedDataSet[order(processedDataSet$subject, processedDataSet$activity),],
            sep = "\t", row.names = FALSE)
