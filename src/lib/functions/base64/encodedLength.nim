from ../../types import Base64Types

proc encodedLength*(btype: typedesc[Base64Types],
                    length: int): int {.inline.} =
  ## Return estimated length of BASE64 encoded value for plain length
  ## ``length``.
  result = (((length + 2) div 3) * 4) + 1
