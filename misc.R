corr <- function(directory, threshold = 0) {
  tcorr <- function(fname) {
  data <- read.csv(file.path(directory, fname))
  nobs <- sum(complete.cases(data))
  if (nobs > threshold) {
    return (round(cor(data$nitrate, data$sulfate, use="complete.obs"), digits=5))
  }
}
tcorrs <- sapply(list.files(directory), tcorr) #get all correlations + NULLs
tcorrs <- unlist(tcorrs[!sapply(tcorrs, is.null)]) #remove NULLs
return (tcorrs)
}



corr <- function(directory, threshold = 0){
  files <- list.files(directory)
  f_c <- function(file){
    mydata = read.csv(paste(directory,file,sep='/'))
    goodcases <- sum(complete.cases(mydata))
    if (goodcases > threshold){
      return (cor(mydata$nitrate, mydata$sulfate, use='complete.obs'))
    }
  }
  
  out <- sapply(files, f_c)
  out <- unlist(out[!sapply(out, is.null)])
  
  return (out)
  
}
