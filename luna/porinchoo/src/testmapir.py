import imaplib
import socket
import ssl

class IMAP4_TLS(imaplib.IMAP4_SSL): 
    def open(self, host="", port=imaplib.IMAP4_SSL_PORT): 
        self.host = host 
        self.port = port 
        print("host : %s port : %d" % (self.host, self.port))
        self.sock = socket.create_connection((host, port)) 
      
        self.sslobj = ssl.wrap_socket( 
                self.sock, 
                self.keyfile, 
                self.certfile, 
                ssl_version=ssl.PROTOCOL_TLSv1, 
                ) 
        self.file = self.sslobj.makefile('rb')

if __name__ == "__main__":
    print("Calling socket open")
    M = IMAP4_TLS("webmail.comcast.com")
    print("Calling login")
    M.login("cable\jmathe20000", "105gocaN")
    M.select()
    typ, data = M.search(None, 'ALL')
    for num in data[0].split():
        typ, data = M.fetch(num, '(RFC822)')
        print ('Message %s\n%s\n' % (num, data[0][1]))
    M.close()
    M.logout()