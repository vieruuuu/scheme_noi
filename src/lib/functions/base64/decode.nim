from ../../constants import B64Alphabet
from ../../constants import B64UrlAlphabet

from ../../types import Base64Types
from ../../types import Base64PadTypes
from ../../types import Base64Status
from ../../types import Base64
from ../../types import Base64Pad
from ../../types import Base64Url
from ../../types import Base64UrlPad
from ../../types import Base64Error

import decodedLength

proc decode*[T: byte|char](btype: typedesc[Base64Types], instr: openarray[T],
             outbytes: var openarray[byte], outlen: var int): Base64Status =
  ## Decode BASE64 string and store array of bytes to ``outbytes``. On success
  ## ``Base64Status.Success`` will be returned and ``outlen`` will be set
  ## to number of bytes stored.
  ##
  ## Length of ``outbytes`` must be equal or more then ``len(instr) + 4``.
  ##
  ## If ``instr`` has characters which are not part of BASE64 alphabet, then
  ## ``Base64Status.Incorrect`` will be returned and ``outlen`` will be set to
  ## ``0``.
  ##
  ## If length of ``outbytes`` is not enough to store decoded bytes, then
  ## ``Base64Status.Overrun`` will be returned and ``outlen`` will be set to
  ## number of bytes required.
  when (btype is Base64) or (btype is Base64Pad):
    const alphabet = B64Alphabet
  elif (btype is Base64Url) or (btype is Base64UrlPad):
    const alphabet = B64UrlAlphabet

  if len(instr) == 0:
    outlen = 0
    return Base64Status.Success

  let length = btype.decodedLength(len(instr))
  if length > len(outbytes):
    outlen = length
    return Base64Status.Overrun

  var inlen = len(instr)
  when (btype is Base64PadTypes):
    for i in countdown(inlen - 1, 0):
      if instr[i] != '=':
        break
      dec(inlen)

  let reminder = inlen mod 4
  let limit = inlen - reminder
  var buffer: array[4, byte]
  var i, k: int
  while i < limit:
    for j in 0..<4:
      if (cast[byte](instr[i + j]) and 0x80'u8) != 0:
        outlen = 0
        zeroMem(addr outbytes[0], i + 3)
        return Base64Status.Incorrect
      let ch = alphabet.decode[cast[int8](instr[i + j])]
      if ch == -1:
        outlen = 0
        zeroMem(addr outbytes[0], i + 3)
        return Base64Status.Incorrect
      buffer[j] = cast[byte](ch)
    outbytes[k] = cast[byte]((buffer[0] shl 2) or (buffer[1] shr 4))
    inc(k)
    outbytes[k] = cast[byte]((buffer[1] shl 4) or (buffer[2] shr 2))
    inc(k)
    outbytes[k] = cast[byte]((buffer[2] shl 6) or buffer[3])
    inc(k)
    i += 4

  if reminder > 0:
    if reminder == 1:
      outlen = 0
      return Base64Status.Incorrect

    for j in 0..<reminder:
      if (cast[byte](instr[i + j]) and 0x80'u8) != 0:
        outlen = 0
        return Base64Status.Incorrect
      let ch = alphabet.decode[cast[int8](instr[i + j])]
      if ch == -1:
        outlen = 0
        return Base64Status.Incorrect
      buffer[j] = cast[byte](ch)

    if reminder > 1:
      outbytes[k] = cast[byte]((buffer[0] shl 2) or (buffer[1] shr 4))
      inc(k)
    if reminder > 2:
      outbytes[k] = cast[byte]((buffer[1] shl 4) or (buffer[2] shr 2))
      inc(k)

  outlen = k
  result = Base64Status.Success

proc decode*[T: byte|char](btype: typedesc[Base64Types],
                           instr: openarray[T]): seq[byte] =
  ## Decode BASE64 string ``instr`` and return sequence of bytes as result.
  if len(instr) == 0:
    result = newSeq[byte]()
  else:
    var length = 0
    result = newSeq[byte](btype.decodedLength(len(instr)))
    if btype.decode(instr, result, length) == Base64Status.Success:
      result.setLen(length)
    else:
      raise newException(Base64Error, "Incorrect base64 string")

export Base64
