from flippy import save

import lib/functions/decodeImageBytes
import lib/functions/convertImage

let base64Ss = readFile("base64.tmp.txt")

let data: ImageData = decodeImageBytes(base64Ss)

let img: Image = convertImage(data)

img.save("sal.tmp.png")
