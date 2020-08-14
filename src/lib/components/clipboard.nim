from strutils import replace

import component

import ../functions/genRandId

proc render*(data: string): string =
  getFile("clipboard.html")

  result = file.replace("$data", data)
  result = result.replace("$id", id("cc"))
