from strutils import replace
from ../constants import isProd

proc render*(ip: string): string =
  when isProd:
    const file: string = staticRead("./deviceip.html")
  else:
    let file: string = readFile("./src/lib/components/deviceip.html")

  result = file.replace("$ip", ip)
