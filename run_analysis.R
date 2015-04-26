run_analysis <- function() {
    
    #reading data in and binding them into a single table.
    #run_analysis.R must be saved in UCI HAR Dataset folder for file paths to be correct.

    files <- c("subject_test.txt","y_test.txt","X_test.txt",
               "subject_train.txt","y_train.txt","X_train.txt")
    print(files)

    data <- rbind(cbind(read.table(files[1]),read.table(files[2]),read.table(files[3])),
                 cbind(read.table(files[4]),read.table(files[5]),read.table(files[6])))

    #read in features to extract variable names containing "mean" or "stds"
    features <- read.table("features.txt")
    means <- grep("mean",features[[2]])
    stds <- grep("std",features[[2]])
    #creating index variable for variables containing "mean" or "stds"
    index <- c(means,stds)
    orderedIndex <- index[order(index)]
    relevantNames <- features[[2]][orderedIndex]
    #extracting only data from rows corresponding to vars containing "mean" or "std"
    newData <- data[,c(1,2,orderedIndex+2)]
    
    #renaming activity numbers with meaningful labels from activity_labels.txt
    library(dplyr)
    activities <- read.table("activity_labels.txt")
    #also removing underscores and capitalisation
    Activity_Label <- gsub("_","",tolower(activities[[2]][newData[[2]]])) 
    mutatedNewData <- mutate(newData,Activity_Label)
    #replacing column in data frame
    newData[[2]] <- mutatedNewData[[length(mutatedNewData)]]
    
    #naming columns with variable names from features.txt using index vector created earlier
    
    names(newData)[1] <- "subject"
    names(newData)[2] <- "activitylabel"
    #editing out capitals, dashes and brackets as per notes on tidy data in lectures
    tidyNames <- tolower(gsub("-","",gsub("\\()","",
                             levels(relevantNames)[relevantNames])))
    names(newData)[3:length(names(newData))] <- tidyNames
    
    #create independant data set with average of each var for each activity & each subject
    library(reshape2)
    subjectActivity <- group_by(newData, factor(subject), factor(activitylabel))
    subActMelt <- melt(subjectActivity, id=c("subject","activitylabel"), measure.vars=tidyNames)
    meanData <- dcast(subActMelt, subject + activitylabel ~ variable, mean)
    write.table(meanData,file="meanData.txt",row.names=FALSE)
}
