from initdata import bob, sue
import shelve

db = shelve.open('people_shelve')
db['bob'] = bob  #add bob
db['sue'] = sue   #add sue
db.close()
