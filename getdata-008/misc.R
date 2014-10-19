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

