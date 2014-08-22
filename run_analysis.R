### PRE-PROCESSING
### Load data from zip file and setup the variables in R

# general parameters
save_intermediated = FALSE #set to TRUE if you want to save intermediate results to hard disk. 

# get working directory
dirCurrent = getwd()

# download and unzip data
fileSource = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileDest = paste(dirCurrent, "UCI_HAR_dataset.zip", sep="/")
download.file(fileSource, destfile=fileDest, method="curl")
unzip(fileDest, exdir=dirCurrent)

# set the required directories
dirData = paste(dirCurrent, "UCI HAR Dataset", sep="/")
dirTrain = paste(dirData, "train", sep="/")
dirTest = paste(dirData, "test", sep="/")

# read general data
setwd(dirData)
activity_labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("features.txt")

# read data from train directory
setwd(dirTrain)
X_train <-  read.table("X_train.txt", col.names = features$V2, check.names=FALSE)
y_train <-  read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

# read data from test directory
setwd(dirTest)
X_test <-  read.table("X_test.txt", col.names = features$V2, check.names=FALSE)
y_test <-  read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")

# move back to main dir
setwd(dirCurrent)

### PROBLEM 1:
### Merges the training and the test sets to create one data set:
X_total <- rbind(X_train, X_test)
y_total <- rbind(y_train, y_test)
subject_total <- rbind(subject_train, subject_test)
# write to file
if (save_intermediated==TRUE) write.table(X_total, file="X_total.txt")
if (save_intermediated==TRUE) write.table(y_total, file="y_total.txt")
if (save_intermediated==TRUE) write.table(subject_total, file="subject_total.txt")


### PROBLEM 2
### Extracts only the measurements on the mean and standard deviation for each measurement:
str_mean <- "mean()"
str_std <- "std()"
# check for mean() and std() strings in columns names
filters <- c(grep(str_mean,names(X_total)), grep(str_std, names(X_total)))
X_filtered <- X_total[filters]
# write to file
if (save_intermediated==TRUE) write.table(X_filtered, file="X_filtered.txt")
if (save_intermediated==TRUE) write.table(y_total, file="y_filtered.txt")

### PROBLEM 3
### Uses descriptive activity names to name the activities in the data set:

# I am using the followgin library in order to lookup the table since it is much easier and faster
if("qdapTools" %in% rownames(installed.packages())==FALSE) {install.package("qdapTools")}
library(qdapTools) 
y_total_labelled <- lookup(y_total$V1,activity_labels[,1:2])


### PROBLEM 4
### Appropriately labels the data set with descriptive variable names
data <- cbind(y_total_labelled, X_filtered)
colnames(data)[1] <- "activity" #change label of the first column (the activities)
if (save_intermediated==TRUE) write.table(X_filtered, file="dataset_labelled_and_filtered.txt")

### PROBLEM 5
### Creates a second, independent tidy data set with the average of each variable for each activity and each subject
if("reshape2" %in% rownames(installed.packages())==FALSE) {install.package("reshape2")}
library(reshape2)

data <- cbind(y_total_labelled, subject_total, X_filtered)
colnames(data)[1] <- "activity" #change label of the first column (the activities)
colnames(data)[2] <- "subjects" #change label of second column (the subjects)
if (save_intermediated==T)write.table(X_filtered, file="dataset_label_subjects_filtered.txt")

melt_data = melt(data, id.var = c("activity", "subjects"))
final_data = dcast(melt_data, subjects + activity ~ variable, mean)

# save to file
write.table(final_data, file="final_data.txt", row.name=FALSE)

print("End of Assignment. The final data are stored in file final_data.txt", quote=FALSE)
