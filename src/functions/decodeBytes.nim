from base64 import decode
from strutils import split
from strutils import parseUInt
from sequtils import map
from sugar import `=>`

proc decodeBytes*(bytesBase64: string): seq[uint8] =
  return decode(bytesBase64).split(",").map(x => uint8 parseUInt(x))

