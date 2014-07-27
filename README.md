README.md
========================================================

The following describes the steps involved in taking the raw unprocessed data files 
provided in the zip file and merging, cleaning and creating a tidy data set.

1. The user downloads and extracts the Zip file. Run_analysis.R should be placed in
the folder where the data exists. The user is responsible for changing to that working
directory.

2. The code loads 6 files, subject_test.txt, X_test.txt, y_test.txt, 
subject_train.txt, X_train.txt, y_train.txt and creates a testData and trainData 
table which are later merged together completing step 1. Features.txt is loaded as
ActivityLabels table.

3. ActivityLabels table is used to get the indices of the columns having the mean and
standard deviations. All other columns are removed from the merge data table
completing step 2. 

3. Activities in column 2 of the merge data changed from their numerical values to
meaningful character strings completing step 3

4. Names found in the ActivityLabels are used to rename the columns in the merge
data table completing step 4.

5. A tidy data set is created from the merged data by averageing the variables by
subject and activity. the tidy data set is subsequently exported into the current
working directory 

