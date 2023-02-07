rm(list=ls())\
library(utils)
unzip(zipfile="getdata_projectfiles_UCI HAR Dataset.zip")
features <- read.table("UCI HAR Dataset/features.txt",col.names = c('ID','Features'))
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c('ID','Features'))
#train data
X_train <-read.table('UCI HAR Dataset/train/X_train.txt')
names(X_train) <- features$Features
y_train <- read.table('UCI HAR Dataset/train/y_train.txt',col.names =c('ID'))

subject_train<-read.table('UCI HAR Dataset/train/subject_train.txt',col.names= c('Subjects'))


#test data
X_test <-read.table('UCI HAR Dataset/test/X_test.txt')
names(X_test) <- features$Features
y_test <- read.table('UCI HAR Dataset/test/y_test.txt',col.names =c('ID'))

subject_test<-read.table('UCI HAR Dataset/test/subject_test.txt',col.names= c('Subjects'))

#merge data
full_train <- cbind(y_train,subject_train,X_train)
full_test <- cbind(y_test,subject_test, X_test)

full <- rbind(full_train, full_test)

#chon thuoc tinh mean  va std
library(dplyr)

mean_features <-  full%>% select(ID,Subjects,names(full)[grep("mean\\(\\)", names(full))])
std_features <- full %>% select(names(full)[grep("std\\(\\)", names(full))])

new_data =  cbind(mean_features,std_features)
new_data <-merge(new_data,activity_label,by.x= 'ID', by.y ='ID')

colnames(new_data) <- sub(x=colnames(new_data),pattern = "^t", replacement="Time domain:")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "^f", replacement="Frequency domain:")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "-", replacement=",")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "mean\\(\\)", replacement="Mean Value")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "std\\(\\)", replacement="Standard Deviation Value")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "-X", replacement="On X Axis")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "-Y", replacement="On Y Axis")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "-Z", replacement="On Z Axis")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "AccJerk", replacement="acceleration jerk")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "Acc", replacement="acceleration")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "GyroJerk", replacement="angular velocity jerk")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "Gyro", replacement="angular velocity")
colnames(new_data) <- sub(x=colnames(new_data),pattern = "Mag", replacement="magnitude")

#tinh gia tri trung binh theo Activity va Subject
tidy <- aggregate(new_data[,3:68],list(new_data$ID, new_data$Subjects),FUN=mean)
write.csv(tidy,"tidy_data.csv",row.names = FALSE)
