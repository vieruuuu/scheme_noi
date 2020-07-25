from flippy import Image
from flippy import flipVertical
from flippy import getRgba
from flippy import putRgba

proc prepImage*(img: Image): Image =

  result = img.flipVertical()

  for x in 0 ..< result.width:
    for y in 0 ..< result.height:
      var pixel = result.getRgba(x, y)
      (pixel.r, pixel.g, pixel.b) = (pixel.b, pixel.g, pixel.r)
      result.putRgba(x, y, pixel)
