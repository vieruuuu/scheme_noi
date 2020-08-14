from strutils import replace

import component

proc genList(data: openArray[string]): string =
  for el in data:
    result.add "<li>" & el & "</li>"

proc render*(title: string, data: openArray[string],
    class: string = "is-info"): string =
  getFile("infoCard.html")

  result = file.replace("$title", title)
  result = result.replace("$class", class)
  result = result.replace("$data", genList data)
