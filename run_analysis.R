# Goal of this script:
# 1) merge the training and test sets to create one data set
# 2) Extract only the measurements on the mean and standard deviation
## for each measurement
# 3) Use descriptive activity names to name activities in the data set
# 4) Appropriately label the data set with descriptive variable names
# 5) From this labelled data set, create a second tidy data set 
## that contains average of each variable for each activity and subject

# Packages Desired - this section checks for and installs any necessary packages
# it also uses invisible to hide the library output
packages <- c("dplyr", "tidyr")
installed_packages<- packages %in% rownames(installed.packages())
if(any(installed_packages == FALSE)){
        install.packages(packages[!installed_packages])
}
invisible(lapply(packages, library, character.only = TRUE))

# Downloading and unzipping the data

ziploc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(ziploc, "UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip")


# The elements we will need:

# Categories and labels
# activity Label - will label column names and will establish key to use for later join/merge
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("key", "activity"))
# features - we will also give column names to this set
features <-read.table("UCI HAR Dataset/features.txt", col.names = c("n", "measurements"))

# Training data and keys
training_data <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$measurements)
# Training Labels
training_keys <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "key")

# Test data and keys
test_data <-read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$measurements)
# Test Labels 
test_keys <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "key")

# Subject data
# Subjects for Training
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
# Subjects for Tests
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

file.remove("UCI HAR Dataset.zip")

### TASK 1) merge the training and test sets to create one data set

# combine training and test data
combined_data <- rbind(training_data, test_data)

# combine training and test keys
combined_keys <- rbind(training_keys, test_keys)

# combine training and test subjects
combined_subjects <- rbind(subject_train, subject_test)

# combine all
total_data <- cbind(combined_subjects,combined_keys, combined_data)


###  TASK 2) Extract only the measurements on the mean and standard deviation for each measurement

# Extracting measurements on mean and standard deviation for each measurement
extracted_data <- total_data %>%
        select(subject, key, contains("mean"), contains("std"))

### TASK 3)  Use descriptive activity names to name activities in the data set

# Apply the activity labels  
extracted_data$key <- activity_labels[extracted_data$key, 2]

### TASK 4) Appropriately label the data set with descriptive variable names
# Using information from the features_info.txt file, create descriptive variable names for the data
# This could be condensed into shorter code but I believe a line by line lay out like this will make 
## future adjustments easier.
names(extracted_data)[2] = "activity"
names(extracted_data) <- gsub("\\.", "", names(extracted_data))
names(extracted_data) <- gsub("^t", "Time",names(extracted_data))
names(extracted_data) <- gsub("freq", "Frequency", names(extracted_data), ignore.case = TRUE)
names(extracted_data) <- gsub("^f", "Frequency", names(extracted_data))
names(extracted_data) <- gsub("BodyBody", "Body", names(extracted_data))
names(extracted_data) <- gsub("gravity","Gravity",names(extracted_data))
names(extracted_data) <- gsub("Acc", "Accelerometer",names(extracted_data))
names(extracted_data) <- gsub("Gyro", "Gyroscope",names(extracted_data))
names(extracted_data) <- gsub("Mag", "Magnitude",names(extracted_data))
names(extracted_data) <- gsub("mean", "Mean",names(extracted_data), ignore.case = TRUE)
names(extracted_data) <- gsub("std", "STD",names(extracted_data), ignore.case = TRUE)
names(extracted_data) <- gsub("angle", "Angle",names(extracted_data))
names(extracted_data) <- gsub("tBody", "TimeBody", names(extracted_data))

### TASK 5) From this labelled data set, create a second tidy data set 
## that contains average of each variable for each activity and subject
FinalProjectData <- extracted_data%>%
        group_by(subject, activity)%>%
        summarize_all(list(mean))
write.table(FinalProjectData, "FinalProjectData.txt", row.names = FALSE)