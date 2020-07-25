from ../../constants import B64Alphabet
from ../../constants import B64UrlAlphabet

from ../../types import Base64Types
from ../../types import Base64Status
from ../../types import Base64
from ../../types import Base64Pad
from ../../types import Base64Url
from ../../types import Base64UrlPad

import encodedLength

proc encode*(btype: typedesc[Base64Types], inbytes: openarray[byte],
             outstr: var openarray[char], outlen: var int): Base64Status =
  ## Encode array of bytes ``inbytes`` using BASE64 encoding and store
  ## result to ``outstr``.
  ##
  ## On success ``Base64Status.Success`` will be returned and ``outlen`` will
  ## be set to number of characters stored inside of ``outstr``.
  ##
  ## If length of ``outstr`` is not enough then ``Base64Status.Overrun`` will
  ## be returned and ``outlen`` will be set to number of characters required.
  when (btype is Base64) or (btype is Base64Pad):
    const alphabet = B64Alphabet
  elif (btype is Base64Url) or (btype is Base64UrlPad):
    const alphabet = B64UrlAlphabet

  let length = len(inbytes)
  if len(outstr) < btype.encodedLength(length):
    outlen = btype.encodedLength(length)
    result = Base64Status.Overrun
  else:
    var offset = 0
    var i = 0
    while i < (length - 2):
      outstr[offset] = chr(alphabet.encode[(inbytes[i] shr 2) and 0x3F'u8])
      inc(offset)
      outstr[offset] = chr(alphabet.encode[((inbytes[i] and 0x03) shl 4) or
                                            ((inbytes[i + 1] and 0xF0) shr 4)])
      inc(offset)
      outstr[offset] = chr(alphabet.encode[((inbytes[i + 1] and 0x0F) shl 2) or
                                            ((inbytes[i + 2] and 0xC0) shr 6)])
      inc(offset)
      outstr[offset] = chr(alphabet.encode[inbytes[i + 2] and 0x3F])
      inc(offset)
      i += 3

    if i < length:
      outstr[offset] = chr(alphabet.encode[(inbytes[i] shr 2) and 0x3F])
      inc(offset)
      if i == length - 1:
        outstr[offset] = chr(alphabet.encode[(inbytes[i] and 0x03) shl 4])
        inc(offset)
        when (btype is Base64Pad) or (btype is Base64UrlPad):
          outstr[offset] = '='
          inc(offset)
      else:
        outstr[offset] = chr(alphabet.encode[((inbytes[i] and 0x03) shl 4) or
                                              ((inbytes[i + 1] and 0xF0) shr 4)])
        inc(offset)
        outstr[offset] = chr(alphabet.encode[(inbytes[i + 1] and 0x0F) shl 2])
        inc(offset)

      when (btype is Base64Pad) or (btype is Base64UrlPad):
        outstr[offset] = '='
        inc(offset)

    outlen = offset
    result = Base64Status.Success

proc encode*(btype: typedesc[Base64Types],
             inbytes: openarray[byte]): string {.inline.} =
  ## Encode array of bytes ``inbytes`` using BASE64 encoding and return
  ## encoded string.
  var size = btype.encodedLength(len(inbytes))
  result = newString(size)
  if btype.encode(inbytes, result.toOpenArray(0, size - 1),
                  size) == Base64Status.Success:
    result.setLen(size)
  else:
    result = ""

export Base64
