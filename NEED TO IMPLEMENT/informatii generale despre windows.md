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
asta e mai bun: (le pune pe fiecare pe o linie separata)
```batch
for /f "usebackq skip=1 tokens=*" %i in (`WMIC /Node:localhost /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName ^| findstr /r /v "^$"`) do @echo %i 
```
note: are o linie goala la sfarsit, trebuie stearsa

in c:
```c
// to do
```

# misc

vezi taskurile (poti vedea daca ruleaza kmspico sau chestii de genul)
in batch:
```c
C:\Windows\system32> schtasks /query /fo LIST /v

Folder: \Microsoft\Windows Defender
HostName:                             B33F
TaskName:                             \Microsoft\Windows Defender\MP Scheduled Scan
Next Run Time:                        1/22/2014 5:11:13 AM
Status:                               Ready
Logon Mode:                           Interactive/Background
Last Run Time:                        N/A
Last Result:                          1
Author:                               N/A
Task To Run:                          c:\program files\windows defender\MpCmdRun.exe Scan -ScheduleJob
                                      -WinTask -RestrictPrivilegesScan
Start In:                             N/A
Comment:                              Scheduled Scan
Scheduled Task State:                 Enabled
Idle Time:                            Only Start If Idle for 1 minutes, If Not Idle Retry For 240 minutes
Power Management:                     No Start On Batteries
Run As User:                          SYSTEM
Delete Task If Not Rescheduled:       Enabled
Stop Task If Runs X Hours and X Mins: 72:00:00
Schedule:                             Scheduling data is not available in this format.
Schedule Type:                        Daily
Start Time:                           5:11:13 AM
Start Date:                           1/1/2000
End Date:                             1/1/2100
Days:                                 Every 1 day(s)
Months:                               N/A
Repeat: Every:                        Disabled
Repeat: Until: Time:                  Disabled
Repeat: Until: Duration:              Disabled
Repeat: Stop If Still Running:        Disabled
[..Snip..]
```
in c:
```c
// to do
```
