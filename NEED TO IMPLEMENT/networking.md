# basic networking

vezi rutele, copy paste:
> Like if you do route print on a compromised machine, you can see if it’s dual-homed and maybe pivot from that machine to the other network you don’t directly have access to


```c
C:\Windows\system32> route print

===========================================================================
Interface List
 18...0c 84 dc 62 60 29 ......Bluetooth Device (Personal Area Network)
 13...00 ff 0c 0d 4f ed ......TAP-Windows Adapter V9
 11...00 0c 29 56 79 35 ......Intel(R) PRO/1000 MT Network Connection
  1...........................Software Loopback Interface 1
 16...00 00 00 00 00 00 00 e0 Microsoft ISATAP Adapter
 15...00 00 00 00 00 00 00 e0 Microsoft ISATAP Adapter #2
 19...00 00 00 00 00 00 00 e0 Microsoft ISATAP Adapter #3
 14...00 00 00 00 00 00 00 e0 Teredo Tunneling Pseudo-Interface
===========================================================================

IPv4 Route Table
===========================================================================
Active Routes:
Network Destination        Netmask          Gateway       Interface  Metric
          0.0.0.0          0.0.0.0      192.168.0.1    192.168.0.104     10
        127.0.0.0        255.0.0.0         On-link         127.0.0.1    306
        127.0.0.1  255.255.255.255         On-link         127.0.0.1    306
  127.255.255.255  255.255.255.255         On-link         127.0.0.1    306
      192.168.0.0    255.255.255.0         On-link     192.168.0.104    266
    192.168.0.104  255.255.255.255         On-link     192.168.0.104    266
    192.168.0.255  255.255.255.255         On-link     192.168.0.104    266
        224.0.0.0        240.0.0.0         On-link         127.0.0.1    306
        224.0.0.0        240.0.0.0         On-link     192.168.0.104    266
  255.255.255.255  255.255.255.255         On-link         127.0.0.1    306
  255.255.255.255  255.255.255.255         On-link     192.168.0.104    266
===========================================================================
Persistent Routes:
  None

IPv6 Route Table
===========================================================================
Active Routes:
 If Metric Network Destination      Gateway
 14     58 ::/0                     On-link
  1    306 ::1/128                  On-link
 14     58 2001::/32                On-link
 14    306 2001:0:5ef5:79fb:8d2:b4e:3f57:ff97/128
                                    On-link
 11    266 fe80::/64                On-link
 14    306 fe80::/64                On-link
 14    306 fe80::8d2:b4e:3f57:ff97/128
                                    On-link
 11    266 fe80::5cd4:9caf:61c0:ba6e/128
                                    On-link
  1    306 ff00::/8                 On-link
 14    306 ff00::/8                 On-link
 11    266 ff00::/8                 On-link
===========================================================================
Persistent Routes:
  None```
  
vezi niste setari si chestii de genul dns

```c
C:\Windows\system32> ipconfig /all

Windows IP Configuration

   Host Name . . . . . . . . . . . . : b33f
   Primary Dns Suffix  . . . . . . . :
   Node Type . . . . . . . . . . . . : Hybrid
   IP Routing Enabled. . . . . . . . : No
   WINS Proxy Enabled. . . . . . . . : No

Ethernet adapter Bluetooth Network Connection:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : Bluetooth Device (Personal Area Network)
   Physical Address. . . . . . . . . : 0C-84-DC-62-60-29
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   
Ethernet adapter Local Area Connection:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : Intel(R) PRO/1000 MT Network Connection
   Physical Address. . . . . . . . . : 00-0C-29-56-79-35
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : fe80::5cd4:9caf:61c0:ba6e%11(Preferred)
   IPv4 Address. . . . . . . . . . . : 192.168.0.104(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Lease Obtained. . . . . . . . . . : Saturday, January 11, 2014 3:53:55 PM
   Lease Expires . . . . . . . . . . : Sunday, January 12, 2014 3:53:55 PM
   Default Gateway . . . . . . . . . : 192.168.0.1
   DHCP Server . . . . . . . . . . . : 192.168.0.1
   DHCPv6 IAID . . . . . . . . . . . : 234884137
   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-18-14-24-1D-00-0C-29-56-79-35
   DNS Servers . . . . . . . . . . . : 192.168.0.1
   NetBIOS over Tcpip. . . . . . . . : Enabled
   ```

