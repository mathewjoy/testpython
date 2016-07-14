complete <- function(directory, id=1:332){
  dir<-paste(getwd(),directory,sep='/')
  fn<-sprintf("%03d.csv",id)
  files<-paste(dir,fn,sep="/")
  f_nobs <- function(file){
    return(sum(complete.cases(read.csv(file))))
  }
  return (data.frame(nobs=sapply(id, f_nobs)))
}

