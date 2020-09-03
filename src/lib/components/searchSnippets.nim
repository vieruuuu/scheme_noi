from strutils import replace

import component

proc render*(header: string): string =
  getFile("searchSnippets.html")

  result = file.replace("$header", header)
