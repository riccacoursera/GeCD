This repository contains the solution for the peer-assessment project work for the "Getting and Cleaning Data" Coursera course. 

Run:
In order to run the script, open the file run_analysis.R and run it within RStudio or R. The script will generate aggregate data from the original dataset [1].

Steps:
The script is structured into the following steps:

* PRE-PROCESSING
  * Load data from online available zip file
  * Extract the zip file
  * Read its content into defined R variables

* PROBLEM 1
  * Merge the training and the test sets to create one data set

* PROBLEM 2
  * Extract only the measurements on the mean and standard deviation for each measurement

* PROBLEM 3
  * Use descriptive activity names to name the activities in the data set

* PROBLEM 4
  * Labels the data set with descriptive variable names

* PROBLEM 5
  * Create a second, independent tidy data set with the average of each variable for each activity and each subject

Packages:
Before calling any package, I verify if the package I am going to use is installed in your machine, and in case the package will be installed.

Outputs:
If you want to verify the data at each step, set the variable save_intermediated = TRUE (instead of FALSE as default).
The final dataset, required in Problem 5, is stored by default as "final_data.txt" file. 


References:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
