Getting and cleaning data course project
=====================

Note: This project was developed by Alejandro Arroyave Buritica as assigment for the coursera Getting and cleaning data course by jeff leek (getdata-011). 

The purpose of this project is to prepare tidy data that can be used for later analysis with the following requirements:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to run the script
1. Download the ```run_analysis.R``` script and copy it in the parent folder of UCI HAR Dataset, then set the parent folder as your working directory using ```setwd()``` function.
  The directory structure have to look similar to:

        parent folder/
          -> UCI HAR Dataset/
          -> run_analysis.R
2.  Run ```source("run_analysis.R")```, then it will generate two new files ```finaldata.txt``` and ```finaldata_summarized.txt``` in your working directory.

## What do you get from this script?
This script will generate two new files ```finaldata.txt``` and ```finaldata_summarized.txt``` in your working directory.

* ```finaldata.txt``` is a CSV file which contains the data set corresponding to the first four project requirements with only the measurements on the mean and standard deviation for each measurement.
* ```finaldata_summarized.txt``` is a CSV file which contains the independent tidy data set with the average of each variable for each activity and each subject.
