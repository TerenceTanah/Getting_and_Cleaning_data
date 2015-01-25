## run_analysis.R does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject. 

## read in the training and test datasets
library(dplyr)
dTest<-read.table("test/X_test.txt")
dTrain<-read.table("train/X_train.txt")

## merge the test and train datasets
dAll<-rbind(dTest, dTrain)

## import in the column names
dNames<-read.table("features.txt")

## assign column names to merged dataset
vNames<-dNames$V2
names(dAll)<-vNames

## import and merge the test and train activity label codes
dy_test<-read.table("test/y_test.txt")
dy_train<-read.table("train/y_train.txt")
dy_testtrain<-rbind(dy_test,dy_train)
names(dy_testtrain)<-"Activity"
## add the corresponding activity label codes as a new column "Activity"
## in the merged dataset
dAll<-cbind(dAll,dy_testtrain)

## import and merge the test and train subject codes
dsubj_test<-read.table("test/subject_test.txt")
dsubj_train<-read.table("train/subject_train.txt")
dsubj_testtrain<-rbind(dsubj_test,dsubj_train)
names(dsubj_testtrain)<-"Subject"
## add the corresponding subject codes as a new column "subject"
## in the merged dataset
dAll<-cbind(dAll, dsubj_testtrain)

## replace activity label codes with 'readable' activities
dAll[dAll$Activity==1,"Activity"]="WALKING"
dAll[dAll$Activity==2,"Activity"]="WALKING_UPSTAIRS"
dAll[dAll$Activity==3,"Activity"]="WALKING_DOWNSTAIRS"
dAll[dAll$Activity==4,"Activity"]="SITTING"
dAll[dAll$Activity==5,"Activity"]="STANDING"
dAll[dAll$Activity==6,"Activity"]="LAYING"

## remove dupplicated column names
dAllUnique<-dAll[,unique(colnames(dAll))]

## select columns for mean() and std() and Activity
dTidy<-select(dAllUnique, contains("mean()"), contains("std()"), matches("Activity"), matches("Subject"))

## use melt to reshape the dataset into Activity by Subject
library(reshape2)
dTidyMelt<-melt(dTidy,id=c("Activity","Subject"),na.rm=TRUE)

## get the average for each variable for each Activity and Subject
dTidyF<-dcast(dTidyMelt, Activity + Subject ~ variable, mean)

write.table(dTidyF, file="Tidy_Averages.txt", row.names=FALSE)