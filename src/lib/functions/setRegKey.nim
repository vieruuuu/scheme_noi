from winim/inc/windef import HKEY
from winim/inc/windef import KEY_SET_VALUE
from winim/inc/windef import REG_SZ
from winim/inc/windef import BYTE
from winim/inc/windef import MAX_PATH

from winim/inc/winreg import RegOpenKeyExW
from winim/inc/winreg import HKEY_LOCAL_MACHINE
from winim/inc/winreg import RegSetValueExW
from winim/inc/winreg import RegCloseKey

from winim/winstr import winstrConverterStringToLPWSTR
from winim/winstr import `&`
from winim/winstr import `+$`

proc setRegKey*(key: string, name: string, value: string): void =
  var hKey: HKEY

  discard RegOpenKeyExW(HKEY_LOCAL_MACHINE, key, 0, KEY_SET_VALUE, addr hKey)
  discard RegSetValueExW(hKey, name, 0, REG_SZ, cast[ptr BYTE]( &
      string +$value), MAX_PATH)
  discard RegCloseKey(hKey)
