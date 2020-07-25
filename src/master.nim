from flippy import Image
from flippy import save

import lib/functions/decodeImageBytes
import lib/functions/ImageDataToImage
import lib/functions/prepImage

let base64Ss = readFile("base64.tmp.txt")

let data: ImageData = decode(base64Ss)

let img = prepImage(ImageDataToImage(data))

img.save("sal.tmp.png")
