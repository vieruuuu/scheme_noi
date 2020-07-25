from strutils import join

from ../types import ImageData

import base64/encode

proc encode*(img: ImageData): string {.inline.} =
  result = join([$img.width, $img.height, Base64.encode(img.data)], ";")

export ImageData
