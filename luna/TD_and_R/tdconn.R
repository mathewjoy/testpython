require(RJDBC)
#.jinit()
#print(.jclassPath())
require(teradataR)

drv <- JDBC("com.teradata.jdbc.TeraDriver","/opt/jdbc/TD_14.10/terajdbc4.jar")
drv <- JDBC("com.teradata.jdbc.TeraDriver","/opt/jdbc/TD_14.10/tdgssconfig.jar")
#print(drv)

tdc<- dbConnect(drv,"jdbc:teradata://10.90.1.180/database=dbc","dbc","dbc") 
qry<- "select * From retail.area"
#qry<-"select * from dbc.dbcinfo"

print(class(tdc))

print ("I am here 10" )
rs<-dbGetQuery(tdc, qry)
#print(rs)
hist(rs$N_REGIONKEY)
print(summary(rs))

#create a td ddata frame
tdConnect("10.90.1.180","dbc","dbc", "retail", "jdbc")
tdf <- td.data.frame("area", database="retail")
td.freq(tdf,"N_REGIONKEY")
hist(tdf)