import shelve

file_name = 'people_shelve'

db = shelve.open(file_name, writeback=True)
print ([db[key]['name'] for key in db])

sue = db['sue']
sue['pay'] = 834.00

from initdata import tom

db['tom2'] = tom
print(db['tom2'])
db['tom2']['name'] = 'Tom2 Name Changed'
print(db['tom2'])
db.close()

## read again to ensure tom changed_name
db = shelve.open(file_name, writeback=True)
print(db['tom2'])
db.close()