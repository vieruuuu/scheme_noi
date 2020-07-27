import winim/inc/[windef, winuser]
import winim/winstr

from ../constants import BUFFER_LENGTH

proc getWindowName*(): string =
  var
    lpString: LPWSTR = newWString(BUFFER_LENGTH)
  let
    hWnd: HWND = GetForegroundWindow()

  if hWnd == 0:
    result = "nush"
  else:
    GetWindowTextW(hWnd, lpString, BUFFER_LENGTH)
    result = $lpString

  return result
