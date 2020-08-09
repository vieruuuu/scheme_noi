from ../more/xxtea import encrypt
from ../more/xxtea import decrypt

const ENCRYPT_KEY* = CompileTime & CompileDate

proc e*(data: string): string {.compileTime.} =
  result = encrypt(data, ENCRYPT_KEY)

proc d*(data: string): string =
  result = decrypt(data, ENCRYPT_KEY)

## basic usage:
## d e "string" -> d(e("string")) -compiled--> d("encryptedstring")
## d e"string" -> d(e(r"string")) -compiled--> d("encryptedrawstring")
