from strutils import replace
from ../constants import isProd

proc render*(data: string): string =
  when isProd:
    const file: string = staticRead("./header.html")
  else:
    let file: string = readFile("./src/lib/components/header.html")

  result = file.replace("$data", data)
