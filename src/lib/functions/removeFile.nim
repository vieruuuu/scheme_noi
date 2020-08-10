from os import sleep

from ../flags import UNSAFE_REMOVE_FILE

when UNSAFE_REMOVE_FILE:
  from os import tryRemoveFile
else:
  from os import moveFile


proc removeFileOrSleep*(src: string, doSleep: bool = false): void =
  ## TODO: AICI NU MAI FAC VARIANTA RECURSIVA CA POATE AM MEMORY LEAK SI LA ASTA
  const sleepTime: int = 10 # 10 secs

  if doSleep:
    sleep(sleepTime * 1000)

  var worked: bool = true

  when UNSAFE_REMOVE_FILE:
    worked = tryRemoveFile(src)
  else:
    try:
      # rename file from `x` to `x_`
      moveFile(src, src & "_")
    except OSError:
      removeFileOrSleep(src, true)

  if not worked:
    # try to remove file every `sleepTime` secs
    # am nev de asta pt ca daca fisierul este deschis
    # nu pot sterge fisierul
    removeFileOrSleep(src, true)
