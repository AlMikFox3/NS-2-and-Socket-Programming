import socket               # Import socket module
import fractions

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
   l = list(range(3))
   refined_data = []
   refined_data = data.split(' ')
   for i in range(3):
      l[i]= int(refined_data[i])

   f= fractions.gcd(l[0],l[1])
   f= fractions.gcd(f,l[2])

   print f
  
   
	
   #data = raw_input()
   #c.send(str(fact))
c.close() 