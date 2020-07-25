import ./../lib/base64
from strutils import split
from strutils import parseInt
from sequtils import map

proc decode*(encoded: string): seq[int32 | seq[byte]] =
  let data: seq[string] = encoded.split(";")

  result = @[parseint data[0], parseInt data[1], Base64.decode data[2]]