vezi porturile deschise

```c
C:\Windows\system32> netstat -ano

Active Connections

  Proto  Local Address          Foreign Address        State           PID
  TCP    0.0.0.0:135            0.0.0.0:0              LISTENING       684
  TCP    0.0.0.0:445            0.0.0.0:0              LISTENING       4
  TCP    0.0.0.0:5357           0.0.0.0:0              LISTENING       4
  TCP    127.0.0.1:5354         0.0.0.0:0              LISTENING       1400
  TCP    192.168.0.104:139      0.0.0.0:0              LISTENING       4
  TCP    [::]:135               [::]:0                 LISTENING       684
  TCP    [::]:445               [::]:0                 LISTENING       4
  TCP    [::]:5357              [::]:0                 LISTENING       4
  UDP    0.0.0.0:5355           *:*                                    1100
  UDP    0.0.0.0:52282          *:*                                    976
  UDP    0.0.0.0:55202          *:*                                    2956
  UDP    0.0.0.0:59797          *:*                                    1400
  UDP    127.0.0.1:1900         *:*                                    2956
  UDP    127.0.0.1:65435        *:*                                    2956
  UDP    192.168.0.104:137      *:*                                    4
  UDP    192.168.0.104:138      *:*                                    4
  UDP    192.168.0.104:1900     *:*                                    2956
  UDP    192.168.0.104:5353     *:*                                    1400
  UDP    192.168.0.104:65434    *:*                                    2956
  UDP    [::]:5355              *:*                                    1100
  UDP    [::]:52281             *:*                                    976
  UDP    [::]:52283             *:*                                    976
  UDP    [::]:55203             *:*                                    2956
  UDP    [::]:59798             *:*                                    1400
  UDP    [::1]:1900             *:*                                    2956
  UDP    [::1]:5353             *:*                                    1400
  UDP    [::1]:65433            *:*                                    2956
  UDP    [fe80::5cd4:9caf:61c0:ba6e%11]:1900  *:*                      2956
  UDP    [fe80::5cd4:9caf:61c0:ba6e%11]:65432  *:*                     2956
  ```

# firewall

vezi daca firewallul din windows e pornit
```c
C:\Windows\system32> netsh firewall show state

Firewall status:
-------------------------------------------------------------------
Profile                           = Standard
Operational mode                  = Enable
Exception mode                    = Enable
Multicast/broadcast response mode = Enable
Notification mode                 = Enable
Group policy version              = Windows Firewall
Remote admin mode                 = Disable

Ports currently open on all network interfaces:
Port   Protocol  Version  Program
-------------------------------------------------------------------
No ports are currently open on all network interfaces.
```
vezi regurile de la firewall:
```c
C:\Windows\system32> netsh firewall show config

Domain profile configuration:
-------------------------------------------------------------------
Operational mode                  = Enable
Exception mode                    = Enable
Multicast/broadcast response mode = Enable
Notification mode                 = Enable

Allowed programs configuration for Domain profile:
Mode     Traffic direction    Name / Program
-------------------------------------------------------------------

Port configuration for Domain profile:
Port   Protocol  Mode    Traffic direction     Name
-------------------------------------------------------------------

ICMP configuration for Domain profile:
Mode     Type  Description
-------------------------------------------------------------------
Enable   2     Allow outbound packet too big

Standard profile configuration (current):
-------------------------------------------------------------------
Operational mode                  = Enable
Exception mode                    = Enable
Multicast/broadcast response mode = Enable
Notification mode                 = Enable

Service configuration for Standard profile:
Mode     Customized  Name
-------------------------------------------------------------------
Enable   No          Network Discovery

Allowed programs configuration for Standard profile:
Mode     Traffic direction    Name / Program
-------------------------------------------------------------------
Enable   Inbound              COMRaider / E:\comraider\comraider.exe
Enable   Inbound              nc.exe / C:\users\b33f\desktop\nc.exe

Port configuration for Standard profile:
Port   Protocol  Mode    Traffic direction     Name
-------------------------------------------------------------------

ICMP configuration for Standard profile:
Mode     Type  Description
-------------------------------------------------------------------
Enable   2     Allow outbound packet too big

Log configuration:
-------------------------------------------------------------------
File location   = C:\Windows\system32\LogFiles\Firewall\pfirewall.log
Max file size   = 4096 KB
Dropped packets = Disable
Connections     = Disable
```
