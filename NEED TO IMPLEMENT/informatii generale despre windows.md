# versiune, hostname, etc

in batch
```batch
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" # versiune os
wmic qfe get Caption,Description,HotFixID,InstalledOn # patch-uri
driverquery # drivere
hostname
```

in C
```c
// vezi tu
```

linkuri folositoare:
- https://docs.microsoft.com/en-us/windows/win32/api/winsock/nf-winsock-gethostname
- https://stackoverflow.com/questions/29944745/get-osversion-in-windows-using-c

din stackoverflow (linkul de sus)
```c
void print_os_info()
{
    OSVERSIONINFOEX info;
    ZeroMemory(&info, sizeof(OSVERSIONINFOEX));
    info.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);

    GetVersionEx(&info);

    printf("Windows version: %u.%u\n", info.dwMajorVersion, info.dwMinorVersion);
}
```

# env vars

**trb sa vad cum sa fac sa filtrez env ca sa nu le vad pe toate alea nefolositoare gen path**

in batch / powershell:
```
set # env vars
dir env: # tot env vars dar in powershell
```

in C:
```c
// to do
```

# AVs
in batch (veche):
```batch
WMIC /Node:localhost /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName /Format:List | more  # antivirusi
```
asta e mai bun: (le pune pe fiecare pe o linie separata):
```batch
for /f "usebackq skip=1 tokens=*" %i in (`WMIC /Node:localhost /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName ^| findstr /r /v "^$"`) do @echo %i 
```
note: are o linie goala la sfarsit, trebuie stearsa

in c:
```c
// to do
```
