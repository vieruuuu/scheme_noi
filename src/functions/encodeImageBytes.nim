from strutils import join
import ./../lib/base64

proc encode*(width: int32, height: int32, data: seq[byte]): string {.inline.} =
  ## sal cf
  let encoded: string = Base64.encode(data)
  result = join([$width, $height, encoded], ";")
