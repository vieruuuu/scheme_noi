from strutils import replace

import component

proc render*(page: string): string =
  getFile("index.html")

  result = file.replace("$page", page)
