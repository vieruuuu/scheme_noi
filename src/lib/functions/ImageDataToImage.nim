from flippy import Image
from ../types import ImageData

proc ImageDataToImage*(img: ImageData): Image =
  result = Image()

  result.width = img.width
  result.height = img.height
  result.channels = 4
  result.data = img.data

export Image
