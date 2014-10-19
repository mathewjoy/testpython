complete <- function(directory, id=1:332){
  dir<-paste(getwd(),directory,sep='/')
  fn<-sprintf("%03d.csv",id)
  files<-paste(dir,fn,sep="/")
  f_nobs <- function(file){
    print(file)
    return(sum(complete.cases(read.csv(file))))
  }
  return (data.frame(id=id, nobs=sapply(files, f_nobs)))
}
