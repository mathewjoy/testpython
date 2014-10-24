##download file
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",paste(getwd(),"idaho_housing.csv",sep='/'),"wget")
##data dic
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf",paste(getwd(),"idaho_housing_dict.pdf",sep='/'),"wget")
##list of installed packages
#library()
##list the pakcage versions
#installed.packages()[,c("Package","Version")]

##http://stackoverflow.com/questions/22229109/r-data-table-fread-command-how-to-read-large-files-with-irregular-separators
sedFread<-function(file, sedCmd=NULL, ...){
  require(data.table)
  if(is.null(sedCmd)){
    #default : sed for convert blank separated table to csv. Thanks NeronLevelu !
    sedCmd <- "'s/^[[:blank:]]*//;s/[[:blank:]]\\{1,\\}/,/g'"
  }
  #sed into temp file
  tmpPath<-tempfile(pattern='tmp',fileext='.txt')
  sysCmd<-paste('sed',sedCmd, file, '>',tmpPath)
  try(system(sysCmd))
  DT<-fread(tmpPath,...)
  try(system(paste('rm',tmpPath)))
  return(DT)
}

DT<-fread("./idaho_housing.csv",sep=',', data.table=TRUE, header=TRUE)
DT[DT$ST==16, .N]   #NUM records with st=16. 16 stands for idaho
DT[DT$VAL==24, .N, by=FES]  #same as above, byt gorup by FES

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",paste(getwd(),"ngap.xlsx",sep='/'), "wget")

dat=read.xlsx(paste(getwd(),"ngap.xlsx",sep='/'),1, startRow=18, endRow=23,colIndex=c(7,8,9,10,11,12,13,14,15))

sum(dat$Zip*dat$Ext,na.rm=T)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",paste(getwd(),"balt_restaurants.xml",sep='/'), "wget") 

#read an xml file https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
#furl="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" #did not work
#doc=xmlTreeParse(furl, useInternal=TRUE)

doc<-xmlTreeParse(paste(getwd(),"balt_restaurants.xml",sep='/'), useInternal=TRUE, isURL=F)

rootNode=xmlRoot(doc)
xmlName(rootNode)
r<-xpathSApply(rootNode,"//name",xmlValue)
z<-xpathSApply(rootNode,"//zipcode",xmlValue)
rz<-cbind(r,z)
rzdt<-data.table(rz)
colnames(rzdt) <- c("Name","Zip")
setnames(rzdt,c("Name","Zip"),c("name","zip"))  #this function is better performing that colnames()
rzdt[rzdt$Zip==21231,.N, by=Zip]
DT[DT$VAL==24, .N, by=FES]
View(DT[DT$VAL==24]) #pop up the table on toplevel to view.




#####
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",paste(getwd(),"idaho_pid.csv",sep='/'), "wget")
DT<-fread("./idaho_pid.csv",sep=',', data.table=TRUE, header=TRUE)

system.time(mean(DT$pwgtp15,by=DT$SEX))

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(rowMeans(DT)[DT$SEX==1]); system.time(rowMeans(DT)[DT$SEX==2])
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); system.time(mean(DT[DT$SEX==2,]$pwgtp15))

###############################
##Assignment cmds
#subject files combined
setwd("~/coursera/datasciencecoursera/getdata-008/download/UCI HAR Dataset")
library(data.table)
DT<-fread("./test/subject_test.txt",sep=',', data.table=TRUE, header=F)
DTT<-fread("./train/subject_train.txt",sep='\n', data.table=TRUE, header=F)
library(sqldf)
View(sqldf("select 'TEST', V1, count(*) from DT group by V1 UNION ALL SELECT 'TRAIN', V1, COUNT(*) FROM DTT GROUP BY V1"))
write.csv(file="m/subject_summary.csv",sqldf("select 'TEST', V1, count(*) NumRecs from DT group by V1 UNION ALL SELECT 'TRAIN', V1, COUNT(*) NumRecs FROM DTT GROUP BY V1"))
l<-list(DT,DTT)
write.csv(C, file="m/subject.csv",row.names=F)

##### start sticghing data togetehr
#TEST data
XT<-read.table("./test/X_test.txt",header=F)
yT<-read.table("./test/y_test.txt",header=F)
#paste vertical (column bind) X and y on Test folder data
XyT<-cbind(XT,yT)
#write.table(XyT,"m/Xy_test.txt")
write.table(XyT,"m/Xy_test.txt", col.names=F)

XyTchk <-read.table("m/Xy_test.txt")

#TRAIN data
XR<-read.table("./train/X_train.txt",header=F)
yR<-read.table("./train/y_train.txt",header=F)

#paste vertical (column bind) X and y on Test folder data
XyR<-cbind(XR,yR)
#write.table(XyR,"m/Xy_train.txt")
write.table(XyR,"m/Xy_train.txt", col.names=F)
XyRchk <-read.table("m/Xy_train.txt")

#combine Test and Train togethe
XyTR<-rbind(XyT,XyR)  
write.table(XyTR,"m/XyTstTrn.txt", col.names=F)


###################################

##dynamically pullout all the mean and stddev 
flds<-read.table("features.txt", header=F)
flds<-read.table("features.txt", header=F, stringsAsFactors=F)
library(sqldf)
j1<-sqldf("select V1, V2 from flds where V2 like '%Mean%' or V2 like 'jm%' or V2 like '%std%'")
write.table(j1, file="m/meandtd_features.txt", row.names=F, col.names=F)
##Keep the column map for new codebook with all mean and stddev values
write.table(co,"m/meanstd_fatures_withMeanstdIdxMap.txt", col.names=F, row.names=T)

##read the mean std features and create data frame with mean and std columns
co<-read.table("m/meandtd_features.txt", header=F, stringsAsFactors=F)
mycols<-paste("V",co[,1],sep="")
head(XyTRchk[,mycols])
XyTRmeanstd<-XyTRchk[,mycols]
write.table(XyTRmeanstd, 'm/XyTRmeanstd.txt', col.names=F,row.names=F)


