###############################
##Assignment cmds
#subject files combined
setwd("~/coursera/datasciencecoursera/getdata-008/download/UCI HAR Dataset")
#library(data.table)
#DT<-fread("./test/subject_test.txt",sep=',', data.table=TRUE, header=F)
#DTT<-fread("./train/subject_train.txt",sep='\n', data.table=TRUE, header=F)
#library(sqldf)
#View(sqldf("select 'TEST', V1, count(*) from DT group by V1 UNION ALL SELECT 'TRAIN', V1, COUNT(*) FROM DTT GROUP BY V1"))
#write.csv(file="m/subject_summary.csv",sqldf("select 'TEST', V1, count(*) NumRecs from DT group by V1 UNION ALL SELECT 'TRAIN', V1, COUNT(*) NumRecs FROM DTT GROUP BY V1"))
#l<-list(DT,DTT)
#$write.csv(C, file="m/subject.csv",row.names=F)

###################################  STEP 1 START ################################
##### start sticghing data togetehr
#TEST data
XT<-read.table("./test/X_test.txt",header=F)
yT<-read.table("./test/y_test.txt",header=F)
#paste vertical (column bind) X and y on Test folder data
XyT<-cbind(XT,yT)
#write.table(XyT,"m/Xy_test.txt")
write.table(XyT,"m/Xy_test.txt", col.names=F, row.names=F)

#XyTchk <-read.table("m/Xy_test.txt")

#TRAIN data
XR<-read.table("./train/X_train.txt",header=F)
yR<-read.table("./train/y_train.txt",header=F)

#paste vertical (column bind) X and y on Test folder data
XyR<-cbind(XR,yR)
#write.table(XyR,"m/Xy_train.txt")
write.table(XyR,"m/Xy_train.txt", col.names=F, row.names=F)
#XyRchk <-read.table("m/Xy_train.txt")

#combine Test and Train togethe
XyTR<-rbind(XyT,XyR)  
write.table(XyTR,"m/XyTstTrn.txt", col.names=F, row.names=F)

#manual check
#XyTRchk <-read.table("m/XyTstTrn.txt")
#summary(XyTRchk)

################################### SETP 1 END ## STEP 2 START ###############################

