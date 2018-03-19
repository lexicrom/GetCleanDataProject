description of variables (and what happens to them) in run_Analysis:
features: names of all of the vairables given in the train and test datasets
  - only selected the names, since they were initially loaded in from the text file with numbered rows
train_set: all of the data from X_train.txt, with labels for each column from features
train_labels: activity labels for every row in train_set
train_subject: subject labels for every row in train set
train: data frame containing subject, activity, and all train data
test_set: all of the data from X_test.txt, with labels for each column from features
test_labels: activity labels for every row in test_set
test_subject: subject labels for every row in test set
test: data frame containing subject, activity, and all test data
alldata: data frame containing both training and testing data
  - gets filtered to only contain columns reflecting means or standard deviations
  - activity labels get renamed from numbers to actual activities (walking, sitting, etc)
allmatch: indices of all columns reflecting means or standard deviations of measurements

alldata2: data frame containg the means of each column from alldata, grouped by both subject and activity
