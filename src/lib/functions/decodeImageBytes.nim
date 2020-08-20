from strutils import split
from strutils import parseInt

from ../types import ImageData

from base64 import decode

proc toByteSeq(data: string): seq[byte] =
  result = newSeq[byte](data.len)
  copyMem(result[0].addr, data[0].unsafeAddr, data.len)

proc decodeImageBytes*(encoded: string): ImageData =
  let data: seq[string] = encoded.split(";")

  result = ImageData()

  result.width = int32 parseint data[0]
  result.height = int32 parseInt data[1]
  result.data = toByteSeq decode data[2]

export ImageData
