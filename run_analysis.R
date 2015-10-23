## set working directory and load necessary packages
setwd("./Getting and Cleaning Data/Course Project")
library(dplyr)
## download and unzip dataset if not available
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset.zip")) {
  download.file(fileUrl, destfile = "UCI HAR Dataset.zip")
}
if (!file.exists("UCI HAR Dataset")) {
  unzip("UCI HAR Dataset.zip")
}

#1. Merge the training and the test sets to create one data set
## read activity labels and features into R
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
names(activity_labels) <- c("activityID", "activity") 
## read test data into R
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
## read train data into R
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
## combine test data into one data frame
testdata <- cbind(subject_test, y_test, X_test)
names(testdata) <- c("subjectID", "activityID", features[ ,2])
## combine train data into one data frame
traindata <- cbind(subject_train, y_train, X_train)
names(traindata) <- c("subjectID", "activityID", features[ ,2])
## merge test and training data into one data set
merged_data <- rbind(testdata, traindata)

#2. Extracts only the measurements on the mean and standard deviation for each measurement
merged_data <- tbl_df(merged_data)
## remove columns with duplicate column names to avoid interference of use of select()
unique_data <- merged_data[ , !duplicated(colnames(merged_data))]
## extract the mean and standard deviation for each measurement
extracted_data <- select(unique_data, subjectID, activityID, contains("mean"), contains("std"))

#3. Uses descriptive activity names to name the activities in the data set
names(extracted_data)[2] <- "activity"
extracted_data$activity <- factor(extracted_data$activity, levels = activity_labels[ ,1], labels = activity_labels[ ,2])

#4. Appropriately labels the data set with descriptive variable names
variable_names <- names(extracted_data)
variable_names <- gsub("mean", "Mean", variable_names)
variable_names <- gsub("std", "StdDev", variable_names)
variable_names <- gsub("-", "", variable_names)
variable_names <- gsub(",", "", variable_names)
variable_names <- gsub("[()]", "", variable_names)
names(extracted_data) <- variable_names

#5. From the dataset in step 4 (extracted_data)  
##  creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- extracted_data %>%        ## use chaining operation for clarity
  arrange(subjectID, activity) %>%     ## order the observations first by subject and then by activity
  group_by(subjectID, activity) %>%    ## group the observations first by subject and then by activity
  summarize_each(funs(mean))           ## summarize_each can calculate mean for all columns by group

#6. Create a text file with the tidy data set in Step 5 (tidy_data)
tidy_data <- data.frame(tidy_data)
write.table(tidy_data, file = "tidydata.txt", quote = FALSE, row.names = FALSE, sep = "\t")
