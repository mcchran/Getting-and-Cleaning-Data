###This is the codebook coming to describe produced by runAnalysis.R ###

Tidy data set, named **"tidyset"**, affords 160 variables and 180 observations. 
It is produced after the initial data set **"UCI HAR Dataset"** which contains 
the 3-axial measuremnts (linear acceleration and 3-axial angular velocity) 
comming from experiments, that have been carried out with a group of 30 
volunteers, who performed six activities (WALKING, WALKING UPSTAIRS, 
WALKING DOWNSTAIRS, SITTING, STANDING, LAYING). 

Variables of **tidyset**:

<pre><code>
subject.id: the identifier of the volunteer the observation belongs to
activity: a factor describing the kind of the activity of the specific observation
</code></pre>


Tidy data set contains the mean and standrard deviation of the features 
on the mean and standard deviation for each measurement
as descibed in *./UCI HAR Dataset/features_info.txt*.
Concequently the Rest of the Variables are divided into two classes, 
the **standard deviation** denoted as

<pre><code>
{variableName}_sd
</code></pre>
and the **mean** ones 
<pre><code>
{variableName}_mean
</code></pre>
**grouped by** the **subject_id** as well as **acivity** variables. 
Note that *{variableName}* parts are aligned to the feature names
extracted from *./UCI HAR Dataset/features.txt*

