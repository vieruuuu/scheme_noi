from strutils import replace
from strutils import join

import component

proc render*(data: openArray[string]): string =
  getFile("keylog.html")

  result = file.replace("$data", data.join(" "))
