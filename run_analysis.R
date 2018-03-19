alldata2 <- run_analysis()

library(dplyr)

# load the feature names
features <- read.table("UCI HAR Dataset/features.txt")
features <- features[,2]

# load the training dataset and labels
train_set <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features)
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

# merge into 1 training dataset
train <- tbl_df(data.frame(train_subject, train_labels, train_set))

# load the test dataset and labels
test_set <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features)
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# merge into 1 test dataset
test <- tbl_df(data.frame(test_subject, test_labels, test_set))

# merge the train and test datasets into one dataset
alldata <- rbind(train, test)

# get indices of all mean and standard deviation measurement columns
allmatch <- sort(c(grep("mean[^A-Za-z]", colnames(alldata)), grep("std[^A-Za-z]", colnames(alldata))))

# extract only mean and sd measurements and clean up typos
alldata <- alldata[, c(1,2,allmatch)]
colnames(alldata) <- gsub("BodyBody", "Body", colnames(alldata))

# name activities descriptively
alldata$activity <- gsub("1", "walking", alldata$activity)
alldata$activity <- gsub("2", "walking_upstairs", alldata$activity)
alldata$activity <- gsub("3", "walking_downstairs", alldata$activity)
alldata$activity <- gsub("4", "sitting", alldata$activity)
alldata$activity <- gsub("5", "standing", alldata$activity)
alldata$activity <- gsub("6", "laying", alldata$activity)

# group by activity and subject and get the mean for each column
alldata2 <- aggregate(. ~ subject + activity, alldata, mean)
alldata2 <- tbl_df(alldata2)

# write out tidy dataset with means
write.table(alldata2, file = "tidydata_means.txt", row.names = FALSE)
