from initdata import db

'''
Simple way to persist record. KEY==>VALUE in each line. EndRec. on a line for end of Record
and EndDb. for end of database.
'''
ENDREC='EndRec.'
ENDDB='EndDb.'
RECSEP='==>'
#file_name='people-file.txt'
file_name='people-file.txt'
print('2'+ __name__)

def writeDb(db, dbfname=file_name):
    dbf = open(dbfname,'w')
    print('Opened file')
    for keyx in db:
        print(keyx, file=dbf)
        for (name, value) in db[keyx].items():
            print(name + RECSEP + repr(value), file=dbf)
        print(ENDREC, file=dbf)
    print(ENDDB, file=dbf)
    dbf.close()
    print('wrote to file')
    
if __name__ == '__main__':
    writeDb(db)
    