# AssignmentGettingandCleaningData
This scripts tidies and cleans data from the UCI HAR Dataset:

1. Reading the data 
  + Reads testsets into one dataset, subsetting only the columns containing mean and std and using the set with featurenames as column names
  + Merge this with the sets containing the subject id's and activity id's
  + Repeat these steps with the trainingsets
  + Merge the training and testsets to get one total set
   
2. Tidies the dataset
  + Remove the brackets "()"
  + Replace the actvity-ids by activitynames

3. Creates an dataset with the averages of all measures grouped by subject-id and activity
