from ../../types import Base64Types
from ../../types import Base64Pad
from ../../types import Base64UrlPad
from ../../types import Base64
from ../../types import Base64Url

proc decodedLength*(btype: typedesc[Base64Types],
                    length: int): int {.inline.} =
  ## Return estimated length of decoded value of BASE64 encoded value of length
  ## ``length``.
  when (btype is Base64Pad) or (btype is Base64UrlPad):
    result = ((length + 3 - 1) div 3) * 4
  elif (btype is Base64) or (btype is Base64Url):
    result = (length * 4 + 3 - 1) div 3
