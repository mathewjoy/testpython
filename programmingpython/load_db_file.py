import sys

'''
read the records that ware written in Simple way: to persist record. KEY==>VALUE in each line. EndRec. on a line for end of Record
and EndDb. for end of database.
'''
ENDREC='EndRec.'
ENDDB='EndDb.'
RECSEP='==>'
#file_name='people-file.txt'
file_name='people-file.txt'
print('1'+ __name__)

def loadDb(dbfname=file_name):
    dbf = open(dbfname,'r')
    sys.stdin = dbf
    db = {} #empty dict
    person=input()
    while person != ENDDB:
        myrec = {} #init the record
        field = input()
        while field != ENDREC:
            name, value = field.split(RECSEP)
            myrec[name]=eval(value)
            field = input()
        db[person]=myrec    
        person = input()
    dbf.close()  
    return db
    
if __name__ == '__main__':
    xdb = loadDb()
    print (xdb)
