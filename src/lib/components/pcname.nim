from strutils import replace
from ../constants import isProd

proc render*(name: string): string =
  when isProd:
    const file: string = staticRead("./pcname.html")
  else:
    let file: string = readFile("./src/lib/components/pcname.html")

  result = file.replace("$name", name)
