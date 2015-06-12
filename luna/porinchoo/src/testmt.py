import queue
import threading
import urllib.request
import time
from itertools import repeat

# called by each thread
def get_url(q, url, name, delay):
    q.put(urllib.request.urlopen(url).read())
    while delay > 0:
        time.sleep(delay)
        print(name + " in the get url " + str(delay))
        delay -= 1
    print(name + " over and out")    


if __name__ == '__main__':
    theurls = ["http://google.com", "http://yahoo.com"]
    names= ["t1", "t2"]
    
    q = queue.Queue()
    
    for u in theurls:
        t = threading.Thread(target=get_url, args = (q,u, names[theurls.index(u)],(theurls.index(u)+1)*5) )
        #t.daemon = True
        t.start()
        print("started thread")

    time.sleep(2)
    while (q.qsize() > 0):
        s = q.get()
        print (s)
        time.sleep(1)
        