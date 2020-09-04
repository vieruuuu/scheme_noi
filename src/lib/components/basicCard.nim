from strutils import replace

import component

proc render*(name: string, data: string, isFullScreen: bool = false): string =
  getFile("basicCard.html")

  if isFullScreen:
    result = file.replace("is-one-third", "is-full")
  else:
    result = file

  result = result.replace("$name", name)
  result = result.replace("$data", data)
