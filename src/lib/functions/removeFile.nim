from os import sleep
import hideString

from ../flags import UNSAFE_REMOVE_FILE

when UNSAFE_REMOVE_FILE:
  from os import tryRemoveFile
else:
  from os import moveFile


proc removeFileOrSleep*(src: string): void =
  const sleepTime: int = 10 # 10 secs
  var worked: bool = false

  while not worked:
    when UNSAFE_REMOVE_FILE:
      worked = tryRemoveFile(src)
    else:
      try:
        # rename file from `x` to `x_`
        moveFile(src, src & "_")
        worked = true
      except OSError:
        discard
    if not worked:
      sleep(sleepTime * 1000)
