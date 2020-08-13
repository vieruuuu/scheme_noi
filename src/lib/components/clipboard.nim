from strutils import replace
from random import rand
from ../constants import isProd

proc id(): string =
  result = "cc" & $rand(1000..<10000)

proc render*(data: string): string =
  when isProd:
    const file: string = staticRead("./clipboard.html")
  else:
    let file: string = readFile("./src/lib/components/clipboard.html")

  result = file.replace("$data", data)
  result = result.replace("$id", id())
