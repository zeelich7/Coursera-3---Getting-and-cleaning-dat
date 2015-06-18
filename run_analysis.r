library(plyr)

# Step 1
# Merge the training and test sets to create one data set
features_train <- read.table("./train/X_train.txt")
features_test <- read.table("./test/X_test.txt")
activity_train <- read.table("./train/y_train.txt")
activity_test <- read.table("./test/y_test.txt")
subject_train <- read.table("./train/subject_train.txt")
subject_test <- read.table("./test/subject_test.txt")

# create Features data set
features_data <- rbind(features_train, features_test)

# create Activity data set
activity_data <- rbind(activity_train, activity_test)

# create Subject data set
subject_data <- rbind(subject_train, subject_test)


# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement

# read features list
features <- read.table("features.txt")

# get columns numbers of columns with mean() or std() in their names
mean_and_std_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

# get subset of features_dates with the desired columns
features_data <- features_data[, mean_and_std_features]

# update the column names
names(features_data) <- features[mean_and_std_features, 2]


# Step 3
# Use descriptive activity names to name the activities in the data set

#read activitiy labels
activity_labels <- read.table("activity_labels.txt")

# update values with correct activity names
activity_data[, 1] <- activity_labels[activity_data[, 1], 2]

# update column name
names(activity_data) <- "activity"

# correct column name
names(subject_data) <- "subject"


# Step 4
# Appropriately label the data set with descriptive variable names

# join all the data into a single data set
combined_data <- cbind(features_data, activity_data, subject_data)
names(combined_data)<-gsub("^t", "time", names(combined_data))
names(combined_data)<-gsub("^f", "frequency", names(combined_data))
names(combined_data)<-gsub("Acc", "Accelerometer", names(combined_data))
names(combined_data)<-gsub("Gyro", "Gyroscope", names(combined_data))
names(combined_data)<-gsub("Mag", "Magnitude", names(combined_data))
names(combined_data)<-gsub("BodyBody", "Body", names(combined_data))

# Step 5
# Create a second, independent tidy data set with the average of each variable for each activity and each subject

#Last two columns are Activity & Subject
average_per_sub_activity <- ddply(combined_data, .(activity, subject), function(x) colMeans(x[, 1:66]))
#Write output file
write.table(average_per_sub_activity, "averages_per_act_per_sub.txt", row.name=FALSE)
