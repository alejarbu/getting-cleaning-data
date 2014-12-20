library(tidyr)
library(dplyr)
library(data.table)

#############################
# LOAD SUBJECT
#############################

file<-"D:\\UCI HAR Dataset\\train\\subject_train.txt"
subject_train <- fread(file)
setnames(subject_train,1,"subject")

file<-"D:\\UCI HAR Dataset\\test\\subject_test.txt"
subject_test <- fread(file)
setnames(subject_test,1,"subject")

subject_data<-rbind(subject_train,subject_test)
remove("subject_train")
remove("subject_test")

#############################
# LOAD Y
#############################

file<-"D:\\UCI HAR Dataset\\train\\y_train.txt"
y_train <- fread(file)
setnames(y_train,1,"activity")

file<-"D:\\UCI HAR Dataset\\test\\y_test.txt"
y_test <- fread(file)
setnames(y_test,1,"activity")

y_data<-rbind(y_train,y_test)
remove("y_train")
remove("y_test")

#############################
# LOAD X
#############################

file<-"D:\\UCI HAR Dataset\\train\\X_train.txt"
#x_train <- fread(file) #Not working
x_train <- data.table(read.table(file))

file<-"D:\\UCI HAR Dataset\\test\\X_test.txt"
x_test <- data.table(read.table(file))

file<-"D:\\UCI HAR Dataset\\features.txt"
features <- fread(file)
setnames(x_train,1:561,features$V2)
setnames(x_test,1:561,features$V2)
remove("features")

x_data<-rbind(x_train,x_test)
remove("x_train")
remove("x_test")

#############################
# Merges the training and the test sets to create one data set And
# Extracts only the measurements on the mean and standard 
# deviation for each measurement. 
#############################

filtered_data<-cbind(select(x_data,contains("mean")),
select(x_data,contains("std")))
filtered_data<-select(filtered_data,-contains("meanFreq"))
filtered_data<-select(filtered_data,-contains("angle"))

final_data<-cbind(subject_data,y_data,filtered_data)

#############################
# Uses descriptive activity names to name the activities 
# in the data set
#############################

activities<-c('WALKING',
              'WALKING_UPSTAIRS',
              'WALKING_DOWNSTAIRS',
              'SITTING',
              'STANDING',
              'LAYING')

final_data<-mutate(final_data,activity=activities[activity])

#############################
# Appropriately labels the data set with descriptive variable names
#############################


#############################
# From the data set in step 4, creates a second, independent
# tidy data set with the average of each variable for each activity
# and each subject.
#############################

final_data[,mean('tBodyAcc-mean()-X',na.rm = TRUE),by=list(activity,subject)]

final_data %>%
  group_by(activity,subject) %>%
  summarize(mean('tBodyAcc-mean()-X',na.rm = TRUE)) %>%
  print
