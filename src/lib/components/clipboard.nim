from strutils import replace
from ../constants import isProd
import ../functions/genRandId

proc render*(data: string): string =
  when isProd:
    const file: string = staticRead("./clipboard.html")
  else:
    let file: string = readFile("./src/lib/components/clipboard.html")

  result = file.replace("$data", data)
  result = result.replace("$id", id("cc"))
