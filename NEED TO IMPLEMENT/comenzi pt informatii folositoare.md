multe comenzi pt extragerea informatiilor, doar salvezi output-ul si gata

# Windows general

```batch
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" # versiune os
wmic qfe get Caption,Description,HotFixID,InstalledOn # patch-uri
driverquery # drivere
hostname
```

# enumerare
```
set # env vars
dir env: # tot env vars dar in powershell
reg query "HKLM\Software\Policies\Microsoft Services\AdmPwd" /v AdmPwdEnabled # laps, probabil neinterestant
WMIC /Node:localhost /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName /Format:List | more  # antivirusi
```

# utilizatori
```
net users %username% # eu
net users # toti utilizatorii
net localgroup # grupuri
net localgroup Administrators # administrator
whoami /all # privilegii
```

# clipboard
```
powershell -command "Get-Clipboard" # merge in cmd, ruleaza powershell
```

# programe
```
dir /a "C:\Program Files"
dir /a "C:\Program Files (x86)"
reg query HKEY_LOCAL_MACHINE\SOFTWARE
```

# servici
```
net start # vezi toate serviciile
```

# wifi
```
# vezi ce wifi-uri sunt salvate
netsh wlan show profile
# vezi ce parola e salvata
netsh wlan show profile <SSID> key=clear
```

# fisiere interesante cu parole
```
C:\Windows\sysprep\sysprep.xml
C:\Windows\sysprep\sysprep.inf
C:\Windows\sysprep.inf
C:\Windows\Panther\Unattended.xml
C:\Windows\Panther\Unattend.xml
C:\Windows\Panther\Unattend\Unattend.xml
C:\Windows\Panther\Unattend\Unattended.xml
C:\Windows\System32\Sysprep\unattend.xml
C:\Windows\System32\Sysprep\unattended.xml
C:\unattend.txt
C:\unattend.inf
```

# mai multe fisiere interesante cu parole
```
$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history
vnc.ini, ultravnc.ini, *vnc*
web.config
php.ini httpd.conf httpd-xampp.conf my.ini my.cnf (XAMPP, Apache, PHP)
SiteList.xml #McAfee
ConsoleHost_history.txt #PS-History
*.gpg
*.pgp
*config*.php
elasticsearch.y*ml
kibana.y*ml
*.p12
*.der
*.csr
*.cer
known_hosts
id_rsa
id_dsa
*.ovpn
anaconda-ks.cfg
hostapd.conf
rsyncd.conf
cesi.conf
supervisord.conf
tomcat-users.xml
*.kdbx
KeePass.config
Ntds.dit
SAM
SYSTEM
FreeSSHDservice.ini
access.log
error.log
server.xml
ConsoleHost_history.txt
setupinfo
setupinfo.bak
key3.db         #Firefox
key4.db         #Firefox
places.sqlite   #Firefox
"Login Data"    #Chrome
Cookies         #Chrome
Bookmarks       #Chrome
History         #Chrome
TypedURLsTime   #IE
TypedURLs       #IE
appcmd.exe
```
