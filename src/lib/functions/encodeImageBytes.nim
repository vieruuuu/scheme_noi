from strutils import join

from ../types import ImageData

from base64 import encode

proc encodeImageBytes*(img: ImageData): string {.inline.} =
  result = join([$img.width, $img.height, encode(img.data)], ";")

export ImageData
