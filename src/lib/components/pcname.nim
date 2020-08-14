from strutils import replace

import component

proc render*(name: string): string =
  getFile("pcname.html")

  result = file.replace("$name", name)
