## Codebook for Human Activity Data

### Feature Selection (from feature_info.txt)
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value

std(): Standard deviation

mad(): Median absolute deviation 

max(): Largest value in array

min(): Smallest value in array

sma(): Signal magnitude area

energy(): Energy measure. Sum of the squares divided by the number of values. 

iqr(): Interquartile range 

entropy(): Signal entropy

arCoeff(): Autorregresion coefficients with Burg order equal to 4

correlation(): correlation coefficient between two signals

maxInds(): index of the frequency component with largest magnitude

meanFreq(): Weighted average of the frequency components to obtain a mean frequency

skewness(): skewness of the frequency domain signal 

kurtosis(): kurtosis of the frequency domain signal 

bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.

angle(): Angle between to vectors.

The final tidy data set includes only variables that are the mean and standard deviation of measurements. Additional vectors below were obtained by averaging the signals in a signal window sample. These are used on the angle() variable, and are not included in the final tidy data set.

gravityMean

tBodyAccMean

tBodyAccJerkMean

tBodyGyroMean

tBodyGyroJerkMean

## Activity Labels
The following table shows the activities that were performed by each subject. Labels were shortened as given in the table. The R-code to accomplish this and add the activity names to the tidy data set (called actMeanStd) is given below, also. 

### Table of Activity Names
Activity Number | Original Name | Modified Name
:---------------:|--------------|---------------
1 | WALKING | WALKING
2 | WALKING_UPSTAIRS | WALKING_UP
3 | WALKING_DOWNSTAIRS | WALKING_DN
4 | SITTING | SITTING
5 | STANDING | STANDING
6 | LAYING | LAYING

### R Code to obtain modified activity names
``````````
actNames <- read.table(file="./activity_labels.txt")
names(actNames) <- c("Number", "Activity")
actLabels <- actNames[,2]
actLabels <- gsub("WALKING_UPSTAIRS", "WALKING_UP", actLabels)
actLabels <- gsub("WALKING_DOWNSTAIRS", "WALKING_DN", actLabels)
## Apply labels to appropriate rows of actMeanStd
for (i in seq(actLabels)) {actMeanStd[actMeanStd$Activity == i, 'Activity'] <- actLabels[i]}
``````````

### Code to obtain tidy data set
AllData is the data frame containing both training and test data sets, along with subject and activity numbers. The code below requires the dplyr package.
`````````````
SubActVals <- select(AllData, Subject, Activity)
AllMeanStd <- select(AllData, matches("mean|std"))
AllMeanStd <- select(AllMeanStd, -contains("angle"))
AllMeanStd <- select(AllMeanStd, -contains("meanFreq"))
actMeanStd <- cbind(SubActVals, AllMeanStd)
```````````

