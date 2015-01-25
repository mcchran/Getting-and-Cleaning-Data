####This is the the recipie of the data anlaysis that I performed####

**Hint:** First of all **runAnalysis.R** must be placed under the same directory
with the **UCI HAR Dataset** in order to run properly. Moreover packet **dplyr** and **data.table** are required. A .txt file named
*tidyse.txt* is returned in the same directory.

Step 1: loading related files into R environment neme columns descriptively
<pre><code>
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt");
colnames(activity_labels) <- make.names(c("activity.id","activity"),unique=TRUE);
features<- read.table("./UCI HAR Dataset/features.txt");
colnames(features) <- make.names(c("feature.id","feature"),unique=TRUE);
</code></pre>

Step 2: loading contents of test directory
<pre><code>
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt");
colnames(subject_test) <- make.names("subject.id", unique=TRUE);
x_test <- read.table("./UCI HAR Dataset/./test/X_test.txt");
colnames(x_test) <- make.names(features$feature, unique=TRUE);
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt");
colnames(y_test) <- make.names("activity", unique=TRUE);
</code></pre>

Step 3: binding test data to a single data frame
<pre><code>
test_data <- cbind(subject_test,x_test,y_test);
</code></pre>

Step 4: loading contents of train directory to a single data frame
<pre><code>
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt");
colnames(subject_train) <- make.names("subject.id", unique=TRUE);
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt");
colnames(x_train) <- make.names(features$feature, unique=TRUE);
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt");
colnames(y_train) <- make.names("activity", unique=TRUE);
train_data <- cbind(subject_train, x_train, y_train);
</code></pre>

Step 5: combining train data and test data to a single structure and reorder
<pre><code>
dataset <- rbind(test_data,train_data);
dataset <- dataset[order(dataset$subject.id),  ];
</code></pre>

Step 6: labeling activities (factors) of the whole dataset
<pre><code>
dataset$activity <- factor(dataset$activity, label=activity_labels$activity)
</code></pre>

Step 7: mean and standard deviation feature extraction 
<pre><code>
tidy.columns <- c(grep("subject.id",names(dataset)),grep("activity",names(dataset)),
    grep("std",names(dataset)),grep("mean",names(dataset)))
norrow.tidyset <- dataset[,tidy.columns]
</code></pre>

Step 8: mean and standard deviation calculation 
<pre><code>
library(data.table)
library(dplyr)
narrow.tidyset.data.table <- data.table(norrow.tidyset)
bySubjectsActivities<-group_by(narrow.tidyset.data.table,subject.id,activity)
tidyset <- summarise_each(bySubjectsActivities,funs(mean,sd))
</code></pre>

Step 9: fianly the tidy dataset is stored under the same repository
<pre><code>
write.table(tidyset,file="tidyset.txt",row.names=FALSE)
</code></pre>