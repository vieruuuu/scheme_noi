from strutils import replace

import component

proc render*(data: openArray[string]): string =
  getFile("keyboardLocale.html")

  result = file.replace("$data", data.genList)
