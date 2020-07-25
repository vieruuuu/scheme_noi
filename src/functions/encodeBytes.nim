from base64 import encode
from strutils import join

proc encodeBytes*(bytes: seq[uint8]): string =
  return encode(bytes.join(","))
