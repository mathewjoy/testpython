
library(RODBC)
# ODBCINI<-"/opt/odbc_ini/odbc.ini"
# LD<-"/opt/teradata/client/14.10/odbc_64/lib"
# 
# CUR_LD<-Sys.getenv("LD_LIBRARY_PATH")
# print(CUR_LD)
# 
# #Sys.setenv(LD_LIBRARY_PATH=paste(CUR_LD,LD, sep=':'))
# #Sys.setenv(ODBCINI=ODBCINI)
# 
# #UPD_LD<-Sys.getenv("LD_LIBRARY_PATH")
# #print(UPD_LD)
# print(Sys.getenv("ODBCINI"))

odbcDriverConnect <- function (connection = "", case = "nochange", 
                               believeNRows = TRUE, 
                               colQuote, tabQuote = colQuote, 
                               DBMSencoding = "", rows_at_time = 1000, 
                               bulk_add = NULL) 
{ 
  id <- as.integer(1 + runif(1, 0, 1e+05)) 
  stat <- .Call(RODBC:::C_RODBCDriverConnect, 
                as.character(connection), 
                id, as.integer(believeNRows)) 
  if (stat < 0) 
  { 
    warning("ODBC connection failed") 
    return(stat) 
  } 
  ###     res <- .Call(C_RODBCGetInfo, attr(stat, "handle_ptr")) 
  ### Also removed references to res in the following. 
  if (missing(colQuote)) colQuote <- "\"" 
  if (missing(case)) case <- "nochange" 
  switch(case, 
         toupper = case <- 1, 
         oracle = case <- 1, 
         tolower = case <- 2, 
         postgresql = case <- 2, 
         nochange = case <- 0, 
         msaccess = case <- 0, 
         mysql = case <- ifelse(.Platform$OS.type == "windows", 2, 0), 
         stop("Invalid case parameter: nochange | toupper | tolower | common db names")) 
  case <- switch(case + 1, "nochange", "toupper", "tolower") 
  ###   if (is.null(bulk_add)) 
  ###     bulk_add <- .Call(RODBC:::C_RODBCCanAdd, attr(stat, "handle_ptr")) 
  structure(stat, class = "RODBC", case = case, id = id, 
            believeNRows = believeNRows, 
            bulk_add = bulk_add, colQuote = colQuote, tabQuote = tabQuote, 
            encoding = DBMSencoding, rows_at_time = rows_at_time) 
} 

conjm<-odbcDriverConnect("DSN=vmtest;uid=odbc;pwd=dbc")

