<h1>Introduction</h1>
The script run_analysis does the 5 steps from the project description
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

<h1>Variables</h1>
Information about the variables in the data set not contained in the tidy data.

features_train, features_test, activity_train, activity_test, subject_train, subject_test are data frames used to store the data from the data files
features_data, activity_data, subject_data contain the merged data frames
combined_data contains the final merged data for features activity and subject

average_per_sub_activity is the final data.frame that hold the averages of all the activities by activity and by subject. Constructed via ddply by applying the colMeans function to the features columns.
Information about the summary choices you made
