from strutils import replace
from base64 import decode

import component

proc render*(id: string, data: openArray[string]): string =
  getFile("headerCard.html")

  result = file.replace("$id", id)
  result = result.replace("$name", sanitize decode data[1])
  result = result.replace("$data", data.genList true)
