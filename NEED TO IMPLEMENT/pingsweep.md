
```py
import socket
import struct
import platform    # For getting the operating system name
import subprocess  # For executing a shell command

def ping(host):
    ping = subprocess.Popen(
        ["ping", "-n", "1", host],
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE
    )

    out, error = ping.communicate()
    
    if b"unreachable." in out:
        return False
    else:
        return True

# NOTA:
"""
os.system was replaced by subprocess.call. This avoids shell injection vulnerability in cases where your hostname string might not be validated.
"""


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

IPs = parseCidr("192.168.0.0/24")

for ip in IPs:
    if ping(ip):
        print("IP: " + ip + " IS UP\t (" + str(IPs.index(ip)) + " / " + str(len(IPs)) + ")")
    else:        
        print("IP: " + ip + " IS DOWN\t (" + str(IPs.index(ip)) + " / " + str(len(IPs)) + ")")
```

trebuie sa cauti subnet-ul si sa dai ping, probabil ca merge: ~~os.system("ping " + ip + " | findstr \"Reply from\"")~~ (nup, nu merge)

resurse:
- https://www.labnol.org/internet/find-subnet-mask/25410/
