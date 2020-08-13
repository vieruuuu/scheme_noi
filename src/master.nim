import jester
from random import randomize

import lib/components/index as index
import lib/components/clipboard as clipboard
import lib/components/header as header

randomize()

proc buildPage(): string =
  result = index.render(
    header.render("Basic Info") &
    clipboard.render("nimic") &

  )

routes:
  get "/":
    resp buildPage()
