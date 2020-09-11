import macros, hashes

from ../more/xxtea import encrypt
from ../more/xxtea import decrypt

type
  # Use a distinct string type so we won't recurse forever
  estring = distinct string

proc e(data: estring, key: int): string =
  result = encrypt(string data, $key)

proc d(data: estring, key: int): string =
  result = decrypt(string data, $key)

var encodedCounter {.compileTime.} = hash(CompileTime & CompileDate) and 0x7FFFFFFF

# Use a term-rewriting macro to change all string literals
macro encrypt*{s}(s: string{lit}): untyped =
  var encodedStr = e(estring($s), encodedCounter)
  result = quote do:
    d(estring(`encodedStr`), `encodedCounter`)
  encodedCounter = (encodedCounter *% 16777619) and 0x7FFFFFFF
