#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#You should create one R script called run_analysis.R that does the following. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#download and unzip arxive
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="projectdataset.zip")
unzip("projectdataset.zip", overwrite=TRUE)

#read labels and features
setwd(".\\UCI HAR Dataset")
labels<-read.table("activity_labels.txt")
features<-read.table("features.txt")[,2]
names(labels)=c("labelid", "label")

#filter only data for mean and std 
StdMeanFeatures<-grepl("mean|std", features)

#read data train
setwd(".\\UCI HAR Dataset\\train")
xTrain<-read.table("x_train.txt")
labelTrain<-read.table("y_train.txt")
subjectTrain<-read.table("subject_train.txt")

names(xTrain)=features
names(labelTrain)="labelid"
names(subjectTrain)="subject"

dataTrain<-cbind(xTrain,labelTrain,subjectTrain)

dataTrain<-dataTrain[,StdMeanFeatures]

#read data test
setwd(".\\UCI HAR Dataset\\test")
xTest<-read.table("x_test.txt")
labelTest<-read.table("y_test.txt")
subjectTest<-read.table("subject_test.txt")

names(xTest)=features
names(labelTest)="labelid"
names(subjectTest)="subject"

dataTest<-cbind(xTest,labelTest,subjectTest)

dataTest<-dataTest[,StdMeanFeatures]

#Merges the training and the test sets to create one data set
datapreAll<-rbind(dataTest,dataTrain)
dataAll<-merge(labels,datapreAll, by=c("labelid"))

#create tidy data set with the average of each variable for each activity and each subject
library(reshape2)
varMelt <- melt(dataAll, id = c("label", "subject"))
tidy <- dcast(varMelt, label + subject ~ variable, mean)

#export tidy data set to file
write.table(tidy,file=".\\UCI HAR Dataset\\tidy.txt", row.names=FALSE)

#create CodeBook.md with all variable
write.table(names(tidy), file=".\\UCI HAR Dataset\\CodeBook.md", row.names=FALSE, quote=FALSE, col.names=FALSE, sep="\t")