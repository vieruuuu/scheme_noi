from strutils import replace

import component

proc render*(data: string): string =
  getFile("header.html")

  result = file.replace("$data", data)
