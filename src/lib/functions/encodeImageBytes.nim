from strutils import join

from ../types import ImageData

from ../more/base64 import b64encode

proc encodeImageBytes*(img: ImageData): string {.inline.} =
  result = join([$img.width, $img.height, b64encode(img.data)], ";")

export ImageData
