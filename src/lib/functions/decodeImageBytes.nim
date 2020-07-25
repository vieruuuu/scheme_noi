from strutils import split
from strutils import parseInt

from ../types import ImageData

import base64/decode

proc decode*(encoded: string): ImageData =
  let data: seq[string] = encoded.split(";")

  result = ImageData()

  result.width = int32 parseint data[0]
  result.height = int32 parseInt data[1]
  result.data = Base64.decode data[2]
