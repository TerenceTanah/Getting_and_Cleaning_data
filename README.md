# Getting_and_Cleaning_data
Getting and Cleaning data - course project - run_analysis.R

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================

The required datasets are assumed to be located as follows:
./features.txt
./test/subject_test.txt
./test/X_test.txt
./test/y_test.txt
./train/subject_train.txt
./train/X_train.txt
./train/y_train.txt

The run_analysis.R script will do the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

run_analysis.R script does the above in the following steps:
1. read in the training and test datasets
2. merge the test and train datasets
3. import in the column names
4. assign column names to merged dataset
5. import and merge the test and train activity label codes from y_test.txt and y_train.txt files
6. add the corresponding activity label codes as a new column "Activity" in the merged dataset
7. import and merge the test and train subject codes from subject_test.txt and subject_train.txt files
8. add the corresponding subject codes as a new column "Subject" in the merged dataset
9. replace activity label codes with 'readable' activities
10.remove duplicated column names
11.select out columns for mean(), std(), Activity and Subject
12.use melt to reshape the dataset into Activity by Subject and get the average for each variable for each Activity and Subject
13.writes out the Tidied data into Tidy_Averages.txt
