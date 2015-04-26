The data for this analysis are from the files:

	"subject_test.txt"  
	"y_test.txt"        
	"X_test.txt"        
	"subject_train.txt" 
	"y_train.txt"      
	"X_train.txt" 
	“activity_labels.txt”
	“features.txt” 

Downloadable from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data are from accelerometers from the Samsung Galaxy S smartphone which underwent tests performing six different activities performed by different test subjects.

“subject_test.txt” and “subject_train.txt” contain reference numbers for the subject.

"y_test.txt" "y_train.txt" contain a number corresponding to a particular activity as recorded in “activity_labels.txt” 

"X_test.txt"	"X_train.txt" contain the corresponding accelerometer data, the variable names are listed in “features.txt”

A more detailed description of the data is included in the accompanying files downloadable in the link above. All of the above files must be placed in the working directory with “run_analysis.R” for the script to work. Also, the dplyr and reshape2 packages must be installed for the script to run (they will be activated by the script when it is run)

The script first reads the first six files and binds them together into a data table. It then extracts the accelerometer variables containing “mean” or “std” (as per the “features.txt” file) and puts them in a new data frame along with the subject and activity data in the first two rows.
The variable names are shifted to lower case and have the brackets and dashes removed. 
A new data frame is then created, melted and dcast so that it contains the mean of each accelerometer variable for each subject and activity. The script then writes out a file called “meanData.txt” containing this data frame using the write.table function. 

