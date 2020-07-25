import asyncdispatch
from flippy import Image
from flippy import save

from lib/types import ImageData

import lib/functions/getWindowName
import lib/functions/screenshot
import lib/functions/decodeImageBytes
import lib/functions/ImageDataToImage
import lib/functions/prepImage

let base64Ss: string = screenshot()

# writeFile("sal.tmp.txt", base64Ss)

let data: ImageData = decode(base64Ss)

let img = prepImage(ImageDataToImage(data))

img.save("sal.tmp.png")

# proc main() {.async.} =
#   echo getWindowName()
#   await sleepAsync(1000)
#   asyncCheck main()

# asyncCheck main()

# runForever()

