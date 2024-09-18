# GetCleanDataFinalProject

This README file contains explanations for the following documents:\
==========================\
- `run_analysis.R` : the script that processes the data\
-`CodeBook.md` : the codebook that explains the variables\
The script mentioned above (run_analysis.R) creates `FinalProjectData.txt` as the output file. If you are reading this before running the script (thank you!), be aware that the script has not created FinalProjectData.txt yet.

The run_analysis.R script performs data collection, cleaning, processing, and extraction according to the five guidelines provided in the project assignment:

1.  Merge the training and test sets to create one data set.
2.  Extract only the measurements on the mean and standard deviation for each measurement.
3.  Use descriptive activity names to name activities in the data set.
4.  Appropriately label the data set with descriptive variable names.
5.  From this labeled data set, create a second tidy data set that contains the average of each variable for each activity and subject.

Merging the training and test sets involved several sub-steps, including installing packages, obtaining the data, labeling the data, and merging the data.\
The section of code listed under **Packages Desired** runs a quick if loop to see if the packages necessary for the code to run smoothly exist on the computer, and downloads them if they do not.\
The section of code under **downloading and unzipping the data** does just that. It downloads the zipped file and unzips it in the working directory. After reading extracting the necessary files, the script then deletes the zip file from the directory.\
The section of code under **The elements we will need** reads and labels the data extracted from the zip file. **Category and labels**: The data containing activity labels and feature measurement labels are extracted and provided column names: (key, activity) and (n, measurement) respectively, for clarity and to make it easier to merge with other files later in the script. **Training Data and Keys:** Files pulled from the training sections, (with the same process used for the test sections) are labeled, with the X files (containing the measurements) labeled as data and the Y files (that provide the bridge between the measurements and the category/activity labels) labeled as keys. The data is then given column names by using the measurement labels that were established in the Category and labels section (specifically by using the col.names argument of read.table and supplying it with features\$measurements, for both the test and training data. **Subject Data:** in both the test and training files, the data containing subject information is extracted and labeled appropriately.\
**TASK 1** : the section of code listed under task one then takes the training and test dataframes for the data, keys, and subject and uses rbind() to create merged dataframes for the data, keys, and subjects. cbind() is then used to combine all of the data together, creating a data frame called "total_data".

**TASK 2:** The next section, designed to streamline the data and extract the information pertaining to mean or std for each variable, takes the newly created data frame and runs a select() function on it. This pulls not only the subject and key columns but also uses the contains() function to pull any columns with mean or std in the heading. This newly created data frame of pulled data is called "extracted_data".

**TASK 3:** This section of the script uses the activity labels and applies it to the dataset.

**TASK 4:** This section takes the info provided in the features_info.txt file and uses it to create descriptive variable names, along with labeling the activity column. This is done through a series of gsub() function uses. It could make for a more aesthetically pleasing code to make this list of gsub() replacements in a streamlined fashion. However, the rationale here is that the uniform list of gsub() usages makes it clear and easy to identify which line is causing which replacement, at a glance, and therefore easy to modify in the future if needed.

**TASK 5:** This section creates a second tidy data set that lists the average for each variable, for each activity and subject. This is done by first grouping the data by subject and activity and then running mean through a summarize_all() function. The write.table() function is then used to create a .txt file that contains this new independent tidy data set.

If desired, the output .txt file can be read with the following code:\
`FinalProjectData <- read.table("FinalProjectData.txt", header = TRUE)`
