
```py
import socket
import struct
import os

# da ping la ip
def ping(ip):
    # TODO: ping la ip, daca raspunde returneaza true, daca nu, false
    pass

# returneaza: 192.168.0.0, 192.168.0.1, 192.168.0.2, 192.168.0.3, ...........192.168.0.255 
def parseCidr(inp):
    res = []
    (ip, cidr) = inp.split('/')
    cidr = int(cidr) 
    host_bits = 32 - cidr
    i = struct.unpack('>I', socket.inet_aton(ip))[0] # note the endianness
    start = (i >> host_bits) << host_bits # clear the host bits
    end = start | ((1 << host_bits) - 1)
    # excludes the first and last address in the subnet
    for i in range(start, end):
        res.append(socket.inet_ntoa(struct.pack('>I',i)))
    
    return res

# fa loop prin ipuri
for ip in parseCidr("192.168.0.0/24"):
    if ping(ip):
        print(ip + " is UP")
```

resurse:
- https://www.labnol.org/internet/find-subnet-mask/25410/
