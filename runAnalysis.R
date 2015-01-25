#load relavant files into R environment neme columns descriptively
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt");
colnames(activity_labels) <- make.names(c("activity.id","activity"),unique=TRUE);

features<- read.table("./UCI HAR Dataset/features.txt");
colnames(features) <- make.names(c("feature.id","feature"),unique=TRUE);

#loading contents of test directory
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt");
colnames(subject_test) <- make.names("subject.id", unique=TRUE);

x_test <- read.table("./UCI HAR Dataset/./test/X_test.txt");
colnames(x_test) <- make.names(features$feature, unique=TRUE);

y_test<-read.table("./UCI HAR Dataset/test/y_test.txt");
colnames(y_test) <- make.names("activity", unique=TRUE);

#binding test data
test_data <- cbind(subject_test,x_test,y_test);


#loading contents of train directory
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt");
colnames(subject_train) <- make.names("subject.id", unique=TRUE);

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt");
colnames(x_train) <- make.names(features$feature, unique=TRUE);

y_train<-read.table("./UCI HAR Dataset/train/y_train.txt");
colnames(y_train) <- make.names("activity", unique=TRUE);

train_data <- cbind(subject_train, x_train, y_train);

#combine train_data and test_data to a single structure
dataset <- rbind(test_data,train_data);
#reorder dataset according to subject_id attribute
dataset <- dataset[order(dataset$subject.id),  ];

#labeling activities (factors) of the whole dataset
dataset$activity <- factor(dataset$activity, label=activity_labels$activity)

#mean and standard deviation extraction 
##dataset$mean <- rowMeans(dataset[,2:562])
##dataset$stdev <- as.numeric(apply(dataset[,2:562],1,sd))
tidy.columns <- c(grep("subject.id",names(dataset)),grep("activity",names(dataset)),grep("std",names(dataset)),grep("mean",names(dataset)))
norrow.tidyset <- dataset[,tidy.columns]

library(data.table)
library(dplyr)
narrow.tidyset.data.table <- data.table(norrow.tidyset)
bySubjectsActivities<-group_by(narrow.tidyset.data.table,subject.id,activity)
tidyset <- summarise_each(bySubjectsActivities,funs(mean,sd))

#fianly the tidy dataset is stored under the same repository
write.table(tidyset,file="tidyset.txt",row.names=FALSE)

