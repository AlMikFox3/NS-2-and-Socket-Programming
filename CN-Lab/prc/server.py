import socket               # Import socket module

s = socket.socket()         # Create a socket object
host = socket.gethostname() # Get local machine name
port = 12345                # Reserve a port for your service.
s.bind((host, port))        # Bind to the port

s.listen(5) 
c, addr = s.accept()     # Establish connection with client.
print 'Got connection from', addr   
c.send('Thank you for connecting')             # Now wait for client connection.
while True:
   
   data = c.recv(1024)
   #print data
   k = int(data)
   fact = 1
   while k>=1:
   	fact = fact*k;
   	k=k-1
	
   #data = raw_input()
   c.send(str(fact))
c.close()  