from load_db_file import loadDb
from make_db_file import writeDb

'''
load the data from loaddb and list out all the NAMES
'''
print('3'+__name__)
db=loadDb();
for key in db:
    print(key, db[key], sep='==>')
    if db[key]['name']== 'Tom':
        db[key]['pay']=20000
        print(db[key])
writeDb(db)
        