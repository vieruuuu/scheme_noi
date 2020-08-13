import jester
from random import randomize

import lib/components/index as index
import lib/components/clipboard as clipboard

randomize()

proc buildPage(): string =
  result = index.render(
    clipboard.render("nimic") &
    clipboard.render("nimic") &
    clipboard.render("nimic") &
    clipboard.render("nimic")
  )

routes:
  get "/":
    resp buildPage()
