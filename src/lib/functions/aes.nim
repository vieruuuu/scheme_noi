from ../more/aes import AESConfig
from ../more/aes import newAESConfig
from ../more/aes import decryptTextAES
from ../more/aes import encryptTextAES

from ../flags import AES_ENCRYPT_KEY
from ../flags import AES_AAD
from ../flags import AES_IV

var config* {.threadvar.}: AESConfig

config = newAESConfig(AES_ENCRYPT_KEY, AES_AAD, AES_IV)

proc encrypt*(data: string): string =
  result = config.encryptTextAES(data)

proc decrypt*(data: string): string =
  result = config.decryptTextAES(data)
