library(dplyr)
filename<-"dataset.zip"
if (!file.exists(filename)){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",filename,method="curl")
}
if (!file.exists("UCI HAR Dataset")){
  unzip("E:/Data Science/Getting and Cleaning data/Assignment/dataset.zip",exdir="./Assignment")
}
path <- file.path("./Assignment" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)
files
dataActivityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)
dataSubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)
dataFeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)
names(dataSubject)<-c("Subject")
names(dataActivity)<- c("Activity")
dataFeaturesNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)
#Merges the training and the test sets to create one data set.
reqddataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames<-c(as.character(reqddataFeaturesNames), "Subject", "Activity" )
Data<-subset(Data,select=selectedNames)
#Extracts only the measurements on the mean and standard deviation for each measurement.
activities <- read.table(file.path(path,"activity_labels.txt"),col.names = c("code", "activity"))
Data$code <- activities[Data$code,2]
names(Data)[2]="Activity"
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("tBody", "TimeBody", names(Data))
names(Data)<-gsub("-mean()", "Mean", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-std()", "STD", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-freq()", "Frequency", names(Data), ignore.case = TRUE)
names(Data)<-gsub("angle", "Angle", names(Data))
names(Data)<-gsub("gravity", "Gravity", names(Data))
Data_final<-aggregate(. ~Subject + Activity, Data, mean)
Data_final<-Data_final[order(Data_final$Subject,Data_final$Activity),]
write.table(Data_final, file = "tidydata.txt",row.name=FALSE)


