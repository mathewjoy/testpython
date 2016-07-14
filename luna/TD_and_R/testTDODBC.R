# Load RODBC package
library(RODBC)

# Create a connection to the database called "channel"
print("I am here 1")
channel <- odbcConnect("DATABASE", uid="USERNAME", pwd="PASSWORD", believeNRows=FALSE)
print("I am here 2")
# Check that connection is working (Optional)
odbcGetInfo(channel)

# Find out what tables are available (Optional)
Tables <- sqlTables(channel, schema="SCHEMA")

# Query the database and put the results into the data frame "dataframe"
dataframe <- sqlQuery(channel, "
 SELECT *
 FROM
 SCHEMA.DATATABLE")