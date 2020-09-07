from os import `/`
from base64 import decode

from ../constants import isProd

template getFile*(path: string): untyped =
  when isProd:
    const file {.inject.}: string = staticRead("./../../../tmp/components" / path)
  else:
    let file {.inject.}: string = readFile("./src/lib/components" / path)

proc genList*(data: openArray[string], decode = false, separators: array[2,
    string] = ["<li>", "</li>"]): string =
  result = "<ul>"

  for el in data:
    if el == "":
      continue

    var decodedEl: string # only if case

    if decode == true:
      decodedEl = decode(el)
    else:
      decodedEl = el

    result.add separators[0] & decodedEl & separators[1]

  result.add "</ul>"
