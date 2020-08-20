from ../more/aes import AESConfig
from ../more/aes import newAESConfig
from ../more/aes import decryptTextAES

from ../flags import AES_ENCRYPT_KEY
from ../flags import AES_AAD
from ../flags import AES_IV

let config: AESConfig = newAESConfig(AES_ENCRYPT_KEY, AES_AAD, AES_IV)

proc decrypt*(data: string): string =
  result = config.decryptTextAES(data)
