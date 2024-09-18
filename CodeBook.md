**CODE BOOK**

The script `run_analysis.R` creates a data set: `FinalProjectData.txt`

The file `README.md` contains a process breakdown of the script. This code book explains the variables, their names, and how they were created. At the bottom of the code book is a list of the variables in the data set that results from the script.

**Variable Explanation**

`subject` - an identifier of the subject who carried out the experiment, created through an rbind() of the subjects in the training data with the subjects in the test data. The range is from 1 to 30.

`activity` - an activity label. This was created by using the `activity_labels.txt` data, which linked the labels with keys, and using the `y_test` and `y_train` data, which provided a bridge from the keys to the order of subjects.

The remaining data was created by first extracting the measurements on the mean and standard deviation for each measurement in the original dataset (the process for compiling the dataset is found in the README file). The extraction of these measurements was performed using this code, which extracted the variables containing mean and standard deviation, along with identifying variables, and placed them in a dataset called "extracted_data":

```{r}
extracted_data <- total_data %>%
        select(subject, key, contains("mean"), contains("std"))
```

This data was then grouped by subject and activity, before then finding the mean for each variable, using the following code, and then saving the resulting data set as FinalProjectData:

```{r}
FinalProjectData <- extracted_data%>%
        group_by(subject, activity)%>%
        summarize_all(list(mean))
```

**Explaining Modification to Variable Names**

Variables from the preexisting dataset were then appropriately labeled with descriptive names, expanding on the hard to parse shortening. These changes can be seen here.\
`ACC` expanded to `Accelerometer`\
`BodyBody` is shortened to `Body`\
`f` is replaced by `Frequency` if it starts a variable name\
`Gyro` is expanded to `Gyroscope`\
`Mag` is expanded to `Magnitude`\
`t` is replaced by `Time` if it starts a variable name\
For clarity's sake, each word in a variable's name is now capitalized, unless it is an abbreviation, in which case the entire abbreviation is capitalized (e.g. `STD`)\

