from os import sleep

from winim/inc/windef import LPWSTR
from winim/inc/windef import HWND

from winim/inc/winuser import GetForegroundWindow
from winim/inc/winuser import GetWindowTextW

from winim/winstr import winstrConverterWStringToLPWSTR
from winim/winstr import newWString
from winim/winstr import `$`

from ../constants import BUFFER_LENGTH

from ../channels import mainThread

type windowNameResult = tuple[worked: bool, data: string]

proc getWindowName(): windowNameResult =
  var
    lpString: LPWSTR = newWString(BUFFER_LENGTH)
  let
    hWnd: HWND = GetForegroundWindow()

  if hWnd == 0:
    result = (false, "")
  else:
    discard GetWindowTextW(hWnd, lpString, BUFFER_LENGTH)

    result = (true, $lpString)

    if result.data == "":
      result.worked = false

proc initWindowNameThread*(): void {.thread.} =
  var prevWindowName: string = ""

  while true:
    let (worked, windowName) = getWindowName()

    if worked == true and windowName != prevWindowName:
      mainThread.send windowName
      prevWindowName = windowName

    sleep(1)
