run_analysis <- function(){ 

library(plyr)
library(data.table)
#if(!file.exists("./datascience")){
#  dir.create("/datascience")
#}
#setwd("./datascience")
#if(!file.exists("./cleaning")){
#  dir.create("./cleaning")
  #setwd("..")
#}
#setwd("./cleaning")

## download data to working directory code
## or just do it
setwd("./UCI HAR Dataset")

ActivityLabels<-read.table("features.txt",header=FALSE,quote="")

#read test subject id, activity codes, activity data
TestSubject<-read.table("./test/subject_test.txt",header=FALSE,quote="")
TestCodeActivity<-read.table("./test/y_test.txt",header=FALSE,quote="")
TestActivity<-read.table("./test/X_test.txt",header=FALSE,quote="")

#read train subject id, activity codes, activity data
TrainSubject<-read.table("./train/subject_train.txt",header=FALSE,quote="")
TrainCodeActivity<-read.table("./train/y_train.txt",header=FALSE,quote="")
TrainActivity<-read.table("./train/X_train.txt",header=FALSE,quote="")


## 1 merge test and training data into one data set
testData<-cbind(TestSubject,TestCodeActivity,TestActivity)
trainData<-cbind(TrainSubject,TrainCodeActivity,TrainActivity)
mergeData<-arrange(rbind(testData,trainData),V1)

## 2 remove extra columns in merged data and Labels
index<-grep("*-mean\\(\\)|*std\\(\\)",ActivityLabels[,2])
trimActivityLabels<-ActivityLabels[c(index),]
trimData<-mergeData[ ,c(index+2)]
trimData<-cbind(mergeData[,1:2],trimData)

##3 add activity
trimData$V1.1<-gsub(1,c("Walking"),trimData$V1.1)
trimData$V1.1<-gsub(2,c("Walking_Upstairs"),trimData$V1.1)
trimData$V1.1<-gsub(3,c("Walking_Downstairs"),trimData$V1.1)
trimData$V1.1<-gsub(4,c("Sitting"),trimData$V1.1)
trimData$V1.1<-gsub(5,c("Standing"),trimData$V1.1)
trimData$V1.1<-gsub(6,c("Laying"),trimData$V1.1)

##4 descriptive names for the variables
trimActivityLabels<-data.frame(lapply(trimActivityLabels, as.character), stringsAsFactors=FALSE)
setnames(trimData,1,c("SubjectID"))
setnames(trimData,2,c("Activity"))
setnames(trimData,3:68,trimActivityLabels[1:66,2])

#5 Create second independent data set with average of each data set

tidyData<-aggregate(trimData,by=list(trimData$SubjectID,trimData$Activity),FUN=mean,na.rm=TRUE)
tidyData<-tidyData[,-c(3,4)]
setnames(tidyData,1,c("SubjectID"))
setnames(tidyData,2,c("Activity"))
tidyData<-arrange(tidyData,SubjectID)

write.table(tidyData,file="tidyData.txt")

}