from strutils import replace
from base64 import decode

import component

proc render*(id: string, data: openArray[string]): string =
  getFile("headerCard.html")
  var index: int = 0
  var name: string
  var finalData: string = ""
  for info in data:
    if info == "":
      continue

    index += 1

    if index == 1:
      name = decode info
    else:
      finalData.add "<li>" & decode(info) & "</li>"

  result = file.replace("$id", id)
  result = result.replace("$name", name)
  result = result.replace("$data", finalData)
