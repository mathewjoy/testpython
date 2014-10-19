f_split <- function () {
#ch3 split apply combine
i<- read.csv("dmwr/code/Chapter 2/data_ch2/iris.csv")
#now let em read in the differnt species
specieslist = levels(i$Species)

  f_temp <- function (spname){
    return (i[i$Species==spname,-5])
  }

  split = lapply(specieslist, f_temp)
  return (split)
}

f_apply <- function(){
  split <- f_split()
  mean <- lapply(split, colMeans)
  return(mean)
}