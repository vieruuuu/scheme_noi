from strutils import replace

import component

proc render*(data: string): string =
  getFile("keylog.html")

  result = file.replace("$data", data)
