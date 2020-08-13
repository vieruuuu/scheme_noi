from strutils import replace
from ../constants import isProd

proc render*(uptime: string): string =
  when isProd:
    const file: string = staticRead("./uptime.html")
  else:
    let file: string = readFile("./src/lib/components/uptime.html")

  result = file.replace("$uptime", uptime)
