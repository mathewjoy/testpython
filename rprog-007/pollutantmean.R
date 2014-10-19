pollutantmean <- function(directory, pollutant, id=1:332){
  dir<-paste(getwd(),directory,sep='/')
  fn<-sprintf("%03d.csv",id)
  files<-paste(dir,fn,sep="/")
  table<-lapply(files, read.csv)
  mydata<-do.call(rbind,table)
  summary(mydata)
  am<-mean(mydata[[pollutant]], na.rm=TRUE)
  round(am, digits=3) 
}