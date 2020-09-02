from ../more/aes import AESConfig
from ../more/aes import newAESConfig
from ../more/aes import decryptTextAES
from ../more/aes import encryptTextAES

from hideString import d

from ../flags import AES_ENCRYPT_KEY
from ../flags import AES_AAD
from ../flags import AES_IV

var config*: AESConfig = newAESConfig(d AES_ENCRYPT_KEY, d AES_AAD, d AES_IV)

proc encrypt*(data: string): string =
  result = config.encryptTextAES(data)

proc decrypt*(data: string): string =
  result = config.decryptTextAES(data)
