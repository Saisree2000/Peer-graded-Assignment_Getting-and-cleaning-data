---
title: "codebook"
author: "Sai Sree"
date: "24/06/2020"
output: html_document
---

run_analysis.R file performs the following operations as mentioned in the question.

1. **Downloads the dataset**  
  + The given zipfile is downloaded using download.file(). Later, it is         unzipped and extracted into UCI HAR Dataset.  
2. **Assigns Variables**  
  + ```dataActivityTest <- test/Y_test.txt ```: 2947 rows, 1 column  
    *contains test data of activities’code labels*  
  + ```dataActivityTrain <-  train/Y_train.txt``` : 7352 rows, 1 column  
    *contains train data of activities’code labels*  
  + ```dataSubjectTrain <- train/subject_train.txt``` : 7352 rows, 1 column  
    *contains train data of 21/30 volunteer subjects being observed*  
  + ```dataSubjectTest <- test/subject_test.txt``` : 2947 rows, 1 column  
    *contains test data of 9/30 volunteer test subjects being observed*  
  + ```dataFeaturesTest <- test/X_test.txt``` : 2947 rows, 561 columns  
    *contains recorded features test data*  
  + ```dataFeaturesTrain <- train/X_train.txt```:7352 rows, 561 columns  
    *contains recorded features train data*  
  + ```dataFeaturesNames <- features.txt``` : 561 rows, 2 columns  
    *The features selected for this database come from the accelerometer and      gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ*  
  + ```activities <- activity_labels.txt```: 6 rows, 2 columns 
      *List of activities performed when the corresponding measurements were        taken and its codes (labels)*  
3. **Merges the training and test sets to create one dataset**
  + ```dataCombine <- cbind(dataSubject, dataActivity)```
      *Column binds the subject and activity data*
  + ```Data <- cbind(dataFeatures, dataCombine)```
      *Merges the training and test sets*
4. **Extracts only the measurements on the mean and standard deviation for each measurement**
  ```reqddataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]```    
```selectedNames<-c(as.character(reqddataFeaturesNames), "Subject", "Activity" )```   
```Data<-subset(Data,select=selectedNames)```    
5. **Uses descriptive activity names to name the activities in the data set**
  + *Entire numbers in ```code``` column of the ```Data``` replaced with corresponding activity taken from second column of the ```activities``` variable*  
6. **Appropriately labels the data set with descriptive variable names**  
  + ```code``` column in ```Data``` renamed into ```activities```  
  + All ```Acc``` in column’s name replaced by ```Accelerometer```  
  + All ```Gyro``` in column’s name replaced by ```Gyroscope```    
  + All ```BodyBody``` in column’s name replaced by ```Body```  
  + All ```Mag``` in column’s name replaced by ```Magnitude```  
  + All start with character ```f``` in column’s name replaced by ```Frequency```    
  + All start with character ```t``` in column’s name replaced by ```Time```  7. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
  + ```Data_final```, a tidy set with 10299 rows and 67 columns is created from ```Data``` taking the means of each variable for each activity and each subject, after groupped by subject and activity.  
  + ```Data_final``` is then exported to ```tidydata.txt``` file
