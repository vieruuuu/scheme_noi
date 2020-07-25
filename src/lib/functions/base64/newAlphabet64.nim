from ../../types import Base64Alphabet

proc newAlphabet64*(s: string): Base64Alphabet =
  doAssert(len(s) == 64)
  for i in 0..<len(s):
    result.encode[i] = cast[uint8](s[i])
  for i in 0..<len(result.decode):
    result.decode[i] = -1
  for i in 0..<len(result.encode):
    result.decode[int(result.encode[i])] = int8(i)
