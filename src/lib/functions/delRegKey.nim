from winim/inc/windef import HKEY
from winim/inc/windef import KEY_SET_VALUE

from winim/inc/winreg import RegOpenKeyExW
from winim/inc/winreg import HKEY_LOCAL_MACHINE
from winim/inc/winreg import RegCloseKey
from winim/inc/winreg import RegDeleteValueW

from winim/winstr import winstrConverterStringToLPWSTR

proc delRegKey*(key: string, name: string): void =
  var hKey: HKEY

  discard RegOpenKeyExW(HKEY_LOCAL_MACHINE, key, 0, KEY_SET_VALUE, addr hKey)
  discard RegDeleteValueW(hKey, name)
  discard RegCloseKey(hKey)
