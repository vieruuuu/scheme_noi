from strutils import replace
from ../constants import isProd

proc render*(data: string): string =
  when isProd:
    const file: string = staticRead("./basicinfo.html")
  else:
    let file: string = readFile("./src/lib/components/basicinfo.html")

  result = file.replace("$data", data)
