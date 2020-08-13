from strutils import replace
from ../constants import isProd

proc render*(mac: string): string =
  when isProd:
    const file: string = staticRead("./devicemac.html")
  else:
    let file: string = readFile("./src/lib/components/devicemac.html")

  result = file.replace("$mac", mac)
