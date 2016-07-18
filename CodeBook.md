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