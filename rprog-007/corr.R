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
