from winim/inc/windef import LPWSTR
from winim/inc/windef import HWND

from winim/inc/winuser import GetForegroundWindow
from winim/inc/winuser import GetWindowTextW

from winim/winstr import winstrConverterWStringToLPWSTR
from winim/winstr import newWString
from winim/winstr import `$`

from ../constants import BUFFER_LENGTH

proc getWindowName*(): string =
  var
    lpString: LPWSTR = newWString(BUFFER_LENGTH)
  let
    hWnd: HWND = GetForegroundWindow()

  if hWnd == 0:
    result = "unknown"
  else:
    GetWindowTextW(hWnd, lpString, BUFFER_LENGTH)
    result = $lpString

    if result == "":
      result = "unknown"

  return result
