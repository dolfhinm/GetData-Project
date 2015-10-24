#You should create one R script called run_analysis.R that does the following. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps on working script
1. download and unzip archive
2. read labels and features
3. remember only data for mean and std 
4. read data train, name variable and filter data for mean and std
5. read data test, name variable and filter data for mean and std
6. Merges the training and the test sets to create one data set
7. create tidy data set with the average of each variable for each activity and each subject
8. export tidy data set to file
9. create CodeBook.md with all variable