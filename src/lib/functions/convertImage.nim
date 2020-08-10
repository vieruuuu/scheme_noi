from flippy import Image
from flippy import flipVertical
from flippy import getRgba
from flippy import putRgba
from ../types import ImageData

proc convertImage*(img: ImageData): Image =
  result = Image()

  result.width = img.width
  result.height = img.height
  result.channels = 4
  result.data = img.data

  result = result.flipVertical()

  for x in 0 ..< result.width:
    for y in 0 ..< result.height:
      var pixel = result.getRgba(x, y)

      (pixel.r, pixel.g, pixel.b) = (pixel.b, pixel.g, pixel.r)

      result.putRgba(x, y, pixel)

export Image
