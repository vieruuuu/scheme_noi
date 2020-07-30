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
