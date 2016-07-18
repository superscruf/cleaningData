CodeBook

This is a code book that describes the variables, data, and transformations or other work done in run_analysis.R
to clean up the data.

The data source

Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Data Set Information

Data originally comes from the UCI Machine Learning Repository. Those data are divided into training and test groups, and
this script merges the two sets into a single superset. I took the "x" data, which is the largest, and appended columns for
the "Y" data, activity ID's, activity names, and subject ID's. I used the data from activity_labels.txt (in the original
data set) and built up a conversion from activityID, which was in the data tables, to the more descriptive label that matches
the ID. I also appended the "subject" data column. I performed these activites for both test groups before merging them with
rbind(). 

The script extracts only the data colums containing the mean and standard deviation for each element, so the final output
is quite a bit smaller than the original data. 

The script also assigns meaningful names to all of the columns; the map for this is in the file "features.txt," which gives
descriptive names for the columns in the order in which they appear in the data set. 

Finally, this script produces a "tidy" data set, which contains only the averages for each activity and test subject, and groups these
average values by activity and subject. The tidy data set is exported to a separate file, tidyTable.csv, for reference.

Variables:
xTest
yTest
subjTest

xTrain
yTrain
subjTrain

The above 6 variables store the user generated data. 

activityLabels
myFeatures

These two variables also store information from the original data set; however, these provide lookup tables that help cross reference terse number labels with meaningful descriptive text for all data in the set.

xTestColCount
yTestColCount
training
allData
nColAllData

These four variables store the results of computations and manipulations on the underlying data set. The two "TestColCount" variables are used to programatically assign values of the training and allData tables, based on the content of the data. If the content were to change at some point in the future, most of the work of keeping up with the changes is handled by the code; it is however incumbent on a human programmer to get in and make sure that any columns get descriptive text; the program will work without it, but the default naming convention makes it difficult to understand what is going on by simply looking at the data.

nColAllData finds the number of columns in the allData table; we need this so we know where to start appending other columns when we need to, like the descriptive columns for activityID, activity, and subject. 

meanAndStdDev
This variable goes over the "features" file for it's first step, which is to collect only information whose column names include Means or Standard Deviations. To these data, I append the activityID and it's human-friendly counterpart activity, as well as the subject ID (there were 30 human test subjects participating in this study, so the subjects column stores values from 1 to 30).

tidyTable
This is the name of the final output table of tidy data. Each row is a single observation, each column is a single variable. All information is stored in a single dataset. These 3 criteria are the hallmarks of tidy data. When data are tidy, this allows programmers to safely make assumptions about the tools one can successfully apply against the data.
