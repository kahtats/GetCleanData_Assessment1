run_analysis <- function() {
    
    # download zip file
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    dest <- paste(getwd(), "/getdata-projectfiles-UCI HAR Dataset.zip", sep = "")
    if(!file.exists(dest)) download.file(fileUrl, dest)
    
    # unzip the file
    filename <- paste(getwd(), "/UCI HAR Dataset/", sep = "")
    if(!file.exists(filename)) unzip(dest)
    
    # 1. Merge the training and the test sets to create one data set
    train.x <- read.table(paste(getwd(), "/UCI HAR Dataset/train/X_train.txt", 
                                sep = ""))
    train.y <- read.table(paste(getwd(), "/UCI HAR Dataset/train/y_train.txt", 
                                sep = ""))
    sub.train <- read.table(paste(getwd(), "/UCI HAR Dataset/train/subject_train.txt"
                                  , sep = ""))
    test.x <- read.table(paste(getwd(), "/UCI HAR Dataset/test/X_test.txt", sep = ""))
    test.y <- read.table(paste(getwd(), "/UCI HAR Dataset/test/y_test.txt", sep = ""))
    sub.test <- read.table(paste(getwd(), "/UCI HAR Dataset/test/subject_test.txt", 
                                 sep = ""))
    
    dataset <- rbind(cbind(train.x, train.y, sub.train), 
                     cbind(test.x, test.y, sub.test))
    
    # 2. Extract only the measurements on the mean and standard deviation 
    # for each measurement
    
    # filter out feature names not containing 'mean' and 'std'
    features <- read.table(paste(getwd(), "/UCI HAR Dataset/features.txt", sep = ""))
    string <- c("mean", "std")
    f.mean.std <- subset(features, grepl(paste(string, collapse= "|"), features$V2))
    f.mean.std2 <- subset(f.mean.std, !grepl("Freq", f.mean.std$V2)) # remove 'freq'
    
    # extract only mean and std measurements from dataset
    col.num <- c(as.vector(f.mean_std2$V1), 562, 563) # with subject & activity labels
    data.meanstd <- subset(dataset, select = col.num)
    
    # 3. Name the activities in the data set
    act.label <- read.table(paste(getwd(), "/UCI HAR Dataset/activity_labels.txt", 
                                  sep = ""))
    data.meanstd$Activity <- act.label[data.meanstd$V1.1,"V2"]
    data.meanstd <- subset(data.meanstd, select = -67) # delete column V1.1
    
    # 4. Label the data set with descriptive variable names
    f.mean.std2$V2 <- gsub("\\(|\\)", "", f.mean.std2$V2) # remove brackets
    f.mean.std2$V2 <- gsub("^fBodyBody", "fBody", f.mean.std2$V2)
    colnames(data.meanstd) <- c(as.vector(f.mean.std2$V2), "Subject", "Activity")
    
    # 5. create an independent tidy data set with the average of each variable 
    # for each activity and each subject
    require(plyr)
    data.summ <- ddply(data.meanstd, c("Subject", "Activity"), 
                       function(x) colMeans(x[as.vector(f.mean.std2$V2)]))
    write.table(data.summ, file = "tidydataset.txt", row.name = FALSE)
}