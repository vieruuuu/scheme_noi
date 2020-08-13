import jester
from random import randomize

import lib/components/index as index
import lib/components/clipboard as clipboard
import lib/components/header as header
import lib/components/pcname as pcname
import lib/components/uptime as uptime
import lib/components/av as av

randomize()

proc buildPage(): string =
  result = index.render(
    pcname.render("abi regele") &
    header.render("basic info") &
    uptime.render("420 ore") &
    header.render("AVs") &
    av.render("norton") &
    av.render("windows defenders") &
    header.render("Clipboard") &
    clipboard.render("nimic")
  )

routes:
  get "/":
    resp buildPage()
