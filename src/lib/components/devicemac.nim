from strutils import replace

import component

proc render*(mac: string): string =
  getFile("devicemac.html")

  result = file.replace("$mac", mac)
