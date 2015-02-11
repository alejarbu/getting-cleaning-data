library(tidyr)
library(dplyr)
library(data.table)
library(reshape2)

############## Functions

# Merges the training and the test sets to create one data set And
# Extracts only the measurements on the mean and standard 
# deviation for each measurement. 
getFilteredDataToAnalysis<-function(){
  # Load subject  
  subject_train <- fread("UCI HAR Dataset/train/subject_train.txt")
  subject_test <- fread("UCI HAR Dataset/test/subject_test.txt")
  subject_data<-rbind(subject_train,subject_test)
  setnames(subject_data,1,"subject")
  
  # Load Y  
  y_train <- fread("UCI HAR Dataset/train/y_train.txt")
  y_test <- fread("UCI HAR Dataset/test/y_test.txt")
  y_data<-rbind(y_train,y_test)
  setnames(y_data,1,"activity")
  
  # Load X
  ###x_train <- fread(file) #Not working
  x_train <- data.table(read.table("UCI HAR Dataset/train/X_train.txt"))
  x_test <- data.table(read.table("UCI HAR Dataset/test/X_test.txt"))
  
  features <- fread("UCI HAR Dataset/features.txt")
  x_data<-rbind(x_train,x_test)
  setnames(x_data,1:561,features$V2)
  
  # Merges the sets and Reduce variables
  filtered_data<-cbind(select(x_data,contains("mean")),
  select(x_data,contains("std")))
  filtered_data<-select(filtered_data,-contains("meanFreq"))
  filtered_data<-select(filtered_data,-contains("angle"))
  
  cbind(subject_data,y_data,filtered_data)
}

# Appropriately labels the data set with descriptive variable names
renameColumns<-function(data){
  replacements <-list(c("-mean()","Mean"),
                      c("-std()","Std"),
                      c("BodyBody","Body")
  )
  tidy_names <- colnames(data)
  for(r in replacements){
    tidy_names <- gsub(r[1],r[2],tidy_names,fixed=TRUE) 
  }
  colnames(data) <- tidy_names
}


############## Start script

# Get the data
filteredData<-getFilteredDataToAnalysis()

# Uses descriptive activity names to name the activities in the data set
activities <- read.table("UCI HAR Dataset/activity_labels.txt")[,"V2"]
filteredData <- filteredData %>% mutate(activity=activities[activity])

# tidy vars names
renameColumns(filteredData)

#Write file
write.csv(filteredData, "finaldata.txt", row.names=FALSE)

# Data set with the average of each variable for each activity and each subject.
filteredData %>%
  gather(variable, value, -c(1,2)) %>%
  dcast(activity + subject ~ variable, mean) %>%
  write.csv("finaldata_summarized.txt", row.names=FALSE)
