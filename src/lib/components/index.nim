from strutils import replace
from ../constants import isProd

proc render*(page: string): string =
  when isProd:
    const file: string = staticRead("./index.html")
  else:
    let file: string = readFile("./src/lib/components/index.html")

  result = file.replace("$page", page)