### Obtaining 'tidy' variable names
Names in column 2 are directly from features_txt. Names in column 3 are "legal" R names using make.names(), and names in column 4 are "cleaned up" names using the code below.
```````````
AllDataNames <- names(AllMeanStd)
AllDataNames <- gsub("mean..","mean",AllDataNames)
AllDataNames <- gsub("std..","std",AllDataNames)
names(AllMeanStd) <- AllDataNames
```````````
### Table of variable names
Variable Number | Original Name | Valid Name | Cleaned Name
:---------------: | --------------| -----------| ------------- 
1 | (not in features.txt) | (not in features.txt) | Subject
2 | (not in features.txt) | (not in features.txt) | Activity
3 | tBodyAcc-mean()-X | tBodyAcc.mean...X | tBodyAcc.mean.X
4 | tBodyAcc-mean()-Y | tBodyAcc.mean...Y | tBodyAcc.mean.Y
5 | tBodyAcc-mean()-Z | tBodyAcc.mean...Z | tBodyAcc.mean.Z
6 | tBodyAcc-std()-X | tBodyAcc.std...X | tBodyAcc.std.X
7 | tBodyAcc-std()-Y | tBodyAcc.std...Y | tBodyAcc.std.Y
8 | tBodyAcc-std()-Z | tBodyAcc.std...Z | tBodyAcc.std.Z
9 | tBodyAcc-mad()-X | tBodyAcc.mad...X | tBodyAcc.mad...X
10 | tBodyAcc-mad()-Y | tBodyAcc.mad...Y | tBodyAcc.mad...Y
11 | tBodyAcc-mad()-Z | tBodyAcc.mad...Z | tBodyAcc.mad...Z
12 | tBodyAcc-max()-X | tBodyAcc.max...X | tBodyAcc.max...X
13 | tBodyAcc-max()-Y | tBodyAcc.max...Y | tBodyAcc.max...Y
14 | tBodyAcc-max()-Z | tBodyAcc.max...Z | tBodyAcc.max...Z
15 | tBodyAcc-min()-X | tBodyAcc.min...X | tBodyAcc.min...X
16 | tBodyAcc-min()-Y | tBodyAcc.min...Y | tBodyAcc.min...Y
17 | tBodyAcc-min()-Z | tBodyAcc.min...Z | tBodyAcc.min...Z
18 | tBodyAcc-sma() | tBodyAcc.sma.. | tBodyAcc.sma..
19 | tBodyAcc-energy()-X | tBodyAcc.energy...X | tBodyAcc.energy...X
20 | tBodyAcc-energy()-Y | tBodyAcc.energy...Y | tBodyAcc.energy...Y
21 | tBodyAcc-energy()-Z | tBodyAcc.energy...Z | tBodyAcc.energy...Z
22 | tBodyAcc-iqr()-X | tBodyAcc.iqr...X | tBodyAcc.iqr...X
23 | tBodyAcc-iqr()-Y | tBodyAcc.iqr...Y | tBodyAcc.iqr...Y
24 | tBodyAcc-iqr()-Z | tBodyAcc.iqr...Z | tBodyAcc.iqr...Z
25 | tBodyAcc-entropy()-X | tBodyAcc.entropy...X | tBodyAcc.entropy...X
26 | tBodyAcc-entropy()-Y | tBodyAcc.entropy...Y | tBodyAcc.entropy...Y
27 | tBodyAcc-entropy()-Z | tBodyAcc.entropy...Z | tBodyAcc.entropy...Z
28 | tBodyAcc-arCoeff()-X,1 | tBodyAcc.arCoeff...X.1 | tBodyAcc.arCoeff...X.1
29 | tBodyAcc-arCoeff()-X,2 | tBodyAcc.arCoeff...X.2 | tBodyAcc.arCoeff...X.2
30 | tBodyAcc-arCoeff()-X,3 | tBodyAcc.arCoeff...X.3 | tBodyAcc.arCoeff...X.3
31 | tBodyAcc-arCoeff()-X,4 | tBodyAcc.arCoeff...X.4 | tBodyAcc.arCoeff...X.4
32 | tBodyAcc-arCoeff()-Y,1 | tBodyAcc.arCoeff...Y.1 | tBodyAcc.arCoeff...Y.1
33 | tBodyAcc-arCoeff()-Y,2 | tBodyAcc.arCoeff...Y.2 | tBodyAcc.arCoeff...Y.2
34 | tBodyAcc-arCoeff()-Y,3 | tBodyAcc.arCoeff...Y.3 | tBodyAcc.arCoeff...Y.3
35 | tBodyAcc-arCoeff()-Y,4 | tBodyAcc.arCoeff...Y.4 | tBodyAcc.arCoeff...Y.4
36 | tBodyAcc-arCoeff()-Z,1 | tBodyAcc.arCoeff...Z.1 | tBodyAcc.arCoeff...Z.1
37 | tBodyAcc-arCoeff()-Z,2 | tBodyAcc.arCoeff...Z.2 | tBodyAcc.arCoeff...Z.2
38 | tBodyAcc-arCoeff()-Z,3 | tBodyAcc.arCoeff...Z.3 | tBodyAcc.arCoeff...Z.3
39 | tBodyAcc-arCoeff()-Z,4 | tBodyAcc.arCoeff...Z.4 | tBodyAcc.arCoeff...Z.4
40 | tBodyAcc-correlation()-X,Y | tBodyAcc.correlation...X.Y | tBodyAcc.correlation...X.Y
41 | tBodyAcc-correlation()-X,Z | tBodyAcc.correlation...X.Z | tBodyAcc.correlation...X.Z
42 | tBodyAcc-correlation()-Y,Z | tBodyAcc.correlation...Y.Z | tBodyAcc.correlation...Y.Z
43 | tGravityAcc-mean()-X | tGravityAcc.mean...X | tGravityAcc.mean.X
44 | tGravityAcc-mean()-Y | tGravityAcc.mean...Y | tGravityAcc.mean.Y
45 | tGravityAcc-mean()-Z | tGravityAcc.mean...Z | tGravityAcc.mean.Z
46 | tGravityAcc-std()-X | tGravityAcc.std...X | tGravityAcc.std.X
47 | tGravityAcc-std()-Y | tGravityAcc.std...Y | tGravityAcc.std.Y
48 | tGravityAcc-std()-Z | tGravityAcc.std...Z | tGravityAcc.std.Z
49 | tGravityAcc-mad()-X | tGravityAcc.mad...X | tGravityAcc.mad...X
50 | tGravityAcc-mad()-Y | tGravityAcc.mad...Y | tGravityAcc.mad...Y
51 | tGravityAcc-mad()-Z | tGravityAcc.mad...Z | tGravityAcc.mad...Z
52 | tGravityAcc-max()-X | tGravityAcc.max...X | tGravityAcc.max...X
53 | tGravityAcc-max()-Y | tGravityAcc.max...Y | tGravityAcc.max...Y
54 | tGravityAcc-max()-Z | tGravityAcc.max...Z | tGravityAcc.max...Z
55 | tGravityAcc-min()-X | tGravityAcc.min...X | tGravityAcc.min...X
56 | tGravityAcc-min()-Y | tGravityAcc.min...Y | tGravityAcc.min...Y
57 | tGravityAcc-min()-Z | tGravityAcc.min...Z | tGravityAcc.min...Z
58 | tGravityAcc-sma() | tGravityAcc.sma.. | tGravityAcc.sma..
59 | tGravityAcc-energy()-X | tGravityAcc.energy...X | tGravityAcc.energy...X
60 | tGravityAcc-energy()-Y | tGravityAcc.energy...Y | tGravityAcc.energy...Y
61 | tGravityAcc-energy()-Z | tGravityAcc.energy...Z | tGravityAcc.energy...Z
62 | tGravityAcc-iqr()-X | tGravityAcc.iqr...X | tGravityAcc.iqr...X
63 | tGravityAcc-iqr()-Y | tGravityAcc.iqr...Y | tGravityAcc.iqr...Y
64 | tGravityAcc-iqr()-Z | tGravityAcc.iqr...Z | tGravityAcc.iqr...Z
65 | tGravityAcc-entropy()-X | tGravityAcc.entropy...X | tGravityAcc.entropy...X
66 | tGravityAcc-entropy()-Y | tGravityAcc.entropy...Y | tGravityAcc.entropy...Y
67 | tGravityAcc-entropy()-Z | tGravityAcc.entropy...Z | tGravityAcc.entropy...Z
68 | tGravityAcc-arCoeff()-X,1 | tGravityAcc.arCoeff...X.1 | tGravityAcc.arCoeff...X.1
69 | tGravityAcc-arCoeff()-X,2 | tGravityAcc.arCoeff...X.2 | tGravityAcc.arCoeff...X.2
70 | tGravityAcc-arCoeff()-X,3 | tGravityAcc.arCoeff...X.3 | tGravityAcc.arCoeff...X.3
71 | tGravityAcc-arCoeff()-X,4 | tGravityAcc.arCoeff...X.4 | tGravityAcc.arCoeff...X.4
72 | tGravityAcc-arCoeff()-Y,1 | tGravityAcc.arCoeff...Y.1 | tGravityAcc.arCoeff...Y.1
73 | tGravityAcc-arCoeff()-Y,2 | tGravityAcc.arCoeff...Y.2 | tGravityAcc.arCoeff...Y.2
74 | tGravityAcc-arCoeff()-Y,3 | tGravityAcc.arCoeff...Y.3 | tGravityAcc.arCoeff...Y.3
75 | tGravityAcc-arCoeff()-Y,4 | tGravityAcc.arCoeff...Y.4 | tGravityAcc.arCoeff...Y.4
76 | tGravityAcc-arCoeff()-Z,1 | tGravityAcc.arCoeff...Z.1 | tGravityAcc.arCoeff...Z.1
77 | tGravityAcc-arCoeff()-Z,2 | tGravityAcc.arCoeff...Z.2 | tGravityAcc.arCoeff...Z.2
78 | tGravityAcc-arCoeff()-Z,3 | tGravityAcc.arCoeff...Z.3 | tGravityAcc.arCoeff...Z.3
79 | tGravityAcc-arCoeff()-Z,4 | tGravityAcc.arCoeff...Z.4 | tGravityAcc.arCoeff...Z.4
80 | tGravityAcc-correlation()-X,Y | tGravityAcc.correlation...X.Y | tGravityAcc.correlation...X.Y
81 | tGravityAcc-correlation()-X,Z | tGravityAcc.correlation...X.Z | tGravityAcc.correlation...X.Z
82 | tGravityAcc-correlation()-Y,Z | tGravityAcc.correlation...Y.Z | tGravityAcc.correlation...Y.Z
83 | tBodyAccJerk-mean()-X | tBodyAccJerk.mean...X | tBodyAccJerk.mean.X
84 | tBodyAccJerk-mean()-Y | tBodyAccJerk.mean...Y | tBodyAccJerk.mean.Y
85 | tBodyAccJerk-mean()-Z | tBodyAccJerk.mean...Z | tBodyAccJerk.mean.Z
86 | tBodyAccJerk-std()-X | tBodyAccJerk.std...X | tBodyAccJerk.std.X
87 | tBodyAccJerk-std()-Y | tBodyAccJerk.std...Y | tBodyAccJerk.std.Y
88 | tBodyAccJerk-std()-Z | tBodyAccJerk.std...Z | tBodyAccJerk.std.Z
89 | tBodyAccJerk-mad()-X | tBodyAccJerk.mad...X | tBodyAccJerk.mad...X
90 | tBodyAccJerk-mad()-Y | tBodyAccJerk.mad...Y | tBodyAccJerk.mad...Y
91 | tBodyAccJerk-mad()-Z | tBodyAccJerk.mad...Z | tBodyAccJerk.mad...Z
92 | tBodyAccJerk-max()-X | tBodyAccJerk.max...X | tBodyAccJerk.max...X
93 | tBodyAccJerk-max()-Y | tBodyAccJerk.max...Y | tBodyAccJerk.max...Y
94 | tBodyAccJerk-max()-Z | tBodyAccJerk.max...Z | tBodyAccJerk.max...Z
95 | tBodyAccJerk-min()-X | tBodyAccJerk.min...X | tBodyAccJerk.min...X
96 | tBodyAccJerk-min()-Y | tBodyAccJerk.min...Y | tBodyAccJerk.min...Y
97 | tBodyAccJerk-min()-Z | tBodyAccJerk.min...Z | tBodyAccJerk.min...Z
98 | tBodyAccJerk-sma() | tBodyAccJerk.sma.. | tBodyAccJerk.sma..
99 | tBodyAccJerk-energy()-X | tBodyAccJerk.energy...X | tBodyAccJerk.energy...X
100 | tBodyAccJerk-energy()-Y | tBodyAccJerk.energy...Y | tBodyAccJerk.energy...Y
101 | tBodyAccJerk-energy()-Z | tBodyAccJerk.energy...Z | tBodyAccJerk.energy...Z
102 | tBodyAccJerk-iqr()-X | tBodyAccJerk.iqr...X | tBodyAccJerk.iqr...X
103 | tBodyAccJerk-iqr()-Y | tBodyAccJerk.iqr...Y | tBodyAccJerk.iqr...Y
104 | tBodyAccJerk-iqr()-Z | tBodyAccJerk.iqr...Z | tBodyAccJerk.iqr...Z
105 | tBodyAccJerk-entropy()-X | tBodyAccJerk.entropy...X | tBodyAccJerk.entropy...X
106 | tBodyAccJerk-entropy()-Y | tBodyAccJerk.entropy...Y | tBodyAccJerk.entropy...Y
107 | tBodyAccJerk-entropy()-Z | tBodyAccJerk.entropy...Z | tBodyAccJerk.entropy...Z
108 | tBodyAccJerk-arCoeff()-X,1 | tBodyAccJerk.arCoeff...X.1 | tBodyAccJerk.arCoeff...X.1
109 | tBodyAccJerk-arCoeff()-X,2 | tBodyAccJerk.arCoeff...X.2 | tBodyAccJerk.arCoeff...X.2
110 | tBodyAccJerk-arCoeff()-X,3 | tBodyAccJerk.arCoeff...X.3 | tBodyAccJerk.arCoeff...X.3
111 | tBodyAccJerk-arCoeff()-X,4 | tBodyAccJerk.arCoeff...X.4 | tBodyAccJerk.arCoeff...X.4
112 | tBodyAccJerk-arCoeff()-Y,1 | tBodyAccJerk.arCoeff...Y.1 | tBodyAccJerk.arCoeff...Y.1
113 | tBodyAccJerk-arCoeff()-Y,2 | tBodyAccJerk.arCoeff...Y.2 | tBodyAccJerk.arCoeff...Y.2
114 | tBodyAccJerk-arCoeff()-Y,3 | tBodyAccJerk.arCoeff...Y.3 | tBodyAccJerk.arCoeff...Y.3
115 | tBodyAccJerk-arCoeff()-Y,4 | tBodyAccJerk.arCoeff...Y.4 | tBodyAccJerk.arCoeff...Y.4
116 | tBodyAccJerk-arCoeff()-Z,1 | tBodyAccJerk.arCoeff...Z.1 | tBodyAccJerk.arCoeff...Z.1
117 | tBodyAccJerk-arCoeff()-Z,2 | tBodyAccJerk.arCoeff...Z.2 | tBodyAccJerk.arCoeff...Z.2
118 | tBodyAccJerk-arCoeff()-Z,3 | tBodyAccJerk.arCoeff...Z.3 | tBodyAccJerk.arCoeff...Z.3
119 | tBodyAccJerk-arCoeff()-Z,4 | tBodyAccJerk.arCoeff...Z.4 | tBodyAccJerk.arCoeff...Z.4
120 | tBodyAccJerk-correlation()-X,Y | tBodyAccJerk.correlation...X.Y | tBodyAccJerk.correlation...X.Y
121 | tBodyAccJerk-correlation()-X,Z | tBodyAccJerk.correlation...X.Z | tBodyAccJerk.correlation...X.Z
122 | tBodyAccJerk-correlation()-Y,Z | tBodyAccJerk.correlation...Y.Z | tBodyAccJerk.correlation...Y.Z
123 | tBodyGyro-mean()-X | tBodyGyro.mean...X | tBodyGyro.mean.X
124 | tBodyGyro-mean()-Y | tBodyGyro.mean...Y | tBodyGyro.mean.Y
125 | tBodyGyro-mean()-Z | tBodyGyro.mean...Z | tBodyGyro.mean.Z
126 | tBodyGyro-std()-X | tBodyGyro.std...X | tBodyGyro.std.X
127 | tBodyGyro-std()-Y | tBodyGyro.std...Y | tBodyGyro.std.Y
128 | tBodyGyro-std()-Z | tBodyGyro.std...Z | tBodyGyro.std.Z
129 | tBodyGyro-mad()-X | tBodyGyro.mad...X | tBodyGyro.mad...X
130 | tBodyGyro-mad()-Y | tBodyGyro.mad...Y | tBodyGyro.mad...Y
131 | tBodyGyro-mad()-Z | tBodyGyro.mad...Z | tBodyGyro.mad...Z
132 | tBodyGyro-max()-X | tBodyGyro.max...X | tBodyGyro.max...X
133 | tBodyGyro-max()-Y | tBodyGyro.max...Y | tBodyGyro.max...Y
134 | tBodyGyro-max()-Z | tBodyGyro.max...Z | tBodyGyro.max...Z
135 | tBodyGyro-min()-X | tBodyGyro.min...X | tBodyGyro.min...X
136 | tBodyGyro-min()-Y | tBodyGyro.min...Y | tBodyGyro.min...Y
137 | tBodyGyro-min()-Z | tBodyGyro.min...Z | tBodyGyro.min...Z
138 | tBodyGyro-sma() | tBodyGyro.sma.. | tBodyGyro.sma..
139 | tBodyGyro-energy()-X | tBodyGyro.energy...X | tBodyGyro.energy...X
140 | tBodyGyro-energy()-Y | tBodyGyro.energy...Y | tBodyGyro.energy...Y
141 | tBodyGyro-energy()-Z | tBodyGyro.energy...Z | tBodyGyro.energy...Z
142 | tBodyGyro-iqr()-X | tBodyGyro.iqr...X | tBodyGyro.iqr...X
143 | tBodyGyro-iqr()-Y | tBodyGyro.iqr...Y | tBodyGyro.iqr...Y
144 | tBodyGyro-iqr()-Z | tBodyGyro.iqr...Z | tBodyGyro.iqr...Z
145 | tBodyGyro-entropy()-X | tBodyGyro.entropy...X | tBodyGyro.entropy...X
146 | tBodyGyro-entropy()-Y | tBodyGyro.entropy...Y | tBodyGyro.entropy...Y
147 | tBodyGyro-entropy()-Z | tBodyGyro.entropy...Z | tBodyGyro.entropy...Z
148 | tBodyGyro-arCoeff()-X,1 | tBodyGyro.arCoeff...X.1 | tBodyGyro.arCoeff...X.1
149 | tBodyGyro-arCoeff()-X,2 | tBodyGyro.arCoeff...X.2 | tBodyGyro.arCoeff...X.2
150 | tBodyGyro-arCoeff()-X,3 | tBodyGyro.arCoeff...X.3 | tBodyGyro.arCoeff...X.3
151 | tBodyGyro-arCoeff()-X,4 | tBodyGyro.arCoeff...X.4 | tBodyGyro.arCoeff...X.4
152 | tBodyGyro-arCoeff()-Y,1 | tBodyGyro.arCoeff...Y.1 | tBodyGyro.arCoeff...Y.1
153 | tBodyGyro-arCoeff()-Y,2 | tBodyGyro.arCoeff...Y.2 | tBodyGyro.arCoeff...Y.2
154 | tBodyGyro-arCoeff()-Y,3 | tBodyGyro.arCoeff...Y.3 | tBodyGyro.arCoeff...Y.3
155 | tBodyGyro-arCoeff()-Y,4 | tBodyGyro.arCoeff...Y.4 | tBodyGyro.arCoeff...Y.4
156 | tBodyGyro-arCoeff()-Z,1 | tBodyGyro.arCoeff...Z.1 | tBodyGyro.arCoeff...Z.1
157 | tBodyGyro-arCoeff()-Z,2 | tBodyGyro.arCoeff...Z.2 | tBodyGyro.arCoeff...Z.2
158 | tBodyGyro-arCoeff()-Z,3 | tBodyGyro.arCoeff...Z.3 | tBodyGyro.arCoeff...Z.3
159 | tBodyGyro-arCoeff()-Z,4 | tBodyGyro.arCoeff...Z.4 | tBodyGyro.arCoeff...Z.4
160 | tBodyGyro-correlation()-X,Y | tBodyGyro.correlation...X.Y | tBodyGyro.correlation...X.Y
161 | tBodyGyro-correlation()-X,Z | tBodyGyro.correlation...X.Z | tBodyGyro.correlation...X.Z
162 | tBodyGyro-correlation()-Y,Z | tBodyGyro.correlation...Y.Z | tBodyGyro.correlation...Y.Z
163 | tBodyGyroJerk-mean()-X | tBodyGyroJerk.mean...X | tBodyGyroJerk.mean.X
164 | tBodyGyroJerk-mean()-Y | tBodyGyroJerk.mean...Y | tBodyGyroJerk.mean.Y
165 | tBodyGyroJerk-mean()-Z | tBodyGyroJerk.mean...Z | tBodyGyroJerk.mean.Z
166 | tBodyGyroJerk-std()-X | tBodyGyroJerk.std...X | tBodyGyroJerk.std.X
167 | tBodyGyroJerk-std()-Y | tBodyGyroJerk.std...Y | tBodyGyroJerk.std.Y
168 | tBodyGyroJerk-std()-Z | tBodyGyroJerk.std...Z | tBodyGyroJerk.std.Z
169 | tBodyGyroJerk-mad()-X | tBodyGyroJerk.mad...X | tBodyGyroJerk.mad...X
170 | tBodyGyroJerk-mad()-Y | tBodyGyroJerk.mad...Y | tBodyGyroJerk.mad...Y
171 | tBodyGyroJerk-mad()-Z | tBodyGyroJerk.mad...Z | tBodyGyroJerk.mad...Z
172 | tBodyGyroJerk-max()-X | tBodyGyroJerk.max...X | tBodyGyroJerk.max...X
173 | tBodyGyroJerk-max()-Y | tBodyGyroJerk.max...Y | tBodyGyroJerk.max...Y
174 | tBodyGyroJerk-max()-Z | tBodyGyroJerk.max...Z | tBodyGyroJerk.max...Z
175 | tBodyGyroJerk-min()-X | tBodyGyroJerk.min...X | tBodyGyroJerk.min...X
176 | tBodyGyroJerk-min()-Y | tBodyGyroJerk.min...Y | tBodyGyroJerk.min...Y
177 | tBodyGyroJerk-min()-Z | tBodyGyroJerk.min...Z | tBodyGyroJerk.min...Z
178 | tBodyGyroJerk-sma() | tBodyGyroJerk.sma.. | tBodyGyroJerk.sma..
179 | tBodyGyroJerk-energy()-X | tBodyGyroJerk.energy...X | tBodyGyroJerk.energy...X
180 | tBodyGyroJerk-energy()-Y | tBodyGyroJerk.energy...Y | tBodyGyroJerk.energy...Y
181 | tBodyGyroJerk-energy()-Z | tBodyGyroJerk.energy...Z | tBodyGyroJerk.energy...Z
182 | tBodyGyroJerk-iqr()-X | tBodyGyroJerk.iqr...X | tBodyGyroJerk.iqr...X
183 | tBodyGyroJerk-iqr()-Y | tBodyGyroJerk.iqr...Y | tBodyGyroJerk.iqr...Y
184 | tBodyGyroJerk-iqr()-Z | tBodyGyroJerk.iqr...Z | tBodyGyroJerk.iqr...Z
185 | tBodyGyroJerk-entropy()-X | tBodyGyroJerk.entropy...X | tBodyGyroJerk.entropy...X
186 | tBodyGyroJerk-entropy()-Y | tBodyGyroJerk.entropy...Y | tBodyGyroJerk.entropy...Y
187 | tBodyGyroJerk-entropy()-Z | tBodyGyroJerk.entropy...Z | tBodyGyroJerk.entropy...Z
188 | tBodyGyroJerk-arCoeff()-X,1 | tBodyGyroJerk.arCoeff...X.1 | tBodyGyroJerk.arCoeff...X.1
189 | tBodyGyroJerk-arCoeff()-X,2 | tBodyGyroJerk.arCoeff...X.2 | tBodyGyroJerk.arCoeff...X.2
190 | tBodyGyroJerk-arCoeff()-X,3 | tBodyGyroJerk.arCoeff...X.3 | tBodyGyroJerk.arCoeff...X.3
191 | tBodyGyroJerk-arCoeff()-X,4 | tBodyGyroJerk.arCoeff...X.4 | tBodyGyroJerk.arCoeff...X.4
192 | tBodyGyroJerk-arCoeff()-Y,1 | tBodyGyroJerk.arCoeff...Y.1 | tBodyGyroJerk.arCoeff...Y.1
193 | tBodyGyroJerk-arCoeff()-Y,2 | tBodyGyroJerk.arCoeff...Y.2 | tBodyGyroJerk.arCoeff...Y.2
194 | tBodyGyroJerk-arCoeff()-Y,3 | tBodyGyroJerk.arCoeff...Y.3 | tBodyGyroJerk.arCoeff...Y.3
195 | tBodyGyroJerk-arCoeff()-Y,4 | tBodyGyroJerk.arCoeff...Y.4 | tBodyGyroJerk.arCoeff...Y.4
196 | tBodyGyroJerk-arCoeff()-Z,1 | tBodyGyroJerk.arCoeff...Z.1 | tBodyGyroJerk.arCoeff...Z.1
197 | tBodyGyroJerk-arCoeff()-Z,2 | tBodyGyroJerk.arCoeff...Z.2 | tBodyGyroJerk.arCoeff...Z.2
198 | tBodyGyroJerk-arCoeff()-Z,3 | tBodyGyroJerk.arCoeff...Z.3 | tBodyGyroJerk.arCoeff...Z.3
199 | tBodyGyroJerk-arCoeff()-Z,4 | tBodyGyroJerk.arCoeff...Z.4 | tBodyGyroJerk.arCoeff...Z.4
200 | tBodyGyroJerk-correlation()-X,Y | tBodyGyroJerk.correlation...X.Y | tBodyGyroJerk.correlation...X.Y
201 | tBodyGyroJerk-correlation()-X,Z | tBodyGyroJerk.correlation...X.Z | tBodyGyroJerk.correlation...X.Z
202 | tBodyGyroJerk-correlation()-Y,Z | tBodyGyroJerk.correlation...Y.Z | tBodyGyroJerk.correlation...Y.Z
203 | tBodyAccMag-mean() | tBodyAccMag.mean.. | tBodyAccMag.mean
204 | tBodyAccMag-std() | tBodyAccMag.std.. | tBodyAccMag.std
205 | tBodyAccMag-mad() | tBodyAccMag.mad.. | tBodyAccMag.mad..
206 | tBodyAccMag-max() | tBodyAccMag.max.. | tBodyAccMag.max..
207 | tBodyAccMag-min() | tBodyAccMag.min.. | tBodyAccMag.min..
208 | tBodyAccMag-sma() | tBodyAccMag.sma.. | tBodyAccMag.sma..
209 | tBodyAccMag-energy() | tBodyAccMag.energy.. | tBodyAccMag.energy..
210 | tBodyAccMag-iqr() | tBodyAccMag.iqr.. | tBodyAccMag.iqr..
211 | tBodyAccMag-entropy() | tBodyAccMag.entropy.. | tBodyAccMag.entropy..
212 | tBodyAccMag-arCoeff()1 | tBodyAccMag.arCoeff..1 | tBodyAccMag.arCoeff..1
213 | tBodyAccMag-arCoeff()2 | tBodyAccMag.arCoeff..2 | tBodyAccMag.arCoeff..2
214 | tBodyAccMag-arCoeff()3 | tBodyAccMag.arCoeff..3 | tBodyAccMag.arCoeff..3
215 | tBodyAccMag-arCoeff()4 | tBodyAccMag.arCoeff..4 | tBodyAccMag.arCoeff..4
216 | tGravityAccMag-mean() | tGravityAccMag.mean.. | tGravityAccMag.mean
217 | tGravityAccMag-std() | tGravityAccMag.std.. | tGravityAccMag.std
218 | tGravityAccMag-mad() | tGravityAccMag.mad.. | tGravityAccMag.mad..
219 | tGravityAccMag-max() | tGravityAccMag.max.. | tGravityAccMag.max..
220 | tGravityAccMag-min() | tGravityAccMag.min.. | tGravityAccMag.min..
221 | tGravityAccMag-sma() | tGravityAccMag.sma.. | tGravityAccMag.sma..
222 | tGravityAccMag-energy() | tGravityAccMag.energy.. | tGravityAccMag.energy..
223 | tGravityAccMag-iqr() | tGravityAccMag.iqr.. | tGravityAccMag.iqr..
224 | tGravityAccMag-entropy() | tGravityAccMag.entropy.. | tGravityAccMag.entropy..
225 | tGravityAccMag-arCoeff()1 | tGravityAccMag.arCoeff..1 | tGravityAccMag.arCoeff..1
226 | tGravityAccMag-arCoeff()2 | tGravityAccMag.arCoeff..2 | tGravityAccMag.arCoeff..2
227 | tGravityAccMag-arCoeff()3 | tGravityAccMag.arCoeff..3 | tGravityAccMag.arCoeff..3
228 | tGravityAccMag-arCoeff()4 | tGravityAccMag.arCoeff..4 | tGravityAccMag.arCoeff..4
229 | tBodyAccJerkMag-mean() | tBodyAccJerkMag.mean.. | tBodyAccJerkMag.mean
230 | tBodyAccJerkMag-std() | tBodyAccJerkMag.std.. | tBodyAccJerkMag.std
231 | tBodyAccJerkMag-mad() | tBodyAccJerkMag.mad.. | tBodyAccJerkMag.mad..
232 | tBodyAccJerkMag-max() | tBodyAccJerkMag.max.. | tBodyAccJerkMag.max..
233 | tBodyAccJerkMag-min() | tBodyAccJerkMag.min.. | tBodyAccJerkMag.min..
234 | tBodyAccJerkMag-sma() | tBodyAccJerkMag.sma.. | tBodyAccJerkMag.sma..
235 | tBodyAccJerkMag-energy() | tBodyAccJerkMag.energy.. | tBodyAccJerkMag.energy..
236 | tBodyAccJerkMag-iqr() | tBodyAccJerkMag.iqr.. | tBodyAccJerkMag.iqr..
237 | tBodyAccJerkMag-entropy() | tBodyAccJerkMag.entropy.. | tBodyAccJerkMag.entropy..
238 | tBodyAccJerkMag-arCoeff()1 | tBodyAccJerkMag.arCoeff..1 | tBodyAccJerkMag.arCoeff..1
239 | tBodyAccJerkMag-arCoeff()2 | tBodyAccJerkMag.arCoeff..2 | tBodyAccJerkMag.arCoeff..2
240 | tBodyAccJerkMag-arCoeff()3 | tBodyAccJerkMag.arCoeff..3 | tBodyAccJerkMag.arCoeff..3
241 | tBodyAccJerkMag-arCoeff()4 | tBodyAccJerkMag.arCoeff..4 | tBodyAccJerkMag.arCoeff..4
242 | tBodyGyroMag-mean() | tBodyGyroMag.mean.. | tBodyGyroMag.mean
243 | tBodyGyroMag-std() | tBodyGyroMag.std.. | tBodyGyroMag.std
244 | tBodyGyroMag-mad() | tBodyGyroMag.mad.. | tBodyGyroMag.mad..
245 | tBodyGyroMag-max() | tBodyGyroMag.max.. | tBodyGyroMag.max..
246 | tBodyGyroMag-min() | tBodyGyroMag.min.. | tBodyGyroMag.min..
247 | tBodyGyroMag-sma() | tBodyGyroMag.sma.. | tBodyGyroMag.sma..
248 | tBodyGyroMag-energy() | tBodyGyroMag.energy.. | tBodyGyroMag.energy..
249 | tBodyGyroMag-iqr() | tBodyGyroMag.iqr.. | tBodyGyroMag.iqr..
250 | tBodyGyroMag-entropy() | tBodyGyroMag.entropy.. | tBodyGyroMag.entropy..
251 | tBodyGyroMag-arCoeff()1 | tBodyGyroMag.arCoeff..1 | tBodyGyroMag.arCoeff..1
252 | tBodyGyroMag-arCoeff()2 | tBodyGyroMag.arCoeff..2 | tBodyGyroMag.arCoeff..2
253 | tBodyGyroMag-arCoeff()3 | tBodyGyroMag.arCoeff..3 | tBodyGyroMag.arCoeff..3
254 | tBodyGyroMag-arCoeff()4 | tBodyGyroMag.arCoeff..4 | tBodyGyroMag.arCoeff..4
255 | tBodyGyroJerkMag-mean() | tBodyGyroJerkMag.mean.. | tBodyGyroJerkMag.mean
256 | tBodyGyroJerkMag-std() | tBodyGyroJerkMag.std.. | tBodyGyroJerkMag.std
257 | tBodyGyroJerkMag-mad() | tBodyGyroJerkMag.mad.. | tBodyGyroJerkMag.mad..
258 | tBodyGyroJerkMag-max() | tBodyGyroJerkMag.max.. | tBodyGyroJerkMag.max..
259 | tBodyGyroJerkMag-min() | tBodyGyroJerkMag.min.. | tBodyGyroJerkMag.min..
260 | tBodyGyroJerkMag-sma() | tBodyGyroJerkMag.sma.. | tBodyGyroJerkMag.sma..
261 | tBodyGyroJerkMag-energy() | tBodyGyroJerkMag.energy.. | tBodyGyroJerkMag.energy..
262 | tBodyGyroJerkMag-iqr() | tBodyGyroJerkMag.iqr.. | tBodyGyroJerkMag.iqr..
263 | tBodyGyroJerkMag-entropy() | tBodyGyroJerkMag.entropy.. | tBodyGyroJerkMag.entropy..
264 | tBodyGyroJerkMag-arCoeff()1 | tBodyGyroJerkMag.arCoeff..1 | tBodyGyroJerkMag.arCoeff..1
265 | tBodyGyroJerkMag-arCoeff()2 | tBodyGyroJerkMag.arCoeff..2 | tBodyGyroJerkMag.arCoeff..2
266 | tBodyGyroJerkMag-arCoeff()3 | tBodyGyroJerkMag.arCoeff..3 | tBodyGyroJerkMag.arCoeff..3
267 | tBodyGyroJerkMag-arCoeff()4 | tBodyGyroJerkMag.arCoeff..4 | tBodyGyroJerkMag.arCoeff..4
268 | fBodyAcc-mean()-X | fBodyAcc.mean...X | fBodyAcc.mean.X
269 | fBodyAcc-mean()-Y | fBodyAcc.mean...Y | fBodyAcc.mean.Y
270 | fBodyAcc-mean()-Z | fBodyAcc.mean...Z | fBodyAcc.mean.Z
271 | fBodyAcc-std()-X | fBodyAcc.std...X | fBodyAcc.std.X
272 | fBodyAcc-std()-Y | fBodyAcc.std...Y | fBodyAcc.std.Y
273 | fBodyAcc-std()-Z | fBodyAcc.std...Z | fBodyAcc.std.Z
274 | fBodyAcc-mad()-X | fBodyAcc.mad...X | fBodyAcc.mad...X
275 | fBodyAcc-mad()-Y | fBodyAcc.mad...Y | fBodyAcc.mad...Y
276 | fBodyAcc-mad()-Z | fBodyAcc.mad...Z | fBodyAcc.mad...Z
277 | fBodyAcc-max()-X | fBodyAcc.max...X | fBodyAcc.max...X
278 | fBodyAcc-max()-Y | fBodyAcc.max...Y | fBodyAcc.max...Y
279 | fBodyAcc-max()-Z | fBodyAcc.max...Z | fBodyAcc.max...Z
280 | fBodyAcc-min()-X | fBodyAcc.min...X | fBodyAcc.min...X
281 | fBodyAcc-min()-Y | fBodyAcc.min...Y | fBodyAcc.min...Y
282 | fBodyAcc-min()-Z | fBodyAcc.min...Z | fBodyAcc.min...Z
283 | fBodyAcc-sma() | fBodyAcc.sma.. | fBodyAcc.sma..
284 | fBodyAcc-energy()-X | fBodyAcc.energy...X | fBodyAcc.energy...X
285 | fBodyAcc-energy()-Y | fBodyAcc.energy...Y | fBodyAcc.energy...Y
286 | fBodyAcc-energy()-Z | fBodyAcc.energy...Z | fBodyAcc.energy...Z
287 | fBodyAcc-iqr()-X | fBodyAcc.iqr...X | fBodyAcc.iqr...X
288 | fBodyAcc-iqr()-Y | fBodyAcc.iqr...Y | fBodyAcc.iqr...Y
289 | fBodyAcc-iqr()-Z | fBodyAcc.iqr...Z | fBodyAcc.iqr...Z
290 | fBodyAcc-entropy()-X | fBodyAcc.entropy...X | fBodyAcc.entropy...X
291 | fBodyAcc-entropy()-Y | fBodyAcc.entropy...Y | fBodyAcc.entropy...Y
292 | fBodyAcc-entropy()-Z | fBodyAcc.entropy...Z | fBodyAcc.entropy...Z
293 | fBodyAcc-maxInds-X | fBodyAcc.maxInds.X | fBodyAcc.maxInds.X
294 | fBodyAcc-maxInds-Y | fBodyAcc.maxInds.Y | fBodyAcc.maxInds.Y
295 | fBodyAcc-maxInds-Z | fBodyAcc.maxInds.Z | fBodyAcc.maxInds.Z
296 | fBodyAcc-meanFreq()-X | fBodyAcc.meanFreq...X | fBodyAcc.meaneq...X
297 | fBodyAcc-meanFreq()-Y | fBodyAcc.meanFreq...Y | fBodyAcc.meaneq...Y
298 | fBodyAcc-meanFreq()-Z | fBodyAcc.meanFreq...Z | fBodyAcc.meaneq...Z
299 | fBodyAcc-skewness()-X | fBodyAcc.skewness...X | fBodyAcc.skewness...X
300 | fBodyAcc-kurtosis()-X | fBodyAcc.kurtosis...X | fBodyAcc.kurtosis...X
301 | fBodyAcc-skewness()-Y | fBodyAcc.skewness...Y | fBodyAcc.skewness...Y
302 | fBodyAcc-kurtosis()-Y | fBodyAcc.kurtosis...Y | fBodyAcc.kurtosis...Y
303 | fBodyAcc-skewness()-Z | fBodyAcc.skewness...Z | fBodyAcc.skewness...Z
304 | fBodyAcc-kurtosis()-Z | fBodyAcc.kurtosis...Z | fBodyAcc.kurtosis...Z
305 | fBodyAcc-bandsEnergy()-1,8 | fBodyAcc.bandsEnergy...1.8 | fBodyAcc.bandsEnergy...1.8
306 | fBodyAcc-bandsEnergy()-9,16 | fBodyAcc.bandsEnergy...9.16 | fBodyAcc.bandsEnergy...9.16
307 | fBodyAcc-bandsEnergy()-17,24 | fBodyAcc.bandsEnergy...17.24 | fBodyAcc.bandsEnergy...17.24
308 | fBodyAcc-bandsEnergy()-25,32 | fBodyAcc.bandsEnergy...25.32 | fBodyAcc.bandsEnergy...25.32
309 | fBodyAcc-bandsEnergy()-33,40 | fBodyAcc.bandsEnergy...33.40 | fBodyAcc.bandsEnergy...33.40
310 | fBodyAcc-bandsEnergy()-41,48 | fBodyAcc.bandsEnergy...41.48 | fBodyAcc.bandsEnergy...41.48
311 | fBodyAcc-bandsEnergy()-49,56 | fBodyAcc.bandsEnergy...49.56 | fBodyAcc.bandsEnergy...49.56
312 | fBodyAcc-bandsEnergy()-57,64 | fBodyAcc.bandsEnergy...57.64 | fBodyAcc.bandsEnergy...57.64
313 | fBodyAcc-bandsEnergy()-1,16 | fBodyAcc.bandsEnergy...1.16 | fBodyAcc.bandsEnergy...1.16
314 | fBodyAcc-bandsEnergy()-17,32 | fBodyAcc.bandsEnergy...17.32 | fBodyAcc.bandsEnergy...17.32
315 | fBodyAcc-bandsEnergy()-33,48 | fBodyAcc.bandsEnergy...33.48 | fBodyAcc.bandsEnergy...33.48
316 | fBodyAcc-bandsEnergy()-49,64 | fBodyAcc.bandsEnergy...49.64 | fBodyAcc.bandsEnergy...49.64
317 | fBodyAcc-bandsEnergy()-1,24 | fBodyAcc.bandsEnergy...1.24 | fBodyAcc.bandsEnergy...1.24
318 | fBodyAcc-bandsEnergy()-25,48 | fBodyAcc.bandsEnergy...25.48 | fBodyAcc.bandsEnergy...25.48
319 | fBodyAcc-bandsEnergy()-1,8 | fBodyAcc.bandsEnergy...1.8.1 | fBodyAcc.bandsEnergy...1.8.1
320 | fBodyAcc-bandsEnergy()-9,16 | fBodyAcc.bandsEnergy...9.16.1 | fBodyAcc.bandsEnergy...9.16.1
321 | fBodyAcc-bandsEnergy()-17,24 | fBodyAcc.bandsEnergy...17.24.1 | fBodyAcc.bandsEnergy...17.24.1
322 | fBodyAcc-bandsEnergy()-25,32 | fBodyAcc.bandsEnergy...25.32.1 | fBodyAcc.bandsEnergy...25.32.1
323 | fBodyAcc-bandsEnergy()-33,40 | fBodyAcc.bandsEnergy...33.40.1 | fBodyAcc.bandsEnergy...33.40.1
324 | fBodyAcc-bandsEnergy()-41,48 | fBodyAcc.bandsEnergy...41.48.1 | fBodyAcc.bandsEnergy...41.48.1
325 | fBodyAcc-bandsEnergy()-49,56 | fBodyAcc.bandsEnergy...49.56.1 | fBodyAcc.bandsEnergy...49.56.1
326 | fBodyAcc-bandsEnergy()-57,64 | fBodyAcc.bandsEnergy...57.64.1 | fBodyAcc.bandsEnergy...57.64.1
327 | fBodyAcc-bandsEnergy()-1,16 | fBodyAcc.bandsEnergy...1.16.1 | fBodyAcc.bandsEnergy...1.16.1
328 | fBodyAcc-bandsEnergy()-17,32 | fBodyAcc.bandsEnergy...17.32.1 | fBodyAcc.bandsEnergy...17.32.1
329 | fBodyAcc-bandsEnergy()-33,48 | fBodyAcc.bandsEnergy...33.48.1 | fBodyAcc.bandsEnergy...33.48.1
330 | fBodyAcc-bandsEnergy()-49,64 | fBodyAcc.bandsEnergy...49.64.1 | fBodyAcc.bandsEnergy...49.64.1
331 | fBodyAcc-bandsEnergy()-1,24 | fBodyAcc.bandsEnergy...1.24.1 | fBodyAcc.bandsEnergy...1.24.1
332 | fBodyAcc-bandsEnergy()-25,48 | fBodyAcc.bandsEnergy...25.48.1 | fBodyAcc.bandsEnergy...25.48.1
333 | fBodyAcc-bandsEnergy()-1,8 | fBodyAcc.bandsEnergy...1.8.2 | fBodyAcc.bandsEnergy...1.8.2
334 | fBodyAcc-bandsEnergy()-9,16 | fBodyAcc.bandsEnergy...9.16.2 | fBodyAcc.bandsEnergy...9.16.2
335 | fBodyAcc-bandsEnergy()-17,24 | fBodyAcc.bandsEnergy...17.24.2 | fBodyAcc.bandsEnergy...17.24.2
336 | fBodyAcc-bandsEnergy()-25,32 | fBodyAcc.bandsEnergy...25.32.2 | fBodyAcc.bandsEnergy...25.32.2
337 | fBodyAcc-bandsEnergy()-33,40 | fBodyAcc.bandsEnergy...33.40.2 | fBodyAcc.bandsEnergy...33.40.2
338 | fBodyAcc-bandsEnergy()-41,48 | fBodyAcc.bandsEnergy...41.48.2 | fBodyAcc.bandsEnergy...41.48.2
339 | fBodyAcc-bandsEnergy()-49,56 | fBodyAcc.bandsEnergy...49.56.2 | fBodyAcc.bandsEnergy...49.56.2
340 | fBodyAcc-bandsEnergy()-57,64 | fBodyAcc.bandsEnergy...57.64.2 | fBodyAcc.bandsEnergy...57.64.2
341 | fBodyAcc-bandsEnergy()-1,16 | fBodyAcc.bandsEnergy...1.16.2 | fBodyAcc.bandsEnergy...1.16.2
342 | fBodyAcc-bandsEnergy()-17,32 | fBodyAcc.bandsEnergy...17.32.2 | fBodyAcc.bandsEnergy...17.32.2
343 | fBodyAcc-bandsEnergy()-33,48 | fBodyAcc.bandsEnergy...33.48.2 | fBodyAcc.bandsEnergy...33.48.2
344 | fBodyAcc-bandsEnergy()-49,64 | fBodyAcc.bandsEnergy...49.64.2 | fBodyAcc.bandsEnergy...49.64.2
345 | fBodyAcc-bandsEnergy()-1,24 | fBodyAcc.bandsEnergy...1.24.2 | fBodyAcc.bandsEnergy...1.24.2
346 | fBodyAcc-bandsEnergy()-25,48 | fBodyAcc.bandsEnergy...25.48.2 | fBodyAcc.bandsEnergy...25.48.2
347 | fBodyAccJerk-mean()-X | fBodyAccJerk.mean...X | fBodyAccJerk.mean.X
348 | fBodyAccJerk-mean()-Y | fBodyAccJerk.mean...Y | fBodyAccJerk.mean.Y
349 | fBodyAccJerk-mean()-Z | fBodyAccJerk.mean...Z | fBodyAccJerk.mean.Z
350 | fBodyAccJerk-std()-X | fBodyAccJerk.std...X | fBodyAccJerk.std.X
351 | fBodyAccJerk-std()-Y | fBodyAccJerk.std...Y | fBodyAccJerk.std.Y
352 | fBodyAccJerk-std()-Z | fBodyAccJerk.std...Z | fBodyAccJerk.std.Z
353 | fBodyAccJerk-mad()-X | fBodyAccJerk.mad...X | fBodyAccJerk.mad...X
354 | fBodyAccJerk-mad()-Y | fBodyAccJerk.mad...Y | fBodyAccJerk.mad...Y
355 | fBodyAccJerk-mad()-Z | fBodyAccJerk.mad...Z | fBodyAccJerk.mad...Z
356 | fBodyAccJerk-max()-X | fBodyAccJerk.max...X | fBodyAccJerk.max...X
357 | fBodyAccJerk-max()-Y | fBodyAccJerk.max...Y | fBodyAccJerk.max...Y
358 | fBodyAccJerk-max()-Z | fBodyAccJerk.max...Z | fBodyAccJerk.max...Z
359 | fBodyAccJerk-min()-X | fBodyAccJerk.min...X | fBodyAccJerk.min...X
360 | fBodyAccJerk-min()-Y | fBodyAccJerk.min...Y | fBodyAccJerk.min...Y
361 | fBodyAccJerk-min()-Z | fBodyAccJerk.min...Z | fBodyAccJerk.min...Z
362 | fBodyAccJerk-sma() | fBodyAccJerk.sma.. | fBodyAccJerk.sma..
363 | fBodyAccJerk-energy()-X | fBodyAccJerk.energy...X | fBodyAccJerk.energy...X
364 | fBodyAccJerk-energy()-Y | fBodyAccJerk.energy...Y | fBodyAccJerk.energy...Y
365 | fBodyAccJerk-energy()-Z | fBodyAccJerk.energy...Z | fBodyAccJerk.energy...Z
366 | fBodyAccJerk-iqr()-X | fBodyAccJerk.iqr...X | fBodyAccJerk.iqr...X
367 | fBodyAccJerk-iqr()-Y | fBodyAccJerk.iqr...Y | fBodyAccJerk.iqr...Y
368 | fBodyAccJerk-iqr()-Z | fBodyAccJerk.iqr...Z | fBodyAccJerk.iqr...Z
369 | fBodyAccJerk-entropy()-X | fBodyAccJerk.entropy...X | fBodyAccJerk.entropy...X
370 | fBodyAccJerk-entropy()-Y | fBodyAccJerk.entropy...Y | fBodyAccJerk.entropy...Y
371 | fBodyAccJerk-entropy()-Z | fBodyAccJerk.entropy...Z | fBodyAccJerk.entropy...Z
372 | fBodyAccJerk-maxInds-X | fBodyAccJerk.maxInds.X | fBodyAccJerk.maxInds.X
373 | fBodyAccJerk-maxInds-Y | fBodyAccJerk.maxInds.Y | fBodyAccJerk.maxInds.Y
374 | fBodyAccJerk-maxInds-Z | fBodyAccJerk.maxInds.Z | fBodyAccJerk.maxInds.Z
375 | fBodyAccJerk-meanFreq()-X | fBodyAccJerk.meanFreq...X | fBodyAccJerk.meaneq...X
376 | fBodyAccJerk-meanFreq()-Y | fBodyAccJerk.meanFreq...Y | fBodyAccJerk.meaneq...Y
377 | fBodyAccJerk-meanFreq()-Z | fBodyAccJerk.meanFreq...Z | fBodyAccJerk.meaneq...Z
378 | fBodyAccJerk-skewness()-X | fBodyAccJerk.skewness...X | fBodyAccJerk.skewness...X
379 | fBodyAccJerk-kurtosis()-X | fBodyAccJerk.kurtosis...X | fBodyAccJerk.kurtosis...X
380 | fBodyAccJerk-skewness()-Y | fBodyAccJerk.skewness...Y | fBodyAccJerk.skewness...Y
381 | fBodyAccJerk-kurtosis()-Y | fBodyAccJerk.kurtosis...Y | fBodyAccJerk.kurtosis...Y
382 | fBodyAccJerk-skewness()-Z | fBodyAccJerk.skewness...Z | fBodyAccJerk.skewness...Z
383 | fBodyAccJerk-kurtosis()-Z | fBodyAccJerk.kurtosis...Z | fBodyAccJerk.kurtosis...Z
384 | fBodyAccJerk-bandsEnergy()-1,8 | fBodyAccJerk.bandsEnergy...1.8 | fBodyAccJerk.bandsEnergy...1.8
385 | fBodyAccJerk-bandsEnergy()-9,16 | fBodyAccJerk.bandsEnergy...9.16 | fBodyAccJerk.bandsEnergy...9.16
386 | fBodyAccJerk-bandsEnergy()-17,24 | fBodyAccJerk.bandsEnergy...17.24 | fBodyAccJerk.bandsEnergy...17.24
387 | fBodyAccJerk-bandsEnergy()-25,32 | fBodyAccJerk.bandsEnergy...25.32 | fBodyAccJerk.bandsEnergy...25.32
388 | fBodyAccJerk-bandsEnergy()-33,40 | fBodyAccJerk.bandsEnergy...33.40 | fBodyAccJerk.bandsEnergy...33.40
389 | fBodyAccJerk-bandsEnergy()-41,48 | fBodyAccJerk.bandsEnergy...41.48 | fBodyAccJerk.bandsEnergy...41.48
390 | fBodyAccJerk-bandsEnergy()-49,56 | fBodyAccJerk.bandsEnergy...49.56 | fBodyAccJerk.bandsEnergy...49.56
391 | fBodyAccJerk-bandsEnergy()-57,64 | fBodyAccJerk.bandsEnergy...57.64 | fBodyAccJerk.bandsEnergy...57.64
392 | fBodyAccJerk-bandsEnergy()-1,16 | fBodyAccJerk.bandsEnergy...1.16 | fBodyAccJerk.bandsEnergy...1.16
393 | fBodyAccJerk-bandsEnergy()-17,32 | fBodyAccJerk.bandsEnergy...17.32 | fBodyAccJerk.bandsEnergy...17.32
394 | fBodyAccJerk-bandsEnergy()-33,48 | fBodyAccJerk.bandsEnergy...33.48 | fBodyAccJerk.bandsEnergy...33.48
395 | fBodyAccJerk-bandsEnergy()-49,64 | fBodyAccJerk.bandsEnergy...49.64 | fBodyAccJerk.bandsEnergy...49.64
396 | fBodyAccJerk-bandsEnergy()-1,24 | fBodyAccJerk.bandsEnergy...1.24 | fBodyAccJerk.bandsEnergy...1.24
397 | fBodyAccJerk-bandsEnergy()-25,48 | fBodyAccJerk.bandsEnergy...25.48 | fBodyAccJerk.bandsEnergy...25.48
398 | fBodyAccJerk-bandsEnergy()-1,8 | fBodyAccJerk.bandsEnergy...1.8.1 | fBodyAccJerk.bandsEnergy...1.8.1
399 | fBodyAccJerk-bandsEnergy()-9,16 | fBodyAccJerk.bandsEnergy...9.16.1 | fBodyAccJerk.bandsEnergy...9.16.1
400 | fBodyAccJerk-bandsEnergy()-17,24 | fBodyAccJerk.bandsEnergy...17.24.1 | fBodyAccJerk.bandsEnergy...17.24.1
401 | fBodyAccJerk-bandsEnergy()-25,32 | fBodyAccJerk.bandsEnergy...25.32.1 | fBodyAccJerk.bandsEnergy...25.32.1
402 | fBodyAccJerk-bandsEnergy()-33,40 | fBodyAccJerk.bandsEnergy...33.40.1 | fBodyAccJerk.bandsEnergy...33.40.1
403 | fBodyAccJerk-bandsEnergy()-41,48 | fBodyAccJerk.bandsEnergy...41.48.1 | fBodyAccJerk.bandsEnergy...41.48.1
404 | fBodyAccJerk-bandsEnergy()-49,56 | fBodyAccJerk.bandsEnergy...49.56.1 | fBodyAccJerk.bandsEnergy...49.56.1
405 | fBodyAccJerk-bandsEnergy()-57,64 | fBodyAccJerk.bandsEnergy...57.64.1 | fBodyAccJerk.bandsEnergy...57.64.1
406 | fBodyAccJerk-bandsEnergy()-1,16 | fBodyAccJerk.bandsEnergy...1.16.1 | fBodyAccJerk.bandsEnergy...1.16.1
407 | fBodyAccJerk-bandsEnergy()-17,32 | fBodyAccJerk.bandsEnergy...17.32.1 | fBodyAccJerk.bandsEnergy...17.32.1
408 | fBodyAccJerk-bandsEnergy()-33,48 | fBodyAccJerk.bandsEnergy...33.48.1 | fBodyAccJerk.bandsEnergy...33.48.1
409 | fBodyAccJerk-bandsEnergy()-49,64 | fBodyAccJerk.bandsEnergy...49.64.1 | fBodyAccJerk.bandsEnergy...49.64.1
410 | fBodyAccJerk-bandsEnergy()-1,24 | fBodyAccJerk.bandsEnergy...1.24.1 | fBodyAccJerk.bandsEnergy...1.24.1
411 | fBodyAccJerk-bandsEnergy()-25,48 | fBodyAccJerk.bandsEnergy...25.48.1 | fBodyAccJerk.bandsEnergy...25.48.1
412 | fBodyAccJerk-bandsEnergy()-1,8 | fBodyAccJerk.bandsEnergy...1.8.2 | fBodyAccJerk.bandsEnergy...1.8.2
413 | fBodyAccJerk-bandsEnergy()-9,16 | fBodyAccJerk.bandsEnergy...9.16.2 | fBodyAccJerk.bandsEnergy...9.16.2
414 | fBodyAccJerk-bandsEnergy()-17,24 | fBodyAccJerk.bandsEnergy...17.24.2 | fBodyAccJerk.bandsEnergy...17.24.2
415 | fBodyAccJerk-bandsEnergy()-25,32 | fBodyAccJerk.bandsEnergy...25.32.2 | fBodyAccJerk.bandsEnergy...25.32.2
416 | fBodyAccJerk-bandsEnergy()-33,40 | fBodyAccJerk.bandsEnergy...33.40.2 | fBodyAccJerk.bandsEnergy...33.40.2
417 | fBodyAccJerk-bandsEnergy()-41,48 | fBodyAccJerk.bandsEnergy...41.48.2 | fBodyAccJerk.bandsEnergy...41.48.2
418 | fBodyAccJerk-bandsEnergy()-49,56 | fBodyAccJerk.bandsEnergy...49.56.2 | fBodyAccJerk.bandsEnergy...49.56.2
419 | fBodyAccJerk-bandsEnergy()-57,64 | fBodyAccJerk.bandsEnergy...57.64.2 | fBodyAccJerk.bandsEnergy...57.64.2
420 | fBodyAccJerk-bandsEnergy()-1,16 | fBodyAccJerk.bandsEnergy...1.16.2 | fBodyAccJerk.bandsEnergy...1.16.2
421 | fBodyAccJerk-bandsEnergy()-17,32 | fBodyAccJerk.bandsEnergy...17.32.2 | fBodyAccJerk.bandsEnergy...17.32.2
422 | fBodyAccJerk-bandsEnergy()-33,48 | fBodyAccJerk.bandsEnergy...33.48.2 | fBodyAccJerk.bandsEnergy...33.48.2
423 | fBodyAccJerk-bandsEnergy()-49,64 | fBodyAccJerk.bandsEnergy...49.64.2 | fBodyAccJerk.bandsEnergy...49.64.2
424 | fBodyAccJerk-bandsEnergy()-1,24 | fBodyAccJerk.bandsEnergy...1.24.2 | fBodyAccJerk.bandsEnergy...1.24.2
425 | fBodyAccJerk-bandsEnergy()-25,48 | fBodyAccJerk.bandsEnergy...25.48.2 | fBodyAccJerk.bandsEnergy...25.48.2
426 | fBodyGyro-mean()-X | fBodyGyro.mean...X | fBodyGyro.mean.X
427 | fBodyGyro-mean()-Y | fBodyGyro.mean...Y | fBodyGyro.mean.Y
428 | fBodyGyro-mean()-Z | fBodyGyro.mean...Z | fBodyGyro.mean.Z
429 | fBodyGyro-std()-X | fBodyGyro.std...X | fBodyGyro.std.X
430 | fBodyGyro-std()-Y | fBodyGyro.std...Y | fBodyGyro.std.Y
431 | fBodyGyro-std()-Z | fBodyGyro.std...Z | fBodyGyro.std.Z
432 | fBodyGyro-mad()-X | fBodyGyro.mad...X | fBodyGyro.mad...X
433 | fBodyGyro-mad()-Y | fBodyGyro.mad...Y | fBodyGyro.mad...Y
434 | fBodyGyro-mad()-Z | fBodyGyro.mad...Z | fBodyGyro.mad...Z
435 | fBodyGyro-max()-X | fBodyGyro.max...X | fBodyGyro.max...X
436 | fBodyGyro-max()-Y | fBodyGyro.max...Y | fBodyGyro.max...Y
437 | fBodyGyro-max()-Z | fBodyGyro.max...Z | fBodyGyro.max...Z
438 | fBodyGyro-min()-X | fBodyGyro.min...X | fBodyGyro.min...X
439 | fBodyGyro-min()-Y | fBodyGyro.min...Y | fBodyGyro.min...Y
440 | fBodyGyro-min()-Z | fBodyGyro.min...Z | fBodyGyro.min...Z
441 | fBodyGyro-sma() | fBodyGyro.sma.. | fBodyGyro.sma..
442 | fBodyGyro-energy()-X | fBodyGyro.energy...X | fBodyGyro.energy...X
443 | fBodyGyro-energy()-Y | fBodyGyro.energy...Y | fBodyGyro.energy...Y
444 | fBodyGyro-energy()-Z | fBodyGyro.energy...Z | fBodyGyro.energy...Z
445 | fBodyGyro-iqr()-X | fBodyGyro.iqr...X | fBodyGyro.iqr...X
446 | fBodyGyro-iqr()-Y | fBodyGyro.iqr...Y | fBodyGyro.iqr...Y
447 | fBodyGyro-iqr()-Z | fBodyGyro.iqr...Z | fBodyGyro.iqr...Z
448 | fBodyGyro-entropy()-X | fBodyGyro.entropy...X | fBodyGyro.entropy...X
449 | fBodyGyro-entropy()-Y | fBodyGyro.entropy...Y | fBodyGyro.entropy...Y
450 | fBodyGyro-entropy()-Z | fBodyGyro.entropy...Z | fBodyGyro.entropy...Z
451 | fBodyGyro-maxInds-X | fBodyGyro.maxInds.X | fBodyGyro.maxInds.X
452 | fBodyGyro-maxInds-Y | fBodyGyro.maxInds.Y | fBodyGyro.maxInds.Y
453 | fBodyGyro-maxInds-Z | fBodyGyro.maxInds.Z | fBodyGyro.maxInds.Z
454 | fBodyGyro-meanFreq()-X | fBodyGyro.meanFreq...X | fBodyGyro.meaneq...X
455 | fBodyGyro-meanFreq()-Y | fBodyGyro.meanFreq...Y | fBodyGyro.meaneq...Y
456 | fBodyGyro-meanFreq()-Z | fBodyGyro.meanFreq...Z | fBodyGyro.meaneq...Z
457 | fBodyGyro-skewness()-X | fBodyGyro.skewness...X | fBodyGyro.skewness...X
458 | fBodyGyro-kurtosis()-X | fBodyGyro.kurtosis...X | fBodyGyro.kurtosis...X
459 | fBodyGyro-skewness()-Y | fBodyGyro.skewness...Y | fBodyGyro.skewness...Y
460 | fBodyGyro-kurtosis()-Y | fBodyGyro.kurtosis...Y | fBodyGyro.kurtosis...Y
461 | fBodyGyro-skewness()-Z | fBodyGyro.skewness...Z | fBodyGyro.skewness...Z
462 | fBodyGyro-kurtosis()-Z | fBodyGyro.kurtosis...Z | fBodyGyro.kurtosis...Z
463 | fBodyGyro-bandsEnergy()-1,8 | fBodyGyro.bandsEnergy...1.8 | fBodyGyro.bandsEnergy...1.8
464 | fBodyGyro-bandsEnergy()-9,16 | fBodyGyro.bandsEnergy...9.16 | fBodyGyro.bandsEnergy...9.16
465 | fBodyGyro-bandsEnergy()-17,24 | fBodyGyro.bandsEnergy...17.24 | fBodyGyro.bandsEnergy...17.24
466 | fBodyGyro-bandsEnergy()-25,32 | fBodyGyro.bandsEnergy...25.32 | fBodyGyro.bandsEnergy...25.32
467 | fBodyGyro-bandsEnergy()-33,40 | fBodyGyro.bandsEnergy...33.40 | fBodyGyro.bandsEnergy...33.40
468 | fBodyGyro-bandsEnergy()-41,48 | fBodyGyro.bandsEnergy...41.48 | fBodyGyro.bandsEnergy...41.48
469 | fBodyGyro-bandsEnergy()-49,56 | fBodyGyro.bandsEnergy...49.56 | fBodyGyro.bandsEnergy...49.56
470 | fBodyGyro-bandsEnergy()-57,64 | fBodyGyro.bandsEnergy...57.64 | fBodyGyro.bandsEnergy...57.64
471 | fBodyGyro-bandsEnergy()-1,16 | fBodyGyro.bandsEnergy...1.16 | fBodyGyro.bandsEnergy...1.16
472 | fBodyGyro-bandsEnergy()-17,32 | fBodyGyro.bandsEnergy...17.32 | fBodyGyro.bandsEnergy...17.32
473 | fBodyGyro-bandsEnergy()-33,48 | fBodyGyro.bandsEnergy...33.48 | fBodyGyro.bandsEnergy...33.48
474 | fBodyGyro-bandsEnergy()-49,64 | fBodyGyro.bandsEnergy...49.64 | fBodyGyro.bandsEnergy...49.64
475 | fBodyGyro-bandsEnergy()-1,24 | fBodyGyro.bandsEnergy...1.24 | fBodyGyro.bandsEnergy...1.24
476 | fBodyGyro-bandsEnergy()-25,48 | fBodyGyro.bandsEnergy...25.48 | fBodyGyro.bandsEnergy...25.48
477 | fBodyGyro-bandsEnergy()-1,8 | fBodyGyro.bandsEnergy...1.8.1 | fBodyGyro.bandsEnergy...1.8.1
478 | fBodyGyro-bandsEnergy()-9,16 | fBodyGyro.bandsEnergy...9.16.1 | fBodyGyro.bandsEnergy...9.16.1
479 | fBodyGyro-bandsEnergy()-17,24 | fBodyGyro.bandsEnergy...17.24.1 | fBodyGyro.bandsEnergy...17.24.1
480 | fBodyGyro-bandsEnergy()-25,32 | fBodyGyro.bandsEnergy...25.32.1 | fBodyGyro.bandsEnergy...25.32.1
481 | fBodyGyro-bandsEnergy()-33,40 | fBodyGyro.bandsEnergy...33.40.1 | fBodyGyro.bandsEnergy...33.40.1
482 | fBodyGyro-bandsEnergy()-41,48 | fBodyGyro.bandsEnergy...41.48.1 | fBodyGyro.bandsEnergy...41.48.1
483 | fBodyGyro-bandsEnergy()-49,56 | fBodyGyro.bandsEnergy...49.56.1 | fBodyGyro.bandsEnergy...49.56.1
484 | fBodyGyro-bandsEnergy()-57,64 | fBodyGyro.bandsEnergy...57.64.1 | fBodyGyro.bandsEnergy...57.64.1
485 | fBodyGyro-bandsEnergy()-1,16 | fBodyGyro.bandsEnergy...1.16.1 | fBodyGyro.bandsEnergy...1.16.1
486 | fBodyGyro-bandsEnergy()-17,32 | fBodyGyro.bandsEnergy...17.32.1 | fBodyGyro.bandsEnergy...17.32.1
487 | fBodyGyro-bandsEnergy()-33,48 | fBodyGyro.bandsEnergy...33.48.1 | fBodyGyro.bandsEnergy...33.48.1
488 | fBodyGyro-bandsEnergy()-49,64 | fBodyGyro.bandsEnergy...49.64.1 | fBodyGyro.bandsEnergy...49.64.1
489 | fBodyGyro-bandsEnergy()-1,24 | fBodyGyro.bandsEnergy...1.24.1 | fBodyGyro.bandsEnergy...1.24.1
490 | fBodyGyro-bandsEnergy()-25,48 | fBodyGyro.bandsEnergy...25.48.1 | fBodyGyro.bandsEnergy...25.48.1
491 | fBodyGyro-bandsEnergy()-1,8 | fBodyGyro.bandsEnergy...1.8.2 | fBodyGyro.bandsEnergy...1.8.2
492 | fBodyGyro-bandsEnergy()-9,16 | fBodyGyro.bandsEnergy...9.16.2 | fBodyGyro.bandsEnergy...9.16.2
493 | fBodyGyro-bandsEnergy()-17,24 | fBodyGyro.bandsEnergy...17.24.2 | fBodyGyro.bandsEnergy...17.24.2
494 | fBodyGyro-bandsEnergy()-25,32 | fBodyGyro.bandsEnergy...25.32.2 | fBodyGyro.bandsEnergy...25.32.2
495 | fBodyGyro-bandsEnergy()-33,40 | fBodyGyro.bandsEnergy...33.40.2 | fBodyGyro.bandsEnergy...33.40.2
496 | fBodyGyro-bandsEnergy()-41,48 | fBodyGyro.bandsEnergy...41.48.2 | fBodyGyro.bandsEnergy...41.48.2
497 | fBodyGyro-bandsEnergy()-49,56 | fBodyGyro.bandsEnergy...49.56.2 | fBodyGyro.bandsEnergy...49.56.2
498 | fBodyGyro-bandsEnergy()-57,64 | fBodyGyro.bandsEnergy...57.64.2 | fBodyGyro.bandsEnergy...57.64.2
499 | fBodyGyro-bandsEnergy()-1,16 | fBodyGyro.bandsEnergy...1.16.2 | fBodyGyro.bandsEnergy...1.16.2
500 | fBodyGyro-bandsEnergy()-17,32 | fBodyGyro.bandsEnergy...17.32.2 | fBodyGyro.bandsEnergy...17.32.2
501 | fBodyGyro-bandsEnergy()-33,48 | fBodyGyro.bandsEnergy...33.48.2 | fBodyGyro.bandsEnergy...33.48.2
502 | fBodyGyro-bandsEnergy()-49,64 | fBodyGyro.bandsEnergy...49.64.2 | fBodyGyro.bandsEnergy...49.64.2
503 | fBodyGyro-bandsEnergy()-1,24 | fBodyGyro.bandsEnergy...1.24.2 | fBodyGyro.bandsEnergy...1.24.2
504 | fBodyGyro-bandsEnergy()-25,48 | fBodyGyro.bandsEnergy...25.48.2 | fBodyGyro.bandsEnergy...25.48.2
505 | fBodyAccMag-mean() | fBodyAccMag.mean.. | fBodyAccMag.mean
506 | fBodyAccMag-std() | fBodyAccMag.std.. | fBodyAccMag.std
507 | fBodyAccMag-mad() | fBodyAccMag.mad.. | fBodyAccMag.mad..
508 | fBodyAccMag-max() | fBodyAccMag.max.. | fBodyAccMag.max..
509 | fBodyAccMag-min() | fBodyAccMag.min.. | fBodyAccMag.min..
510 | fBodyAccMag-sma() | fBodyAccMag.sma.. | fBodyAccMag.sma..
511 | fBodyAccMag-energy() | fBodyAccMag.energy.. | fBodyAccMag.energy..
512 | fBodyAccMag-iqr() | fBodyAccMag.iqr.. | fBodyAccMag.iqr..
513 | fBodyAccMag-entropy() | fBodyAccMag.entropy.. | fBodyAccMag.entropy..
514 | fBodyAccMag-maxInds | fBodyAccMag.maxInds | fBodyAccMag.maxInds
515 | fBodyAccMag-meanFreq() | fBodyAccMag.meanFreq.. | fBodyAccMag.meaneq..
516 | fBodyAccMag-skewness() | fBodyAccMag.skewness.. | fBodyAccMag.skewness..
517 | fBodyAccMag-kurtosis() | fBodyAccMag.kurtosis.. | fBodyAccMag.kurtosis..
518 | fBodyBodyAccJerkMag-mean() | fBodyBodyAccJerkMag.mean.. | fBodyBodyAccJerkMag.mean
519 | fBodyBodyAccJerkMag-std() | fBodyBodyAccJerkMag.std.. | fBodyBodyAccJerkMag.std
520 | fBodyBodyAccJerkMag-mad() | fBodyBodyAccJerkMag.mad.. | fBodyBodyAccJerkMag.mad..
521 | fBodyBodyAccJerkMag-max() | fBodyBodyAccJerkMag.max.. | fBodyBodyAccJerkMag.max..
522 | fBodyBodyAccJerkMag-min() | fBodyBodyAccJerkMag.min.. | fBodyBodyAccJerkMag.min..
523 | fBodyBodyAccJerkMag-sma() | fBodyBodyAccJerkMag.sma.. | fBodyBodyAccJerkMag.sma..
524 | fBodyBodyAccJerkMag-energy() | fBodyBodyAccJerkMag.energy.. | fBodyBodyAccJerkMag.energy..
525 | fBodyBodyAccJerkMag-iqr() | fBodyBodyAccJerkMag.iqr.. | fBodyBodyAccJerkMag.iqr..
526 | fBodyBodyAccJerkMag-entropy() | fBodyBodyAccJerkMag.entropy.. | fBodyBodyAccJerkMag.entropy..
527 | fBodyBodyAccJerkMag-maxInds | fBodyBodyAccJerkMag.maxInds | fBodyBodyAccJerkMag.maxInds
528 | fBodyBodyAccJerkMag-meanFreq() | fBodyBodyAccJerkMag.meanFreq.. | fBodyBodyAccJerkMag.meaneq..
529 | fBodyBodyAccJerkMag-skewness() | fBodyBodyAccJerkMag.skewness.. | fBodyBodyAccJerkMag.skewness..
530 | fBodyBodyAccJerkMag-kurtosis() | fBodyBodyAccJerkMag.kurtosis.. | fBodyBodyAccJerkMag.kurtosis..
531 | fBodyBodyGyroMag-mean() | fBodyBodyGyroMag.mean.. | fBodyBodyGyroMag.mean
532 | fBodyBodyGyroMag-std() | fBodyBodyGyroMag.std.. | fBodyBodyGyroMag.std
533 | fBodyBodyGyroMag-mad() | fBodyBodyGyroMag.mad.. | fBodyBodyGyroMag.mad..
534 | fBodyBodyGyroMag-max() | fBodyBodyGyroMag.max.. | fBodyBodyGyroMag.max..
535 | fBodyBodyGyroMag-min() | fBodyBodyGyroMag.min.. | fBodyBodyGyroMag.min..
536 | fBodyBodyGyroMag-sma() | fBodyBodyGyroMag.sma.. | fBodyBodyGyroMag.sma..
537 | fBodyBodyGyroMag-energy() | fBodyBodyGyroMag.energy.. | fBodyBodyGyroMag.energy..
538 | fBodyBodyGyroMag-iqr() | fBodyBodyGyroMag.iqr.. | fBodyBodyGyroMag.iqr..
539 | fBodyBodyGyroMag-entropy() | fBodyBodyGyroMag.entropy.. | fBodyBodyGyroMag.entropy..
540 | fBodyBodyGyroMag-maxInds | fBodyBodyGyroMag.maxInds | fBodyBodyGyroMag.maxInds
541 | fBodyBodyGyroMag-meanFreq() | fBodyBodyGyroMag.meanFreq.. | fBodyBodyGyroMag.meaneq..
542 | fBodyBodyGyroMag-skewness() | fBodyBodyGyroMag.skewness.. | fBodyBodyGyroMag.skewness..
543 | fBodyBodyGyroMag-kurtosis() | fBodyBodyGyroMag.kurtosis.. | fBodyBodyGyroMag.kurtosis..
544 | fBodyBodyGyroJerkMag-mean() | fBodyBodyGyroJerkMag.mean.. | fBodyBodyGyroJerkMag.mean
545 | fBodyBodyGyroJerkMag-std() | fBodyBodyGyroJerkMag.std.. | fBodyBodyGyroJerkMag.std
546 | fBodyBodyGyroJerkMag-mad() | fBodyBodyGyroJerkMag.mad.. | fBodyBodyGyroJerkMag.mad..
547 | fBodyBodyGyroJerkMag-max() | fBodyBodyGyroJerkMag.max.. | fBodyBodyGyroJerkMag.max..
548 | fBodyBodyGyroJerkMag-min() | fBodyBodyGyroJerkMag.min.. | fBodyBodyGyroJerkMag.min..
549 | fBodyBodyGyroJerkMag-sma() | fBodyBodyGyroJerkMag.sma.. | fBodyBodyGyroJerkMag.sma..
550 | fBodyBodyGyroJerkMag-energy() | fBodyBodyGyroJerkMag.energy.. | fBodyBodyGyroJerkMag.energy..
551 | fBodyBodyGyroJerkMag-iqr() | fBodyBodyGyroJerkMag.iqr.. | fBodyBodyGyroJerkMag.iqr..
552 | fBodyBodyGyroJerkMag-entropy() | fBodyBodyGyroJerkMag.entropy.. | fBodyBodyGyroJerkMag.entropy..
553 | fBodyBodyGyroJerkMag-maxInds | fBodyBodyGyroJerkMag.maxInds | fBodyBodyGyroJerkMag.maxInds
554 | fBodyBodyGyroJerkMag-meanFreq() | fBodyBodyGyroJerkMag.meanFreq.. | fBodyBodyGyroJerkMag.meaneq..
555 | fBodyBodyGyroJerkMag-skewness() | fBodyBodyGyroJerkMag.skewness.. | fBodyBodyGyroJerkMag.skewness..
556 | fBodyBodyGyroJerkMag-kurtosis() | fBodyBodyGyroJerkMag.kurtosis.. | fBodyBodyGyroJerkMag.kurtosis..
557 | angle(tBodyAccMean,gravity) | angle.tBodyAccMean.gravity. | angle.tBodyAccMean.gravity.
558 | angle(tBodyAccJerkMean),gravityMean) | angle.tBodyAccJerkMean..gravityMean. | angle.tBodyAccJerkMean..gravityMean.
559 | angle(tBodyGyroMean,gravityMean) | angle.tBodyGyroMean.gravityMean. | angle.tBodyGyroMean.gravityMean.
560 | angle(tBodyGyroJerkMean,gravityMean) | angle.tBodyGyroJerkMean.gravityMean. | angle.tBodyGyroJerkMean.gravityMean.
561 | angle(X,gravityMean) | angle.X.gravityMean. | angle.X.gravityMean.
562 | angle(Y,gravityMean) | angle.Y.gravityMean. | angle.Y.gravityMean.
563 | angle(Z,gravityMean) | angle.Z.gravityMean. | angle.Z.gravityMean.
