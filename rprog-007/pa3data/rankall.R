#best.R
rankall <- function(outcome, num="best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  column_prefix <- "Hospital.30.Day.Death..Mortality..Rates.from."
  allowed_outcome <- c(
    "heart attack",
    "heart failure",
    "pneumonia")
  
  outcome_title <-c(
    "Heart.Attack",
    "Heart.Failure",
    "Pneumonia")
  
  outcome <- tolower(outcome)

  check_outcome <- match(c(outcome), allowed_outcome)
  if (is.na(check_outcome)){
    stop("invalid outcome")
  }
  else if(check_outcome > 0){
    #input of outcome is good.  so read the file and check for state
    df_outcome <- read.csv('outcome-of-care-measures.csv')
    #check if the state input is valid
    state_levels <- levels(df_outcome[,'State'])
    col <- paste(column_prefix, outcome_title[as.numeric(check_outcome)], sep='')
    myout=NULL
    for (state in state_levels){
      #print (state)
      #frame the column name
      statedata <- df_outcome[df_outcome$State == state,c('Hospital.Name','State',col)]
      myrank<-rank(as.numeric(as.vector(statedata[,col])),na.last='keep')
      myresultset<-cbind(statedata,myrank)
      #print(names(myresultset))
      #myresultset <- myresultset[!is.na(myresultset$myrank),]
      if (num == "best"){
        myidx<-1L
      }
      else if(num == "worst"){
        myidx <- nrow(myresultset)
      }
      else{
        myidx <- num
      }
      tmprow  <- myresultset[with(myresultset, order(myrank, Hospital.Name)),c('Hospital.Name','State')][myidx,]
      if(is.na(tmprow$State)){
        tmprow$State<-state
      }
      #print(tmprow)
      if (is.null(myout)){
        myout <- tmprow
        #print(myout)
        #print(is.na(myout))
      }
      else{
        myout <- rbind(myout,tmprow)
      }
    }
    names(myout)[names(myout)=="Hospital.Name"]<-'hospital'
    names(myout)[names(myout)=="State"]<-'state'
    return(myout)
  }
}