```         
**List of variables**

 [1] "subject"
 [2] "activity"                 
 [3] "TimeBodyAccelerometerMeanX"    
 [4] "TimeBodyAccelerometerMeanY"   
 [5] "TimeBodyAccelerometerMeanZ"     
 [6] "TimeGravityAccelerometerMeanX"    
 [7] "TimeGravityAccelerometerMeanY"    
 [8] "TimeGravityAccelerometerMeanZ"    
 [9] "TimeBodyAccelerometerJerkMeanX"    
 [10] "TimeBodyAccelerometerJerkMeanY"  
 [11] "TimeBodyAccelerometerJerkMeanZ"  
 [12] "TimeBodyGyroscopeMeanX"          
 [13] "TimeBodyGyroscopeMeanY"          
 [14] "TimeBodyGyroscopeMeanZ"          
 [15] "TimeBodyGyroscopeJerkMeanX"        
 [16] "TimeBodyGyroscopeJerkMeanY"      
 [17] "TimeBodyGyroscopeJerkMeanZ"      
 [18] "TimeBodyAccelerometerMagnitudeMean" 
 [19] "TimeGravityAccelerometerMagnitudeMean"  
 [20] "TimeBodyAccelerometerJerkMagnitudeMean"   
 [21] "TimeBodyGyroscopeMagnitudeMean"        
 [22] "TimeBodyGyroscopeJerkMagnitudeMean"   
 [23] "FrequencyBodyAccelerometerMeanX"       
 [24] "FrequencyBodyAccelerometerMeanY"      
 [25] "FrequencyBodyAccelerometerMeanZ"      
 [26] "FrequencyBodyAccelerometerMeanFrequencyX"    
 [27] "FrequencyBodyAccelerometerMeanFrequencyY"  
 [28] "FrequencyBodyAccelerometerMeanFrequencyZ"  
 [29] "FrequencyBodyAccelerometerJerkMeanX"       
 [30] "FrequencyBodyAccelerometerJerkMeanY"       
 [31] "FrequencyBodyAccelerometerJerkMeanZ"      
 [32] "FrequencyBodyAccelerometerJerkMeanFrequencyX"    
 [33] "FrequencyBodyAccelerometerJerkMeanFrequencyY"  
 [34] "FrequencyBodyAccelerometerJerkMeanFrequencyZ"  
 [35] "FrequencyBodyGyroscopeMeanX"                   
 [36] "FrequencyBodyGyroscopeMeanY"                   
 [37] "FrequencyBodyGyroscopeMeanZ"                   
 [38] "FrequencyBodyGyroscopeMeanFrequencyX"         
 [39] "FrequencyBodyGyroscopeMeanFrequencyY"         
 [40] "FrequencyBodyGyroscopeMeanFrequencyZ"         
 [41] "FrequencyBodyAccelerometerMagnitudeMean"      
 [42] "FrequencyBodyAccelerometerMagnitudeMeanFrequency" 
 [43] "FrequencyBodyAccelerometerJerkMagnitudeMean"        
 [44] "FrequencyBodyAccelerometerJerkMagnitudeMeanFrequency"
 [45] "FrequencyBodyGyroscopeMagnitudeMean"           
 [46] "FrequencyBodyGyroscopeMagnitudeMeanFrequency"   
 [47] "FrequencyBodyGyroscopeJerkMagnitudeMean"       
 [48] "FrequencyBodyGyroscopeJerkMagnitudeMeanFrequency"   
 [49] "AngleTimeBodyAccelerometerMeanGravity"          
 [50] "AngleTimeBodyAccelerometerJerkMeanGravityMean"   
 [51] "AngleTimeBodyGyroscopeMeanGravityMean"             
 [52] "AngleTimeBodyGyroscopeJerkMeanGravityMean"       
 [53] "AngleXGravityMean"                            
 [54] "AngleYGravityMean"                           
 [55] "AngleZGravityMean"                           
 [56] "TimeBodyAccelerometerSTDX"                   
 [57] "TimeBodyAccelerometerSTDY"                   
 [58] "TimeBodyAccelerometerSTDZ"                   
 [59] "TimeGravityAccelerometerSTDX"                 
 [60] "TimeGravityAccelerometerSTDY"                
 [61] "TimeGravityAccelerometerSTDZ"                  
 [62] "TimeBodyAccelerometerJerkSTDX"                 
 [63] "TimeBodyAccelerometerJerkSTDY"               
 [64] "TimeBodyAccelerometerJerkSTDZ"              
 [65] "TimeBodyGyroscopeSTDX"                        
 [66] "TimeBodyGyroscopeSTDY"                      
 [67] "TimeBodyGyroscopeSTDZ"                      
 [68] "TimeBodyGyroscopeJerkSTDX"                   
 [69] "TimeBodyGyroscopeJerkSTDY"                  
 [70] "TimeBodyGyroscopeJerkSTDZ"                   
 [71] "TimeBodyAccelerometerMagnitudeSTD"             
 [72] "TimeGravityAccelerometerMagnitudeSTD"         
 [73] "TimeBodyAccelerometerJerkMagnitudeSTD"          
 [74] "TimeBodyGyroscopeMagnitudeSTD"                
 [75] "TimeBodyGyroscopeJerkMagnitudeSTD"             
 [76] "FrequencyBodyAccelerometerSTDX"             
 [77] "FrequencyBodyAccelerometerSTDY"               
 [78] "FrequencyBodyAccelerometerSTDZ"                
 [79] "FrequencyBodyAccelerometerJerkSTDX"          
 [80] "FrequencyBodyAccelerometerJerkSTDY"          
 [81] "FrequencyBodyAccelerometerJerkSTDZ"          
 [82] "FrequencyBodyGyroscopeSTDX"                  
 [83] "FrequencyBodyGyroscopeSTDY"                  
 [84] "FrequencyBodyGyroscopeSTDZ"                 
 [85] "FrequencyBodyAccelerometerMagnitudeSTD"      
 [86] "FrequencyBodyAccelerometerJerkMagnitudeSTD"  
 [87] "FrequencyBodyGyroscopeMagnitudeSTD"          
 [88] "FrequencyBodyGyroscopeJerkMagnitudeSTD"  
```
