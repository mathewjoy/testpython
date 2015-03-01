from initdata import db
import pickle

pickle_fn = 'person_pickle'
dbf = open(pickle_fn, 'wb')
pickle.dump(db, dbf)
dbf.close()