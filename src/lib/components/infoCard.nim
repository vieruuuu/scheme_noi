from strutils import replace
from ../constants import isProd

proc genList(data: openArray[string]): string =
  for el in data:
    result.add "<li>" & el & "</li>"

proc render*(title: string, data: openArray[string],
    class: string = "is-info"): string =
  when isProd:
    const file: string = staticRead("./infoCard.html")
  else:
    let file: string = readFile("./src/lib/components/infoCard.html")

  result = file.replace("$title", title)
  result = result.replace("$class", class)
  result = result.replace("$data", genList data)
