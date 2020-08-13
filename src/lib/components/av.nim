from strutils import replace
from ../constants import isProd

proc render*(av: string): string =
  when isProd:
    const file: string = staticRead("./av.html")
  else:
    let file: string = readFile("./src/lib/components/av.html")

  result = file.replace("$av", av)
