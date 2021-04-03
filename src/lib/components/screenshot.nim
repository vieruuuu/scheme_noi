from std/sha1 import secureHash
from std/sha1 import `$`

from os import `/`

import ../more/flippy

import basicCard

import ../functions/decodeImageBytes
import ../functions/convertImage

from ../constants import publicDir

proc render*(data: string): string =
  let imgPath: string = $secureHash(data) & ".png"
  let img: Image = convertImage decodeImageBytes data

  img.save(publicDir / imgPath)

  result = basicCard.render(
    "Screenshot",
    "<figure class=\"image\"><img src=\"/img/" &
    imgPath &
    "\" /></figure>",
    true
  )
