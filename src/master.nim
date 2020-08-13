import jester
from random import randomize

import lib/components/index as index
import lib/components/clipboard as clipboard
import lib/components/header as header
import lib/components/pcname as pcname

randomize()

proc buildPage(): string =
  result = index.render(
    pcname.render("abi regele") &
    header.render("AVs") &
    clipboard.render("nimic")
  )

routes:
  get "/":
    resp buildPage()
