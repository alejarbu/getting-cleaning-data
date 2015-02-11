Samsung wearable data set
=====================

Note: This code book was made by Alejandro Arroyave Buritica as course project code book for the coursera Getting and cleaning data course by jeff leek (getdata-011).

This code book describes the variables, the data and any transformations or work that was performed to clean up the Samsung wearable data set.

## Study Design

### Understanding the data
The raw data to be cleaned up represents data collected from the accelerometers from the Samsung Galaxy S smartphone.
* The data was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip,
* The description of the original data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.

Note: more info about files and experiments development, go to the ```README.txt``` file under ```UCI HAR Dataset``` folder.

### Processing the data

To make more modular the process of clean up the data, it was defined two functions ( ```getFilteredDataToAnalysis()``` and ```renameColumns(data)``` ) 
and one instructions set at the end of the file, separating the script functionality in blocks
for ease understanding and comprehension.

#### Instructions block
This block invoke all the required functions to obtain the two project output data sets. To acomplish this goal the script does:

1. Get the filtered data set obtained from the ```getFilteredDataToAnalysis()``` function.
2. Uses descriptive activity names to name the activities in the data set.
3. Rename the filtered data set columns names to be more readable with the ```renameColumns(data)``` function.
4. Write the first file ```finaldata.txt``` described in the code book section.
5. Generated a second data set with the average of each variable for each activity and each subject.
6. Write this second data set in ```finaldata_summarized.txt``` file, also described in the code book section.

#### ```getFilteredDataToAnalysis()``` function
This function Merges the training and the test sets to create one data set and
extracts only the measurements on the mean and standard deviation for each measurement. 
To acomplish this goal the function does:

1. Load subject from the test and training files.
2. Load Y from the test and training files.
3. Load X from the test and training files.
4. Read the features from the ```features.txt``` to rename all the x columns.
5. Merges the sets and reduce the variables to only the mean and standard deviation for each measurement.

#### ```renameColumns(data)``` function
This function expects the ```data``` parameter wich represents the data set to be processed. This function do not return anything.
This function rename the data set column names with names more readable.
To acomplish this goal the function uses the [gsub] function to find a replace specifics chars inside de columns names.

[gsub]:http://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html

## Code Book
This project generates two output files ```finaldata.txt``` and ```finaldata_summarized.txt```.

### ```finaldata.txt``` 
This is a CSV file which contains the data set corresponding to the first four project requirements with only the measurements on the mean and standard deviation for each measurement.

This data set contains 68 variables and 10299 observations.

The variables are:

1. Activity: Descriptive label of activity
2. Subject: Test subject id

Variables 3 to 68 are features which ones are described in the ```features_info.txt``` file under ```UCI HAR Dataset``` folder.

### ```finaldata_summarized.txt``` 
This is a CSV file which contains the independent tidy data set with the average of each variable for each activity and each subject.

This data set contains 68 variables and 180 observations.

The variables are:

1. Activity: Descriptive label of activity
2. Subject: Test subject id

Variables 3 to 68 are features which ones are described in the ```features_info.txt``` file under ```UCI HAR Dataset``` folder.

