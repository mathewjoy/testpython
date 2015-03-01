import pickle

file_name = 'person_pickle'

dbf = open(file_name,'rb')
db = pickle.load(dbf)
for key in db:
    print(key ,'=>' ,db[key])

print ([db[key]['name'] for key in db])    #list
print ([(db[key]['name'], db[key]['pay']) for key in db])    #list of tuples

