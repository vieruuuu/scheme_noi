**rulezi "arp -a" si vezi ce device-uri mai sunt pe retea (ai ip si mac)**

Folosind MAC-ul descoperi firma folosind o baza de date OUI

![imagine cu comanda](https://cdn.discordapp.com/attachments/727071434530357251/738343923763904582/unknown.png)
(arp -a, arata pe fiecare interfata, 192.168.0.106 e pc-ul)

Wireshark: https://www.wireshark.org/tools/oui-lookup.html 

http://standards-oui.ieee.org/oui.txt

parser facut de mn pt ^^^ in python:

```py
# d4rckh: 6/17/2020
import sys

def lookup(what):
    lookFor = what.replace(":","-").upper()
    with open("oui copy.txt", "r", encoding="utf8") as file:
        a = file.read().split("\n")
        for b in a:
            c = b.split("\t")
            if c[0].split(" ")[0] == lookFor:
                print("---ORGANIZATION---\n" + c[2])
                index = a.index(b)
                address = ""
                next3lines = []
                for i in range(2,5):
                    next3lines.append(a[index + i])
                address = ("\n".join(next3lines)).replace("\t", "")
                print("---ADDRESS---\n" + address)

if not len(sys.argv) > 1:
    while True:
        inP = input("> ")
        lookup(inP)
else:
    inP = sys.argv[1]
    lookup(inP)
```
(nu e foarte bun dar isi face treaba)

verifica daca ai bagat argument cu MAC-ul, daca nu iti baga un prompt cu ``input()`` si foloseste `lookup` sa il caute in .txt

folosind adresa mac din imagine, folosesti scriptul:

![imagine cu routerul](https://cdn.discordapp.com/attachments/727071434530357251/738345071216164914/unknown.png)
(routerul meu, 192.168.0.1 adresa mac luata din prima imagine)

![imagine cu pc](https://cdn.discordapp.com/attachments/727071434530357251/738345276305047562/unknown.png)
(pcul meu, 192.168.0.106, adresa mac luata din prima imagine)

note: ai nevoie doar de primi 3 octeti

note2: scriptul python il folosesti tu sa vezi firma, in client folosesti "arp -a" si atat (am zis ca iti da ip si mac, care il folosesti cu scriptul de sus), daca vrei faci un parser pt `arp -a` in master is implementezi scriptul meu sa iti spuna singur firma pt fiecare device

