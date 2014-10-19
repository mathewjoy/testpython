#best.R
rankhospital <- function(state, outcome, num="best") {
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
  state <- toupper(state)
  
  check_outcome <- match(c(outcome), allowed_outcome)
  if (is.na(check_outcome)){
    stop("invalid outcome")
  }
  else if(check_outcome > 0){
    #input of outcome is good.  so read the file and check for state
    df_outcome <- read.csv('outcome-of-care-measures.csv')
    #check if the state input is valid
    state_levels <- levels(df_outcome[,'State'])
    check_state <- match(c(state), state_levels)
    if (is.na(check_state)){
      stop("invalid state")
    }
    else if (check_state > 0){
      #the state input is good
      #frame the column name
      col <- paste(column_prefix, outcome_title[as.numeric(check_outcome)], sep='')
      statedata <- df_outcome[df_outcome$State == state,c('Hospital.Name','State',col)]
      myrank<-rank(as.numeric(as.vector(statedata[,col])),na.last='keep')
      myresultset<-cbind(statedata,myrank)
      myresultset <- myresultset[!is.na(myresultset$myrank),]
      if (num == "best"){
        myidx<-1
      }
      else if(num == "worst"){
        myidx <- nrow(myresultset)
      }
      else{
        myidx <- num
      }
        
      
      myout=myresultset[with(myresultset, order(myrank)),'Hospital.Name'][myidx]
      return(as.vector(myout))
      #return (col)
    }
  }
}