# Assumes package is already installed...
library(data.table)
library(plyr)

# Ingest data
xTest <- read.csv("Dataset/test/X_test.txt", sep="", header=FALSE)
yTest <- read.csv("Dataset/test/Y_test.txt", sep="", header=FALSE)
subjTest <- read.csv("dataset/test/subject_test.txt", sep="", header=FALSE)

xTrain <- read.csv("Dataset/train/X_train.txt", sep="", header=FALSE)
yTrain <- read.csv("Dataset/train/Y_train.txt", sep="", header=FALSE)
subjTrain <- read.csv("Dataset/train/subject_train.txt", sep="", header=FALSE)

# setup
# activityLabels and myFeatures will give me some sensible
# column names to work with
activityLabels <- read.csv("Dataset/activity_labels.txt", sep="", header=FALSE)
myFeatures <- read.csv("Dataset/features.txt", sep="", header=FALSE)[,2]


# Now extend yTest and yTrain to include a column of meaningful activity names
# Just trying out different ways to do the same thing, so the lines look different
yTestActivity <- factor(yTest[,1],levels=activityLabels[,1],labels=activityLabels[,2])
yTrainActivity <- factor(yTrain$V1,levels=activityLabels$V1,labels=activityLabels$V2)


# Give the sets matching names
names(xTest) <- myFeatures
names(xTrain) <- myFeatures
names(yTest) <- ("activityID")
names(yTrain) <- ("activityID")
names(subjTest) <- ("subject")
names(subjTrain) <- ("subject")
names(yTestActivity) <- ("activity")
names(yTrainActivity) <- ("activity")

# 1. Merge Training and Test sets
# Concatenate sets first, so the column counts all match. Need this to rbind()
# Left the code flexible in case the number of columns in Y and Subject ever change,
# but I admit I get cheesy when I just plain named 'em in the previous step. So,
# updates have to happen in 2 places if these ever change!
xTestColCount <- ncol(xTest)
yTestColCount <- ncol(yTest)
testing <- xTest
testing[,xTestColCount+1] <- yTest
testing[,xTestColCount+2] <- yTestActivity
testing[,xTestColCount+yTestColCount+2] <- subjTest

xTrainColCount <- ncol(xTrain)
yTrainColCount <- ncol(yTrain)
training <- xTrain
training[, xTrainColCount+1] <- yTrain
training[, xTrainColCount+2] <- yTrainActivity
training[, xTrainColCount+yTrainColCount+2] <- subjTrain


# Then bind the now-matching sets
allData <- rbind(testing, training)

# 2. Extract Mean and Std Dev measurements
# First, build the base part, with all the values of interest
meanAndStdDev <- grep(".*mean.*|.*std.*", myFeatures, ignore.case=TRUE)

# Now add in the columns we got from appending Y and Subj
meanAndStdDev <- c(meanAndStdDev, (xTestColCount+1):(xTestColCount+yTestColCount+2))

# Now extract
allData <- allData[meanAndStdDev]
nColAllData <- ncol(allData)

# 3. Uses descriptive activity names - this line corrects the column name.
# Actual activity performed a few lines above, where the activityID is bumped
# up against the activity name in the activity labels table.
names(allData)[nColAllData-1] <- "activity"

# 4. Appropriately labels the data set with descriptive variable names.
# Please look back up in the setup section, where myFeatures is built up, and then
# later used to rename the column headings from "V_whatever" to the column names
# found in myFeatures (from features.txt)

# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

# Setup - takes the number of columns from nColAllData above, and subtracts the last
# three columns, which are descriptive labels rather than numeric values where 
# averaging makes sense.

nColAllData <- nColAllData - 3
tidyTable <- ddply(allData, .(subject, activity), function(x) colMeans(x[, 1:nColAllData]))
write.table(tidyTable, "tidyTable.csv", row.name=FALSE)
