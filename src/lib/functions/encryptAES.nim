from ../more/aes import AESConfig
from ../more/aes import newAESConfig
from ../more/aes import encryptTextAES

from ../flags import AES_ENCRYPT_KEY
from ../flags import AES_AAD
from ../flags import AES_IV

proc encrypt*(data: string): string =
  let config: AESConfig = newAESConfig(AES_ENCRYPT_KEY, AES_AAD, AES_IV)
  result = config.encryptTextAES(data)
