from strutils import split
from strutils import parseInt

from ../types import ImageData

from ../more/base64 import b64decode

proc decode*(encoded: string): ImageData =
  let data: seq[string] = encoded.split(";")

  result = ImageData()

  result.width = int32 parseint data[0]
  result.height = int32 parseInt data[1]
  result.data = b64decode data[2]

export ImageData
