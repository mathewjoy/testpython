#test stuff
setwd("~/coursera/datasciencecoursera/pa3data")

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

#coercing a string column to numeric - all number string will be numeric and nonnumber wil be NA
x=as.vector(outcome[,11])
y=as.numeric(x)

#reanme column called City to MyCity
names(outcome)[names(outcome)=="City"]<-'MyCity'

HArank<-rank(as.numeric(as.vector(outcome[,11])),na.last='keep')

HArankb<-cbind(outcome,HArank)

#number of rows in ma atrix where a = 'A'
nrow(c[a=="A",])

#shows how a vector an be converted to matrix
# > x<-c('a','b', 'c', 'd', 'e','f')
# > x
# [1] "a" "b" "c" "d" "e" "f"
# > y=matrix(x,nrow=2,byrow=TRUE)
# > y
# [,1] [,2] [,3]
# [1,] "a"  "b"  "c" 
# [2,] "d"  "e"  "f" 
# > y=matrix(x,nrow=2,byrow=FALSE)
# > y
# [,1] [,2] [,3]
# [1,] "a"  "c"  "e" 
# [2,] "b"  "d"  "f" 

HArank<-rank(as.numeric(as.vector(outcome[,11])),na.last='keep')

HArankb<-cbind(outcome,HArank)
HArankb[with(HArankb, order(state, HArank)),]

HArankbo<-HArankb[with(HArankb, order(State, HArank, Hospital.name)),]

