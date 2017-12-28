## use library
library(data.table)
library(dplyr)

## read and clean variable names
setwd("~/Coursera/Data/UCI HAR Dataset")

ActNames <- fread("activity_labels.txt", sep = " ", col.names = c("activityid", "activityname"))
ActNames$activityname <- sub("_", "", ActNames$activityname)
ActNames$activityname <- tolower(ActNames$activityname)

FeatureNames <- fread("features.txt", sep = " ", col.names = c("featureid", "featurename"))
FeatureNames$featurename <- tolower(FeatureNames$featurename)


## read and merge testset
setwd("~/Coursera/Data/UCI HAR Dataset/test")
TE1 <- fread("subject_test.txt", col.names = "subjectid")
TE2 <- fread("y_test.txt", col.names = "activityid")
TE3 <- fread("X_test.txt", sep = " ", col.names = FeatureNames$featurename)
pattern <- c("*-mean", "*-std")
COLS <- as.vector(grepl(paste(pattern, collapse="|"), names(TE3)))
TE3 <- TE3[ , COLS, with=FALSE]

testset <- cbind(TE1, TE2, TE3)
##print(str(trainset,2))

## read and merge trainset
setwd("~/Coursera/Data/UCI HAR Dataset/train")
TR1 <- fread("subject_train.txt", col.names = "subjectid")
TR2 <- fread("y_train.txt", col.names = "activityid")
TR3 <- fread("X_train.txt", sep = " ", col.names = FeatureNames$featurename)
COLS <- as.vector(grepl(paste(pattern, collapse="|"), names(TR3)))
TR3 <- TR3[ , COLS, with=FALSE]

trainset <- cbind(TR1, TR2, TR3)

##combine train and testset and clean variablenames  
totalset <- rbind(testset, trainset)

names(totalset) <- gsub(x = names(totalset), pattern = "\\()", replacement = "")
totalset$activityid <- ActNames$activityname[match(totalset$activityid, ActNames$activityid)]

##create subset with averages
mynewset <- totalset %>% group_by(activityid, subjectid) %>% summarise_all(funs(mean))

      